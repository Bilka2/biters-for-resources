local util = require("util")
local noise = require("noise")
local graphics = require("graphics")

local function make_loot(item_name)
  return {{item = item_name, count_min = 1, count_max = 3}} -- TODO Bilka: vary by size?
end

local function make_unit_copy(map_color, item_name, size, type)
  local enemy = util.copy(data.raw.unit[size .. "-" .. type])
  enemy.localised_name = {"", {"entity-name." .. item_name}, " ", {"entity-name." .. enemy.name}}
  enemy.name = enemy.name .. ":" .. item_name
  enemy.enemy_map_color = map_color
  enemy.loot = make_loot(item_name)
  data:extend{enemy}
end

local function make_resource_units(resource, item_name, enemy_type)
  local map_color = resource.map_color
  make_unit_copy(map_color, item_name, "small", enemy_type)
  make_unit_copy(map_color, item_name, "medium", enemy_type)
  make_unit_copy(map_color, item_name, "big", enemy_type)
  make_unit_copy(map_color, item_name, "behemoth", enemy_type)
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
  worm.localised_name = {"", {"entity-name." .. item_name}, " ", {"entity-name." .. worm.name}}
  worm.name = worm.name .. ":" .. item_name
  worm.enemy_map_color = resource.map_color
  worm.loot =  {{item = item_name, count_min = 25, count_max = 75}} -- TODO Bilka: this correct? vary by size?

  -- data\base\prototypes\entity\enemy-autoplace-utils.lua Line 146
  local distance_height_multiplier = worm.autoplace.probability_expression.arguments.source.arguments[1].arguments[2]
  -- data\base\prototypes\entity\enemy-autoplace-utils.lua Line 151 (0.25 + distance_factor * 0.05)
  local distance_limiter = worm.autoplace.probability_expression.arguments.source.arguments[3]

  worm.autoplace = util.copy(resource.autoplace)
  worm.autoplace.force = "enemy"
  worm.autoplace.order = "z" .. worm.autoplace.order
  worm.autoplace.probability_expression = noise.min(worm.autoplace.probability_expression * distance_height_multiplier, distance_limiter)
  worm.autoplace.probability_expression = random_penalty(worm.autoplace.probability_expression)

  worm.spawn_decoration[2].decorative = "shroom-decal:" .. item_name
  worm.spawn_decoration[3].decorative = "enemy-decal:" .. item_name
  worm.spawn_decoration[4].decorative = "enemy-decal-transparent:" .. item_name

  data:extend{worm}
end

local function make_spawner_copy(resource, item_name, enemy_type)
  local spawner = util.copy(data.raw["unit-spawner"][enemy_type .. "-spawner"])
  spawner.localised_name = {"", {"entity-name." .. item_name}, " ", {"entity-name." .. spawner.name}}
  spawner.name = spawner.name .. ":" .. item_name
  spawner.enemy_map_color = resource.map_color
  spawner.loot = {{item = item_name, count_min = 50, count_max = 150}}
  for _, UnitSpawnDefinition in pairs(spawner.result_units) do
    UnitSpawnDefinition[1] = UnitSpawnDefinition[1] .. ":" .. item_name
  end

  spawner.autoplace = util.copy(resource.autoplace)
  spawner.autoplace.force = "enemy"
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
  make_worm_copy(resource, item_name, "small")
  make_worm_copy(resource, item_name, "medium")
  make_worm_copy(resource, item_name, "big")
  make_worm_copy(resource, item_name, "behemoth")

  make_resource_units(resource, item_name, "biter")
  make_spawner_copy(resource, item_name, "biter")
  make_resource_units(resource, item_name, "spitter")
  make_spawner_copy(resource, item_name, "spitter")

  data.raw.resource[resource_name].autoplace = nil
end

enemies_for_resource("iron-ore")
enemies_for_resource("copper-ore")
enemies_for_resource("stone")
enemies_for_resource("coal")
enemies_for_resource("uranium-ore")
