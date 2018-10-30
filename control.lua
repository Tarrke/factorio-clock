require("gameclock")


-- when creating a new game, initialize data structure
script.on_init(
function()
	gclock.mod_init()
end
)


-- When a player is joining, create the UI for them
script.on_event(defines.events.on_player_created, function(event)
	gclock.log("player created")
    local player = game.players[event.player_index]
    gclock.create_button(player)
end)

-- if the version of the mod or any other version changed
script.on_configuration_changed(gclock.mod_init)

script.on_event(defines.events.on_tick, function(event)
    if (event.tick % 60 == 0) then
        gclock.update_time()
    end
end)