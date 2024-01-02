minetest.log("action", "[strategymobs_init] Loading...")

stent.start_location = vector.new(0, 1, 0)

local player_menu_data = {}

---@param p_name string
---@param arenas_data stent.arena_data[]
---@return table
local function fs_tree_creator(p_name, arenas_data)
	local listelems = {}
	local menu_data = player_menu_data[p_name] or {}
	for i, arena_data in ipairs(arenas_data) do
		local str = "Waiting"
		if arena_data.in_queue then
			str = "Queueing"
		end
		if arena_data.in_loading then
			str = "Loading"
		end
		if arena_data.in_game then
			str = "In Progress"
		end
		if arena_data.in_celebration then
			str = "Finishing"
		end
		if arena_data.enabled == false then
			str = "Disabled"
		end
		local entry = arena_data.name ..
			"     " .. arena_data.players_inside .. "/" .. arena_data.max_players .. "     " .. str
		table.insert(listelems, entry)
	end
	local tree = {
		{ type = "size",   w = 10.5, h = 11, fixed_size = false },
		---{ type = "image",  x = 0,    y = 0,  w = 10.5,          h = 2.6, texture_name = "header.png" },
		{ type = "button", x = 0,    y = 3,  w = 10.5,          h = 0.8, name = "btn1", label = "Available Arenas" },
		{
			type = "textlist",
			x = 0,
			y = 3.8,
			w = 10.5,
			h = 3,
			name = "arena_list_example",
			listelems = listelems,
			selected_idx = menu_data.selected_idx or 1,
			transparent = true
		},
		{ type = "button", x = .3,  y = 7.2, w = 3.1, h = 0.8, name = "join",     label = "Join Queue" },
		{ type = "button", x = 3.7, y = 7.2, w = 3.3, h = 0.8, name = "leave",    label = "Leave Queue" },
		{ type = "button", x = 7.1, y = 7.2, w = 3.1, h = 0.8, name = "spectate", label = "Spectate" },
	}
	return tree
end

---@param p_name string
---@param arenas_data stent.arena_data[]
---@diagnostic disable-next-line: duplicate-set-field
function stent.build_mainmenu_formspec(p_name, arenas_data)
	local tree = fs_tree_creator(p_name, arenas_data)
	return formspec_ast.interpret(tree)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "" and formname ~= "main_menu" then return end

	local p_name = player:get_player_name()

	if fields.arena_list_example then
		local evt = minetest.explode_textlist_event(fields.arena_list_example)
		if evt.type == "CHG" then
			player_menu_data[p_name].selected_idx = evt.index
		end
	end

	if fields.join then
		local data = stent.saved_arenas_data[player_menu_data[p_name].selected_idx]
		local arena_id, arena = arena_lib.get_arena_by_name(data.mod, data.name)
		if arena.in_game then
			arena_lib.join_arena(data.mod, p_name, arena_id)
			stent.refresh_formspecs()
		else
			arena_lib.join_queue(data.mod, arena, p_name)
			stent.refresh_formspecs()
		end
	end

	if fields.leave then
		arena_lib.remove_player_from_queue(p_name)
		stent.refresh_formspecs()
	end

	if fields.spectate then
		local data = stent.saved_arenas_data[player_menu_data[p_name].selected_idx]
		local arena_id, arena = arena_lib.get_arena_by_name(data.mod, data.name)
		local modref = arena_lib.mods[data.mod]

		if arena.in_game and modref.spectate_mode then
			arena_lib.join_arena(data.mod, p_name, arena_id, true)
			stent.refresh_formspecs()
		end
	end
end)

minetest.register_on_mods_loaded(function()
	minetest.log("action", "[strategymobs_init] Loading arena 1")

	if not (arena_lib.get_arena_by_name("strategymobs", "arena_1")) then
		stent.create_arena("strategymobs", "arena_1")
	end

	stent.set_arena_props("strategymobs", "arena_1", {
		enabled = true,
		pos1 = vector.new(4, 4, 4),
		pos2 = vector.new(-4, 0, 12),
		min_players = 2,
		max_players = 2,
		spawn_points = {
			vector.new(2, 1, 8),
			vector.new(-2, 1, 8),
		},

		board_pos = vector.new(-1, 1, 7),
		player_1_pos = vector.new(2, 1, 8),
		player_2_pos = vector.new(-2, 1, 8),
	})

	minetest.log("action", "[strategymobs_init] Loading arena 2")

	if not (arena_lib.get_arena_by_name("strategymobs", "arena_2")) then
		stent.create_arena("strategymobs", "arena_2")
	end

	stent.set_arena_props("strategymobs", "arena_2", {
		enabled = true,
		pos1 = vector.new(4, 4, 13),
		pos2 = vector.new(-4, 0, 21),
		min_players = 2,
		max_players = 2,
		spawn_points = {
			vector.new(2, 1, 17),
			vector.new(-2, 1, 17),
		},

		board_pos = vector.new(-1, 1, 16),
		player_1_pos = vector.new(2, 1, 17),
		player_2_pos = vector.new(-2, 1, 17),
	})

	minetest.log("action", "[strategymobs_init] Loading arena 3")

	if not (arena_lib.get_arena_by_name("strategymobs", "arena_3")) then
		stent.create_arena("strategymobs", "arena_3")
	end

	stent.set_arena_props("strategymobs", "arena_3", {
		enabled = true,
		pos1 = vector.new(4, 4, 22),
		pos2 = vector.new(-4, 0, 30),
		min_players = 2,
		max_players = 2,
		spawn_points = {
			vector.new(2, 1, 26),
			vector.new(-2, 1, 26),
		},

		board_pos = vector.new(-1, 1, 25),
		player_1_pos = vector.new(2, 1, 26),
		player_2_pos = vector.new(-2, 1, 26),
	})
end)

minetest.register_on_joinplayer(function(player)
	---Formspec Data
	local p_name = player:get_player_name()
	player_menu_data[p_name] = {}
	player_menu_data[p_name].selected_idx = 1 -- Select fist arena

	---Builtin Stuff
	player:hud_set_flags({
		hotbar = false,
		healthbar = false,
		minimap = false,
	})

	player:set_properties({
		mesh = "character.b3d",
		textures = { "character.png" },
		visual = "mesh",
		visual_size = { x = 1, y = 1 },
		stepheight = 1.47
	})
end)

minetest.register_on_leaveplayer(function(player, timed_out)
	local p_name = player:get_player_name()
	player_menu_data[p_name] = nil
end)

minetest.log("action", "[strategymobs_init] Loaded successfully")
