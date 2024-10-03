local attackKeybind = keybinds:fromVanilla("key.attack")

function events.tick()
    local crouching = player:getPose() == "CROUCHING"
    local sprinting = player:isSprinting()
    local blocking = player:isBlocking()
    local fishing = player:isFishing()
    local sleeping = player:getPose() == "SLEEPING"
    local swimming = player:getPose() == "SWIMMING"
    local flying = player:getPose() == "FALL_FLYING"
    local walking = player:getVelocity().xz:length() > .01

    animations.model.attackR:priority(1)
    animations.model.attackL:priority(1)
    animations.model.AnimIdle:setPlaying(not walking and not crouching)
    animations.model.Walk:setPlaying(walking or sprinting)
end
