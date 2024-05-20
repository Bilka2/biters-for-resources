local graphics = {}

graphics.enemy_decals = function(map_color, item_name)
  local enemy_decal = util.copy(data.raw["optimized-decorative"]["enemy-decal"])
  enemy_decal.name = enemy_decal.name .. ":" .. item_name
  enemy_decal.pictures =
  {
    {
      filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/enemy-decal-00.png",
      width = 508,
      height = 364,
      shift = util.by_pixel(0, 0),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/hr-enemy-decal-00.png",
        width = 1016,
        height = 726,
        shift = util.by_pixel(0, 0),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/enemy-decal-01.png",
      width = 494,
      height = 316,
      shift = util.by_pixel(-8, 24),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/hr-enemy-decal-01.png",
        width = 998,
        height = 722,
        shift = util.by_pixel(-4, 1),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/enemy-decal-02.png",
      width = 508,
      height = 360,
      shift = util.by_pixel(0, 0),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/hr-enemy-decal-02.png",
        width = 1014,
        height = 718,
        shift = util.by_pixel(0, 0),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/enemy-decal-03.png",
      width = 508,
      height = 360,
      shift = util.by_pixel(0, -2),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/hr-enemy-decal-03.png",
        width = 1010,
        height = 718,
        shift = util.by_pixel(1, 0),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/enemy-decal-04.png",
      width = 422,
      height = 362,
      shift = util.by_pixel(4, 0),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/hr-enemy-decal-04.png",
        width = 862,
        height = 722,
        shift = util.by_pixel(4, 0),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/enemy-decal-05.png",
      width = 456,
      height = 292,
      shift = util.by_pixel(16, -2),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/hr-enemy-decal-05.png",
        width = 920,
        height = 578,
        shift = util.by_pixel(14, -1),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/enemy-decal-06.png",
      width = 482,
      height = 322,
      shift = util.by_pixel(4, 14),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/hr-enemy-decal-06.png",
        width = 968,
        height = 708,
        shift = util.by_pixel(3, -2),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/enemy-decal-07.png",
      width = 508,
      height = 360,
      shift = util.by_pixel(0, 0),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/hr-enemy-decal-07.png",
        width = 1016,
        height = 722,
        shift = util.by_pixel(0, -1),
        scale = 0.5
      }
    }
  }

  local enemy_decal_t = util.copy(data.raw["optimized-decorative"]["enemy-decal-transparent"])
  enemy_decal_t.name = enemy_decal_t.name .. ":" .. item_name
  enemy_decal_t.pictures =
  {
    {
      filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/enemy-decal-t-00.png",
      width = 508,
      height = 360,
      shift = util.by_pixel(0, -2),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/hr-enemy-decal-t-00.png",
        width = 1016,
        height = 720,
        shift = util.by_pixel(0, -2),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/enemy-decal-t-01.png",
      width = 470,
      height = 288,
      shift = util.by_pixel(-4, 22),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/hr-enemy-decal-t-01.png",
        width = 936,
        height = 570,
        shift = util.by_pixel(-3, 23),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/enemy-decal-t-02.png",
      width = 422,
      height = 272,
      shift = util.by_pixel(-42, 22),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/hr-enemy-decal-t-02.png",
        width = 848,
        height = 540,
        shift = util.by_pixel(-43, 23),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/enemy-decal-t-03.png",
      width = 484,
      height = 344,
      shift = util.by_pixel(4, -6),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/hr-enemy-decal-t-03.png",
        width = 968,
        height = 690,
        shift = util.by_pixel(4, -7),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/enemy-decal-t-04.png",
      width = 402,
      height = 360,
      shift = util.by_pixel(6, -2),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/hr-enemy-decal-t-04.png",
        width = 800,
        height = 720,
        shift = util.by_pixel(7, -2),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/enemy-decal-t-05.png",
      width = 426,
      height = 250,
      shift = util.by_pixel(16, 2),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/hr-enemy-decal-t-05.png",
        width = 846,
        height = 496,
        shift = util.by_pixel(17, 3),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/enemy-decal-t-06.png",
      width = 458,
      height = 300,
      shift = util.by_pixel(6, 10),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/hr-enemy-decal-t-06.png",
        width = 916,
        height = 602,
        shift = util.by_pixel(6, 9),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/enemy-decal-t-07.png",
      width = 504,
      height = 358,
      shift = util.by_pixel(2, -4),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/enemy-decal/hr-enemy-decal-t-07.png",
        width = 1004,
        height = 710,
        shift = util.by_pixel(3, -3),
        scale = 0.5
      }
    }
  }

  local base_decorative_sprite_priority = "extra-high"
  local shroom_decal = util.copy(data.raw["optimized-decorative"]["shroom-decal"])
  shroom_decal.name = shroom_decal.name .. ":" .. item_name
  shroom_decal.pictures =
  {
    {
      filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/shroom-decal-00.png",
      priority = base_decorative_sprite_priority,
      width = 166,
      height = 88,
      shift = util.by_pixel(-12, -10),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/hr-shroom-decal-00.png",
        priority = base_decorative_sprite_priority,
        width = 334,
        height = 206,
        shift = util.by_pixel(-13, -1),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/shroom-decal-01.png",
      priority = base_decorative_sprite_priority,
      width = 128,
      height = 94,
      shift = util.by_pixel(12, 6),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/hr-shroom-decal-01.png",
        priority = base_decorative_sprite_priority,
        width = 256,
        height = 182,
        shift = util.by_pixel(12, 7),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/shroom-decal-02.png",
      priority = base_decorative_sprite_priority,
      width = 204,
      height = 96,
      shift = util.by_pixel(-8, -2),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/hr-shroom-decal-02.png",
        priority = base_decorative_sprite_priority,
        width = 406,
        height = 194,
        shift = util.by_pixel(-8, -3),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/shroom-decal-03.png",
      priority = base_decorative_sprite_priority,
      width = 216,
      height = 96,
      shift = util.by_pixel(6, 8),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/hr-shroom-decal-03.png",
        priority = base_decorative_sprite_priority,
        width = 432,
        height = 220,
        shift = util.by_pixel(6, 1),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/shroom-decal-04.png",
      priority = base_decorative_sprite_priority,
      width = 184,
      height = 102,
      shift = util.by_pixel(-12, 8),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/hr-shroom-decal-04.png",
        priority = base_decorative_sprite_priority,
        width = 368,
        height = 206,
        shift = util.by_pixel(-12, 7),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/shroom-decal-05.png",
      priority = base_decorative_sprite_priority,
      width = 170,
      height = 102,
      shift = util.by_pixel(24, 2),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/hr-shroom-decal-05.png",
        priority = base_decorative_sprite_priority,
        width = 340,
        height = 200,
        shift = util.by_pixel(24, 3),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/shroom-decal-06.png",
      priority = base_decorative_sprite_priority,
      width = 162,
      height = 108,
      shift = util.by_pixel(24, 2),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/hr-shroom-decal-06.png",
        priority = base_decorative_sprite_priority,
        width = 326,
        height = 214,
        shift = util.by_pixel(23, 2),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/shroom-decal-07.png",
      priority = base_decorative_sprite_priority,
      width = 168,
      height = 98,
      shift = util.by_pixel(20, 8),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/hr-shroom-decal-07.png",
        priority = base_decorative_sprite_priority,
        width = 336,
        height = 190,
        shift = util.by_pixel(20, 9),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/shroom-decal-08.png",
      priority = base_decorative_sprite_priority,
      width = 192,
      height = 104,
      shift = util.by_pixel(-12, 0),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/hr-shroom-decal-08.png",
        priority = base_decorative_sprite_priority,
        width = 386,
        height = 206,
        shift = util.by_pixel(-12, 1),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/shroom-decal-09.png",
      priority = base_decorative_sprite_priority,
      width = 138,
      height = 78,
      shift = util.by_pixel(8, -12),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/hr-shroom-decal-09.png",
        priority = base_decorative_sprite_priority,
        width = 278,
        height = 150,
        shift = util.by_pixel(8, -11),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/shroom-decal-10.png",
      priority = base_decorative_sprite_priority,
      width = 182,
      height = 100,
      shift = util.by_pixel(2, -2),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/hr-shroom-decal-10.png",
        priority = base_decorative_sprite_priority,
        width = 364,
        height = 204,
        shift = util.by_pixel(2, -3),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/shroom-decal-11.png",
      priority = base_decorative_sprite_priority,
      width = 192,
      height = 104,
      shift = util.by_pixel(22, 4),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/hr-shroom-decal-11.png",
        priority = base_decorative_sprite_priority,
        width = 378,
        height = 206,
        shift = util.by_pixel(23, 5),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/shroom-decal-12.png",
      priority = base_decorative_sprite_priority,
      width = 160,
      height = 108,
      shift = util.by_pixel(-4, 4),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/hr-shroom-decal-12.png",
        priority = base_decorative_sprite_priority,
        width = 320,
        height = 220,
        shift = util.by_pixel(-4, 3),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/shroom-decal-13.png",
      priority = base_decorative_sprite_priority,
      width = 158,
      height = 82,
      shift = util.by_pixel(32, 10),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/hr-shroom-decal-13.png",
        priority = base_decorative_sprite_priority,
        width = 318,
        height = 160,
        shift = util.by_pixel(31, 11),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/shroom-decal-14.png",
      priority = base_decorative_sprite_priority,
      width = 186,
      height = 104,
      shift = util.by_pixel(24, 6),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/hr-shroom-decal-14.png",
        priority = base_decorative_sprite_priority,
        width = 368,
        height = 206,
        shift = util.by_pixel(25, 6),
        scale = 0.5
      }
    },
    {
      filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/shroom-decal-15.png",
      priority = base_decorative_sprite_priority,
      width = 208,
      height = 112,
      shift = util.by_pixel(-6, 0),
      hr_version =
      {
        filename = "__biters-for-resources-tweaked__/graphics/shroom-decal/hr-shroom-decal-15.png",
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
    v.hr_version.tint = tint
  end
  for _, v in pairs(enemy_decal_t.pictures) do
    v.tint = tint
    v.hr_version.tint = tint
  end
  for _, v in pairs(shroom_decal.pictures) do
    v.tint = tint
    v.hr_version.tint = tint
  end

  data:extend{enemy_decal}
  data:extend{enemy_decal_t}
  data:extend{shroom_decal}
end

return graphics
