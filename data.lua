local util = require("util")
local noise = require("noise")
local graphics = require("graphics")

local biter_sizes = {"small", "medium", "big", "behemoth"}
local loot_scaling = {}
for _, size in pairs(biter_sizes) do
  loot_scaling[size] = settings.startup["biters-for-resources-loot-scaling-" .. size].value
end

local function make_loot(item_name, size, multiplier)
  local count_min = 1 * loot_scaling[size] * multiplier
  local count_max = 3 * loot_scaling[size] * multiplier
  return {{item = item_name, count_min = count_min, count_max = count_max}}
end

local function make_resource_icon(orignal, item_name)
  local filename = "__base__/graphics/icons/" .. item_name .. ".png"

  -- Really this should be using the barrel icon but that would mean doing all the scaling on all the layers.
  -- Furthermore, it would have to be in data-updates which sounds annoying.
  -- So this uses the fluid icon instead :)
  if item_name == "variant-crude-oil-barrel" then
    filename = "__base__/graphics/icons/fluid/crude-oil.png"
  end

  return  {{icon = orignal}, {icon = filename, scale = 0.25, shift = {-8, 8}, icon_size = 64, icon_mipmaps = 4}}
end

local function make_unit_copy(map_color, item_name, size, type)
  local enemy = util.copy(data.raw.unit[size .. "-" .. type])
  enemy.localised_name = {"entity-name.biter-for-resources", {"entity-name." .. enemy.name}, {"entity-name." .. item_name}}
  enemy.name = enemy.name .. ":" .. item_name
  enemy.enemy_map_color = map_color
  enemy.loot = make_loot(item_name, size, 1)
  enemy.icons = make_resource_icon(enemy.icon, item_name)
  enemy.icon = nil
  data:extend{enemy}
end

local function make_resource_units(map_color, item_name, enemy_type)
  for _, size in pairs(biter_sizes) do
    make_unit_copy(map_color, item_name, size, enemy_type)
  end
end

-- See data\base\prototypes\entity\enemy-autoplace-utils.lua Line 130 and Line 154
local count = 1
local function random_penalty(noise_expresssion)
  count = count + 1
  return noise.random_penalty(noise_expresssion, 0.1, {
    x = noise.var("x") + count
  })
end

local function make_worm_copy(resource, item_name, size)
  local worm = util.copy(data.raw.turret[size .. "-worm-turret"])
  worm.localised_name = {"entity-name.biter-for-resources", {"entity-name." .. worm.name}, {"entity-name." .. item_name}}
  worm.name = worm.name .. ":" .. item_name
  worm.enemy_map_color = resource.map_color
  worm.loot =  make_loot(item_name, size, 15)
  worm.icons = make_resource_icon(worm.icon, item_name)
  worm.icon = nil

  -- data\base\prototypes\entity\enemy-autoplace-utils.lua Line 148
  local distance_height_multiplier = worm.autoplace.probability_expression.arguments.source.arguments[1].arguments[2]
  -- data\base\prototypes\entity\enemy-autoplace-utils.lua Line 151 (0.25 + distance_factor * 0.05)
  local distance_limiter = worm.autoplace.probability_expression.arguments.source.arguments[3]

  worm.autoplace = util.copy(resource.autoplace)
  worm.autoplace.force = "enemy"
  worm.autoplace.order = "z" .. worm.autoplace.order
  -- data\core\lualib\resource-autoplace.lua Line 375 (Line 377)
  if item_name == "variant-crude-oil-barrel" then
    worm.autoplace.probability_expression = worm.autoplace.probability_expression.arguments[1]
  end
  worm.autoplace.probability_expression = noise.min(worm.autoplace.probability_expression * distance_height_multiplier, distance_limiter)
  worm.autoplace.probability_expression = random_penalty(worm.autoplace.probability_expression)

  worm.spawn_decoration[2].decorative = "shroom-decal:" .. item_name
  worm.spawn_decoration[3].decorative = "enemy-decal:" .. item_name
  worm.spawn_decoration[4].decorative = "enemy-decal-transparent:" .. item_name

  data:extend{worm}
end

