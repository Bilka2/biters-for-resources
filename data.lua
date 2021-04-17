local util = require("util")

local function make_loot(resource_name)
  local lootEntry = {item = resource_name}
  return {lootEntry}
end

local function resource_biter_run_anim(biterrunanimation, tint)
  biterrunanimation.layers[2].tint = tint
  biterrunanimation.layers[2].hr_version.tint = tint
  biterrunanimation.layers[3].tint = tint
  biterrunanimation.layers[3].hr_version.tint = tint
end

local function make_biter_copy(resource, item_name, size)
  local biter = util.copy(data.raw.unit[size .. "-biter"])
  biter.name = biter.name .. ":" .. item_name
  biter.loot = make_loot(item_name)
  resource_biter_run_anim(biter.run_animation, resource.map_color)
  -- TODO Bilka: new corpse?
  -- TODO Bilka: change attack_parameters.animation
  data:extend{biter}
end

local function resource_spawner_anim(spawner_idle_animation, tint)
  spawner_idle_animation.layers[2].tint = tint
  spawner_idle_animation.layers[2].hr_version.tint = tint
end

local function make_resource_biters(resource, item_name)
  make_biter_copy(resource, item_name, "small")
  make_biter_copy(resource, item_name, "medium")
  make_biter_copy(resource, item_name, "big")
  make_biter_copy(resource, item_name, "behemoth")

  local spawner = util.copy(data.raw["unit-spawner"]["biter-spawner"])
  spawner.name = spawner.name .. ":" .. item_name
  spawner.loot = make_loot(item_name)
  for _, anim in pairs(spawner.animations) do
    resource_spawner_anim(anim, resource.map_color)
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
