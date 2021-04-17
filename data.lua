local util = require("util")

local function make_loot(resource_name)
  local lootEntry = {item = resource_name}
  return {lootEntry}
end

local function resource_biter_anim(biteranimation, item_name, repeat_count)
  local ore =
  {
    filenames = {},
    slice = 1,
    lines_per_file = 1,
    size = 64,
    scale = 0.25,
    shift = util.by_pixel(0, -16),
    direction_count = 1, -- this is required but doesn't do anything?!
    frame_count = 1,
    repeat_count = repeat_count,
    draw_as_glow = true
  }
  -- hack
  for i=1,16 do
    local variation = math.ceil(i / 4) - 1
    ore.filenames[i] = "__base__/graphics/icons/" .. item_name .. (variation ~= 0 and ("-" .. variation) or "") .. ".png"
  end

  local ore_shadow = util.copy(ore)
  ore_shadow.tint = {0, 0, 0, 0.6}
  for i=1,16 do
    ore_shadow.filenames[i] = "__biters-for-resources__/graphics/background.png"
  end

  table.insert(biteranimation.layers, ore_shadow)
  table.insert(biteranimation.layers, ore)
end

local function resource_biter_run_anim(biterrunanimation, item_name)
  resource_biter_anim(biterrunanimation, item_name, 16)
end

local function resource_biter_attack_anim(biterrunanimation, item_name)
  resource_biter_anim(biterrunanimation, item_name, 11)
end

local function make_biter_copy(resource, item_name, size)
  local biter = util.copy(data.raw.unit[size .. "-biter"])
  biter.localised_name = {"", {"entity-name." .. item_name}, " ", {"entity-name." .. biter.name}}
  biter.name = biter.name .. ":" .. item_name
  biter.enemy_map_color = resource.map_color
  biter.loot = make_loot(item_name)
  resource_biter_run_anim(biter.run_animation, item_name)
  -- TODO Bilka: new corpse?
  resource_biter_attack_anim(biter.attack_parameters.animation, item_name)
  data:extend{biter}
end

local function resource_spawner_anim(spawner_idle_animation, item_name)
  for variation=0,3 do
    local ore =
    {
      filename = "__base__/graphics/icons/" .. item_name .. (variation ~= 0 and ("-" .. variation) or "") .. ".png",
      size = 64,
      scale = 0.5,
      shift = util.by_pixel(math.random(-46, 46), math.random(-32, 32)),
      direction_count = 1,
      frame_count = 1,
      repeat_count = 16,
      draw_as_glow = true
    }
    local ore_shadow = util.copy(ore)
    ore_shadow.tint = {0, 0, 0, 0.5}
    ore_shadow.filename = "__biters-for-resources__/graphics/background.png"

    table.insert(spawner_idle_animation.layers, ore_shadow)
    table.insert(spawner_idle_animation.layers, ore)
  end
end

local function make_resource_biters(resource, item_name)
  make_biter_copy(resource, item_name, "small")
  make_biter_copy(resource, item_name, "medium")
  make_biter_copy(resource, item_name, "big")
  make_biter_copy(resource, item_name, "behemoth")

  local spawner = util.copy(data.raw["unit-spawner"]["biter-spawner"])
  spawner.localised_name = {"", {"entity-name." .. item_name}, " ", {"entity-name." .. spawner.name}}
  spawner.name = spawner.name .. ":" .. item_name
  spawner.enemy_map_color = resource.map_color
  spawner.loot = make_loot(item_name)
  for _, anim in pairs(spawner.animations) do
    resource_spawner_anim(anim, item_name)
  end
  -- TODO Bilka: new corpse?
  for _, UnitSpawnDefinition in pairs(spawner.result_units) do
    UnitSpawnDefinition[1] = UnitSpawnDefinition[1] .. ":" .. item_name
  end
  spawner.autoplace = resource.autoplace
  spawner.autoplace.force = "enemy"
  data:extend{spawner}
end


local function enemies_for_resource(resource_name)
  local resource = util.copy(data.raw.resource[resource_name])
  local item_name = resource.minable.result
  make_resource_biters(resource, item_name)

  data.raw.resource[resource_name].autoplace = nil
end

enemies_for_resource("iron-ore")
enemies_for_resource("copper-ore")
enemies_for_resource("stone")
enemies_for_resource("coal")
