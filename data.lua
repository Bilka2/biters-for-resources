local util = require("util")
local noise = require("noise")

local function make_loot(item_name)
  return {{item = item_name, count_min = 1, count_max = 3}}
end

local function resource_enemy_anim(enemyanimation, item_name, repeat_count)
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
  for i = 1,  16 do
    ore_shadow.filenames[i] = "__biters-for-resources__/graphics/background.png"
  end

  table.insert(enemyanimation.layers, ore_shadow)
  table.insert(enemyanimation.layers, ore)
end

local function resource_enemy_run_anim(runanimation, item_name)
  resource_enemy_anim(runanimation, item_name, 16)
end

local function resource_biter_attack_anim(attackanimation, item_name)
  resource_enemy_anim(attackanimation, item_name, 11)
end

local function resource_spitter_attack_anim(attackanimation, item_name)
  resource_enemy_anim(attackanimation, item_name, 28)
end

local function make_enemy_copy(map_color, item_name, size, type)
  local enemy = util.copy(data.raw.unit[size .. "-" .. type])
  enemy.localised_name = {"", {"entity-name." .. item_name}, " ", {"entity-name." .. enemy.name}}
  enemy.name = enemy.name .. ":" .. item_name
  enemy.enemy_map_color = map_color
  enemy.loot = make_loot(item_name)
  resource_enemy_run_anim(enemy.run_animation, item_name)
  if type == "biter" then
    resource_biter_attack_anim(enemy.attack_parameters.animation, item_name)
  else
    resource_spitter_attack_anim(enemy.attack_parameters.animation, item_name)
  end
  data:extend{enemy}
end

local function resource_enemy_decals(map_color, item_name)
  local enemy_decal = util.copy(data.raw["optimized-decorative"]["enemy-decal"])
  enemy_decal.name = enemy_decal.name .. ":" .. item_name
  enemy_decal.pictures =
  {
    {
      filename = "__biters-for-resources__/graphics/enemy-decal/hr-enemy-decal-00.png",
      width = 1016,
      height = 726,
      shift = util.by_pixel(0, 0),
      scale = 0.5
    },
    {
      filename = "__biters-for-resources__/graphics/enemy-decal/hr-enemy-decal-01.png",
      width = 998,
      height = 722,
      shift = util.by_pixel(-4, 1),
      scale = 0.5
    },
    {
      filename = "__biters-for-resources__/graphics/enemy-decal/hr-enemy-decal-02.png",
      width = 1014,
      height = 718,
      shift = util.by_pixel(0, 0),
      scale = 0.5
    },
    {
      filename = "__biters-for-resources__/graphics/enemy-decal/hr-enemy-decal-03.png",
      width = 1010,
      height = 718,
      shift = util.by_pixel(1, 0),
      scale = 0.5
    },
    {
      filename = "__biters-for-resources__/graphics/enemy-decal/hr-enemy-decal-04.png",
      width = 862,
      height = 722,
      shift = util.by_pixel(4, 0),
      scale = 0.5
    },
    {
      filename = "__biters-for-resources__/graphics/enemy-decal/hr-enemy-decal-05.png",
      width = 920,
      height = 578,
      shift = util.by_pixel(14, -1),
      scale = 0.5
    },
    {
      filename = "__biters-for-resources__/graphics/enemy-decal/hr-enemy-decal-06.png",
      width = 968,
      height = 708,
      shift = util.by_pixel(3, -2),
      scale = 0.5
    },
    {
      filename = "__biters-for-resources__/graphics/enemy-decal/hr-enemy-decal-07.png",
      width = 1016,
      height = 722,
      shift = util.by_pixel(0, -1),
      scale = 0.5
    }
  }

  local enemy_decal_t = util.copy(data.raw["optimized-decorative"]["enemy-decal-transparent"])
  enemy_decal_t.name = enemy_decal_t.name .. ":" .. item_name
  enemy_decal_t.pictures =
  {
    {
      filename = "__biters-for-resources__/graphics/enemy-decal/hr-enemy-decal-t-00.png",
      width = 1016,
      height = 720,
      shift = util.by_pixel(0, -2),
      scale = 0.5
    },
    {
      filename = "__biters-for-resources__/graphics/enemy-decal/hr-enemy-decal-t-01.png",
      width = 936,
      height = 570,
      shift = util.by_pixel(-3, 23),
      scale = 0.5
    },
    {
      filename = "__biters-for-resources__/graphics/enemy-decal/hr-enemy-decal-t-02.png",
      width = 848,
      height = 540,
      shift = util.by_pixel(-43, 23),
      scale = 0.5
    },
    {
      filename = "__biters-for-resources__/graphics/enemy-decal/hr-enemy-decal-t-03.png",
      width = 968,
      height = 690,
      shift = util.by_pixel(4, -7),
      scale = 0.5
    },
    {
      filename = "__biters-for-resources__/graphics/enemy-decal/hr-enemy-decal-t-04.png",
      width = 800,
      height = 720,
      shift = util.by_pixel(7, -2),
      scale = 0.5
    },
    {
      filename = "__biters-for-resources__/graphics/enemy-decal/hr-enemy-decal-t-05.png",
      width = 846,
      height = 496,
      shift = util.by_pixel(17, 3),
      scale = 0.5
    },
    {
      filename = "__biters-for-resources__/graphics/enemy-decal/hr-enemy-decal-t-06.png",
      width = 916,
      height = 602,
      shift = util.by_pixel(6, 9),
      scale = 0.5
    },
    {
      filename = "__biters-for-resources__/graphics/enemy-decal/hr-enemy-decal-t-07.png",
      width = 1004,
      height = 710,
      shift = util.by_pixel(3, -3),
      scale = 0.5
    }
  }

  local tint = util.copy(map_color)
  if item_name == "coal" then
    tint = {0.2, 0.2, 0.2}
  end

  for _, v in pairs(enemy_decal.pictures) do
    v.tint = tint
  end
  for _, v in pairs(enemy_decal_t.pictures) do
    v.tint = tint
  end

  data:extend{enemy_decal}
  data:extend{enemy_decal_t}
