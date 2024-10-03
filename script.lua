-- Auto generated script file --

--hide vanilla armor model
vanilla_model.ARMOR:setVisible(false)
vanilla_model.PLAYER:setVisible(false)
vanilla_model.CAPE:setPos(0, 4, -2)

-- Function to check if another player is looking at you
function isPlayerLookingAtMe(otherPlayer)
    -- Get your position and the other player's position
    local myPos = player:getPos() -- Your position
    local otherPos = otherPlayer:getPos() -- The other player's position

    -- Ensure positions are not nil
    if not myPos or not otherPos then
        return false -- Skip the check if positions can't be retrieved
    end

    -- Calculate the vector from the other player to your position
    local vectorToMe = (myPos - otherPos):normalize()

    -- Get the direction the other player is looking
    local lookDirection = otherPlayer:getLookDir()

    -- Dot product: if close to 1, the player is looking directly at you
    local dotProduct = vectorToMe:dot(lookDirection)

    -- Return true if the dot product is greater than 0.9 (close enough)
    return dotProduct > 0.9
end

-- Function to run every game tick
function onTick()
    local players = world.getPlayers() -- Get all players in the world

    -- Loop through all the players
    for _, otherPlayer in ipairs(players) do
        if otherPlayer:getUUID() ~= player:getUUID() then -- Check if this is not you
            if isPlayerLookingAtMe(otherPlayer) then
                print(otherPlayer:getName() .. " is looking at you!")
            end
        end
    end
end

-- Register the tick function to run every game tick
events.TICK:register(onTick)