local function make_spawner_copy(resource, item_name, enemy_type)
  local spawner = util.copy(data.raw["unit-spawner"][enemy_type .. "-spawner"])
  spawner.localised_name = {"entity-name.biter-for-resources", {"entity-name." .. spawner.name}, {"entity-name." .. item_name}}
  spawner.name = spawner.name .. ":" .. item_name
  spawner.enemy_map_color = resource.map_color
  spawner.loot = {{item = item_name, count_min = 50, count_max = 150}}
  spawner.icons = make_resource_icon(spawner.icon, item_name)
  spawner.icon = nil
  for _, UnitSpawnDefinition in pairs(spawner.result_units) do
    UnitSpawnDefinition[1] = UnitSpawnDefinition[1] .. ":" .. item_name
  end

  spawner.autoplace = util.copy(resource.autoplace)
  spawner.autoplace.force = "enemy"
  -- data\core\lualib\resource-autoplace.lua Line 375 (Line 377)
  if item_name == "variant-crude-oil-barrel" then
    spawner.autoplace.probability_expression = spawner.autoplace.probability_expression.arguments[1]
  end
  spawner.autoplace.probability_expression = noise.min(spawner.autoplace.probability_expression, 0.25)
  spawner.autoplace.probability_expression = random_penalty(spawner.autoplace.probability_expression)

  spawner.spawn_decoration[3].decorative = "enemy-decal:" .. item_name
  spawner.spawn_decoration[3].spawn_max_radius = 6
  spawner.spawn_decoration[4].decorative = "enemy-decal-transparent:" .. item_name
  spawner.spawn_decoration[4].spawn_min = 2
  spawner.spawn_decoration[4].spawn_max = 10
  spawner.spawn_decoration[4].spawn_max_radius = 12

  data:extend{spawner}
end

local function enemies_for_resource(resource_name)
  local resource = util.copy(data.raw.resource[resource_name])
  local item_name = resource.minable.result

  graphics.enemy_decals(resource.map_color, item_name)
  for _, size in pairs(biter_sizes) do
    make_worm_copy(resource, item_name, size)
  end

  make_resource_units(resource.map_color, item_name, "biter")
  make_spawner_copy(resource, item_name, "biter")
  make_resource_units(resource.map_color, item_name, "spitter")
  make_spawner_copy(resource, item_name, "spitter")

  data.raw.resource[resource_name].autoplace = nil
end

enemies_for_resource("iron-ore")
enemies_for_resource("copper-ore")
enemies_for_resource("stone")
enemies_for_resource("coal")
enemies_for_resource("uranium-ore")

-- oil is special
do
  local resource_name = "crude-oil"
  local item_name = "variant-crude-oil-barrel"
  local resource = util.copy(data.raw.resource[resource_name])

  graphics.enemy_decals(resource.map_color, item_name)
  for _, size in pairs(biter_sizes) do
    make_worm_copy(resource, item_name, size)
  end

  make_resource_units(resource.map_color, item_name, "biter")
  make_spawner_copy(resource, item_name, "biter")
  make_resource_units(resource.map_color, item_name, "spitter")
  make_spawner_copy(resource, item_name, "spitter")

  data.raw.resource[resource_name].autoplace = nil
end

-- no vanilla biters
for _, size in pairs(biter_sizes) do
  data.raw.unit[size .. "-spitter"].autoplace = nil
  data.raw.unit[size .. "-biter"].autoplace = nil
  data.raw.turret[size .. "-worm-turret"].autoplace = nil
end
data.raw["unit-spawner"]["spitter-spawner"].autoplace = nil
data.raw["unit-spawner"]["biter-spawner"].autoplace = nil

--[[ This disables the entire enemy tab in the map gen screen, so evolution cannot be modified. So the autoplace control is kept, but it doesn't do anything.
  data.raw["autoplace-control"]["enemy-base"] = nil

for _, preset in pairs(data.raw["map-gen-presets"].default) do
  if preset.basic_settings and preset.basic_settings.autoplace_controls then
    preset.basic_settings.autoplace_controls["enemy-base"] = nil
  end
end
--]]
