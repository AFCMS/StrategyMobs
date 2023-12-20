minetest.log("action", "[strategymobs_nodes] loading...")

local modpath = minetest.get_modpath("strategymobs_nodes")

-- defripper output
loadfile(modpath .. "/exported.lua")(function(def)
    local myname = ":" .. def._raw_name
    def._raw_name = nil
    minetest.register_node(myname, def)
end)

minetest.log("action", "[strategymobs_nodes] loaded sucessfully")