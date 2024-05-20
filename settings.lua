local biter_sizes = {"small", "medium", "big", "behemoth"}
for _, size in pairs(biter_sizes) do
  data:extend{{
    type = "double-setting",
    name = "biters-for-resources-loot-scaling-" .. size,
    setting_type = "startup",
    default_value = 1,
    minimum_value = 0.5,
    maximum_value = 100,
    order = "a",
  }}
end
