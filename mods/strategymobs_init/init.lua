minetest.log("action", "[strategymobs_init] Loading...")

stent.start_location = vector.new(0, 1, 0)

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
	player:hud_set_flags({
		hotbar = false,
		healthbar = false,
		minimap = false,
	})
end)

minetest.log("action", "[strategymobs_init] Loaded successfully")