end

local function resource_spawner_anim(spawner_idle_animation, item_name)
  for variation = 0, 3 do
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

-- See new_random_seed() in data\base\prototypes\entity\enemy-autoplace-utils.lua Line 130
local count = 1
local function make_resource_enemies(resource, item_name, enemy_type)
  local map_color = resource.map_color
  make_enemy_copy(map_color, item_name, "small", enemy_type)
  make_enemy_copy(map_color, item_name, "medium", enemy_type)
  make_enemy_copy(map_color, item_name, "big", enemy_type)
  make_enemy_copy(map_color, item_name, "behemoth", enemy_type)

  local spawner = util.copy(data.raw["unit-spawner"][enemy_type .. "-spawner"])
  spawner.localised_name = {"", {"entity-name." .. item_name}, " ", {"entity-name." .. spawner.name}}
  spawner.name = spawner.name .. ":" .. item_name
  spawner.enemy_map_color = map_color
  spawner.loot = {{item = item_name, count_min = 50, count_max = 150}}
  for _, anim in pairs(spawner.animations) do
    resource_spawner_anim(anim, item_name)
  end
  for _, UnitSpawnDefinition in pairs(spawner.result_units) do
    UnitSpawnDefinition[1] = UnitSpawnDefinition[1] .. ":" .. item_name
  end
  spawner.autoplace = util.copy(resource.autoplace)
  spawner.autoplace.force = "enemy"
  spawner.autoplace.probability_expression = spawner.autoplace.probability_expression * 0.25
  count = count + 1
  spawner.autoplace.probability_expression = noise.random_penalty(spawner.autoplace.probability_expression, 0.1, {
    x = noise.var("x") + count
  })

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
  resource_enemy_decals(resource.map_color, item_name)
  make_resource_enemies(resource, item_name, "biter")
  make_resource_enemies(resource, item_name, "spitter")

  data.raw.resource[resource_name].autoplace = nil
end

enemies_for_resource("iron-ore")
enemies_for_resource("copper-ore")
enemies_for_resource("stone")
enemies_for_resource("coal")
enemies_for_resource("uranium-ore")
