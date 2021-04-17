local util = require("util")
local noise = require("noise")

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

-- See new_random_seed() in data\base\prototypes\entity\enemy-autoplace-utils.lua Line 130
local count = 1
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
  count = count + 1
  worm.autoplace.probability_expression = noise.random_penalty(worm.autoplace.probability_expression, 0.1, {
    x = noise.var("x") + count -- See new_random_seed() in data\base\prototypes\entity\enemy-autoplace-utils.lua Line 130
  })

  worm.spawn_decoration[2].decorative = "shroom-decal:" .. item_name
  worm.spawn_decoration[3].decorative = "enemy-decal:" .. item_name
  worm.spawn_decoration[4].decorative = "enemy-decal-transparent:" .. item_name

  data:extend{worm}
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

  local base_decorative_sprite_priority = "extra-high"
  local shroom_decal = util.copy(data.raw["optimized-decorative"]["shroom-decal"])
  shroom_decal.name = shroom_decal.name .. ":" .. item_name
  shroom_decal.pictures =
  {
    {
      filename = "__biters-for-resources__/graphics/shroom-decal/shroom-decal-00.png",
      priority = base_decorative_sprite_priority,
      width = 166,
      height = 88,
      shift = util.by_pixel(-12, -10),
      hr_version =
      {
        filename = "__biters-for-resources__/graphics/shroom-decal/hr-shroom-decal-00.png",
        priority = base_decorative_sprite_priority,
        width = 334,
        height = 206,
        shift = util.by_pixel(-13, -1),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources__/graphics/shroom-decal/shroom-decal-01.png",
      priority = base_decorative_sprite_priority,
      width = 128,
      height = 94,
      shift = util.by_pixel(12, 6),
      hr_version =
      {
        filename = "__biters-for-resources__/graphics/shroom-decal/hr-shroom-decal-01.png",
        priority = base_decorative_sprite_priority,
        width = 256,
        height = 182,
        shift = util.by_pixel(12, 7),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources__/graphics/shroom-decal/shroom-decal-02.png",
      priority = base_decorative_sprite_priority,
      width = 204,
      height = 96,
      shift = util.by_pixel(-8, -2),
      hr_version =
      {
        filename = "__biters-for-resources__/graphics/shroom-decal/hr-shroom-decal-02.png",
        priority = base_decorative_sprite_priority,
        width = 406,
        height = 194,
        shift = util.by_pixel(-8, -3),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources__/graphics/shroom-decal/shroom-decal-03.png",
      priority = base_decorative_sprite_priority,
      width = 216,
      height = 96,
      shift = util.by_pixel(6, 8),
      hr_version =
      {
        filename = "__biters-for-resources__/graphics/shroom-decal/hr-shroom-decal-03.png",
        priority = base_decorative_sprite_priority,
        width = 432,
        height = 220,
        shift = util.by_pixel(6, 1),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources__/graphics/shroom-decal/shroom-decal-04.png",
      priority = base_decorative_sprite_priority,
      width = 184,
      height = 102,
      shift = util.by_pixel(-12, 8),
      hr_version =
      {
        filename = "__biters-for-resources__/graphics/shroom-decal/hr-shroom-decal-04.png",
        priority = base_decorative_sprite_priority,
        width = 368,
        height = 206,
        shift = util.by_pixel(-12, 7),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources__/graphics/shroom-decal/shroom-decal-05.png",
      priority = base_decorative_sprite_priority,
      width = 170,
      height = 102,
      shift = util.by_pixel(24, 2),
      hr_version =
      {
        filename = "__biters-for-resources__/graphics/shroom-decal/hr-shroom-decal-05.png",
        priority = base_decorative_sprite_priority,
        width = 340,
        height = 200,
        shift = util.by_pixel(24, 3),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources__/graphics/shroom-decal/shroom-decal-06.png",
      priority = base_decorative_sprite_priority,
      width = 162,
      height = 108,
      shift = util.by_pixel(24, 2),
      hr_version =
      {
        filename = "__biters-for-resources__/graphics/shroom-decal/hr-shroom-decal-06.png",
        priority = base_decorative_sprite_priority,
        width = 326,
        height = 214,
        shift = util.by_pixel(23, 2),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources__/graphics/shroom-decal/shroom-decal-07.png",
      priority = base_decorative_sprite_priority,
      width = 168,
      height = 98,
      shift = util.by_pixel(20, 8),
      hr_version =
      {
        filename = "__biters-for-resources__/graphics/shroom-decal/hr-shroom-decal-07.png",
        priority = base_decorative_sprite_priority,
        width = 336,
        height = 190,
        shift = util.by_pixel(20, 9),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources__/graphics/shroom-decal/shroom-decal-08.png",
      priority = base_decorative_sprite_priority,
      width = 192,
      height = 104,
      shift = util.by_pixel(-12, 0),
      hr_version =
      {
        filename = "__biters-for-resources__/graphics/shroom-decal/hr-shroom-decal-08.png",
        priority = base_decorative_sprite_priority,
        width = 386,
        height = 206,
        shift = util.by_pixel(-12, 1),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources__/graphics/shroom-decal/shroom-decal-09.png",
      priority = base_decorative_sprite_priority,
      width = 138,
      height = 78,
      shift = util.by_pixel(8, -12),
      hr_version =
      {
        filename = "__biters-for-resources__/graphics/shroom-decal/hr-shroom-decal-09.png",
        priority = base_decorative_sprite_priority,
        width = 278,
        height = 150,
        shift = util.by_pixel(8, -11),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources__/graphics/shroom-decal/shroom-decal-10.png",
      priority = base_decorative_sprite_priority,
      width = 182,
      height = 100,
      shift = util.by_pixel(2, -2),
      hr_version =
      {
        filename = "__biters-for-resources__/graphics/shroom-decal/hr-shroom-decal-10.png",
        priority = base_decorative_sprite_priority,
        width = 364,
        height = 204,
        shift = util.by_pixel(2, -3),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources__/graphics/shroom-decal/shroom-decal-11.png",
      priority = base_decorative_sprite_priority,
      width = 192,
      height = 104,
      shift = util.by_pixel(22, 4),
      hr_version =
      {
        filename = "__biters-for-resources__/graphics/shroom-decal/hr-shroom-decal-11.png",
        priority = base_decorative_sprite_priority,
        width = 378,
        height = 206,
        shift = util.by_pixel(23, 5),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources__/graphics/shroom-decal/shroom-decal-12.png",
      priority = base_decorative_sprite_priority,
      width = 160,
      height = 108,
      shift = util.by_pixel(-4, 4),
      hr_version =
      {
        filename = "__biters-for-resources__/graphics/shroom-decal/hr-shroom-decal-12.png",
        priority = base_decorative_sprite_priority,
        width = 320,
        height = 220,
        shift = util.by_pixel(-4, 3),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources__/graphics/shroom-decal/shroom-decal-13.png",
      priority = base_decorative_sprite_priority,
      width = 158,
      height = 82,
      shift = util.by_pixel(32, 10),
      hr_version =
      {
        filename = "__biters-for-resources__/graphics/shroom-decal/hr-shroom-decal-13.png",
        priority = base_decorative_sprite_priority,
        width = 318,
        height = 160,
        shift = util.by_pixel(31, 11),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources__/graphics/shroom-decal/shroom-decal-14.png",
      priority = base_decorative_sprite_priority,
      width = 186,
      height = 104,
      shift = util.by_pixel(24, 6),
      hr_version =
      {
        filename = "__biters-for-resources__/graphics/shroom-decal/hr-shroom-decal-14.png",
        priority = base_decorative_sprite_priority,
        width = 368,
        height = 206,
        shift = util.by_pixel(25, 6),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources__/graphics/shroom-decal/shroom-decal-15.png",
      priority = base_decorative_sprite_priority,
      width = 208,
      height = 112,
      shift = util.by_pixel(-6, 0),
      hr_version =
      {
        filename = "__biters-for-resources__/graphics/shroom-decal/hr-shroom-decal-15.png",
        priority = base_decorative_sprite_priority,
        width = 410,
        height = 222,
        shift = util.by_pixel(-5, 0),
        scale = 0.5
      }
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
  for _, v in pairs(shroom_decal.pictures) do
    v.tint = tint
    v.hr_version.tint = tint
  end

  data:extend{enemy_decal}
  data:extend{enemy_decal_t}
  data:extend{shroom_decal}
end

local function make_resource_enemies(resource, item_name, enemy_type)
  local map_color = resource.map_color
  make_unit_copy(map_color, item_name, "small", enemy_type)
  make_unit_copy(map_color, item_name, "medium", enemy_type)
  make_unit_copy(map_color, item_name, "big", enemy_type)
  make_unit_copy(map_color, item_name, "behemoth", enemy_type)

  local spawner = util.copy(data.raw["unit-spawner"][enemy_type .. "-spawner"])
  spawner.localised_name = {"", {"entity-name." .. item_name}, " ", {"entity-name." .. spawner.name}}
  spawner.name = spawner.name .. ":" .. item_name
  spawner.enemy_map_color = map_color
  spawner.loot = {{item = item_name, count_min = 50, count_max = 150}}
  for _, UnitSpawnDefinition in pairs(spawner.result_units) do
    UnitSpawnDefinition[1] = UnitSpawnDefinition[1] .. ":" .. item_name
  end
  spawner.autoplace = util.copy(resource.autoplace)
  spawner.autoplace.force = "enemy"
  spawner.autoplace.probability_expression = spawner.autoplace.probability_expression * 0.25
  count = count + 1
  spawner.autoplace.probability_expression = noise.random_penalty(spawner.autoplace.probability_expression, 0.1, {
    x = noise.var("x") + count -- See new_random_seed() in data\base\prototypes\entity\enemy-autoplace-utils.lua Line 130
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
  make_worm_copy(resource, item_name, "small")
  make_worm_copy(resource, item_name, "medium")
  make_worm_copy(resource, item_name, "big")
  make_worm_copy(resource, item_name, "behemoth")
  make_resource_enemies(resource, item_name, "biter")
  make_resource_enemies(resource, item_name, "spitter")

  data.raw.resource[resource_name].autoplace = nil
end

enemies_for_resource("iron-ore")
enemies_for_resource("copper-ore")
enemies_for_resource("stone")
enemies_for_resource("coal")
enemies_for_resource("uranium-ore")
