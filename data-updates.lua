local util = require("__core__/lualib/util")
local multiplier = 10

local barrel = util.copy(data.raw.item["crude-oil-barrel"])
barrel.name = "variant-crude-oil-barrel"
barrel.localised_name = {"item-name.variant-filled-barrel", barrel.localised_name}
barrel.icons[1].tint = util.copy(barrel.icons[2].tint)
barrel.icons[2].tint = barrel.icons[3].tint
barrel.stack_size = barrel.stack_size * multiplier
data:extend{barrel}

data:extend{
  {
    type = "recipe",
    name = "empty-variant-crude-oil-barrel",
    localised_name = {"recipe-name.empty-variant-filled-barrel", barrel.localised_name},
    category = "crafting-with-fluid",
    energy_required = 0.2,
    subgroup = "empty-barrel",
    order = "c[empty-variant-crude-oil-barrel]",
    icons = util.copy(data.raw.recipe["empty-crude-oil-barrel"].icons),
    icon_size = 64, icon_mipmaps = 4,
    enabled = false,
    ingredients =
    {
      {type = "item", name = "variant-crude-oil-barrel", amount = multiplier}
    },
    results=
    {
      {type = "fluid", name = "crude-oil", amount = 50},
    },
    allow_decomposition = false,
    always_show_products = true,
    show_amount_in_title = false
  } --[[@as data.RecipePrototype]]
}
data.raw.recipe["empty-variant-crude-oil-barrel"].icons[1].tint = util.copy(data.raw.recipe["empty-variant-crude-oil-barrel"].icons[2].tint)
data.raw.recipe["empty-variant-crude-oil-barrel"].icons[2].tint = data.raw.recipe["empty-variant-crude-oil-barrel"].icons[3].tint

table.insert(data.raw["technology"]["fluid-handling"].effects, {type = "unlock-recipe", recipe = "empty-variant-crude-oil-barrel"})
