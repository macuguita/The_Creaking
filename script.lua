-- Auto generated script file --
-- Hide vanilla armor model
vanilla_model.ARMOR:setVisible(false)
vanilla_model.PLAYER:setVisible(false)
vanilla_model.CAPE:setPos(0, 4, -2)

function isBeingLookedAt()
    -- Get the player's position and head position
    local myPosition = player:getPos()
    local myHeadPosition = myPosition + vec(0, 1.6, 0) -- Assuming head height is 1.6 blocks

    -- Iterate through all players in the world
    for _, otherPlayer in pairs(world.getPlayers()) do
        if otherPlayer ~= player then
            local eyePos = otherPlayer:getPos() + vec(0, otherPlayer:getEyeHeight(), 0)
            local eyeEnd = eyePos + (otherPlayer:getLookDir() * 20)

            -- Perform raycast to check if the other player is looking at me
            local entity, hitPos = raycast:entity(eyePos, eyeEnd, function(x)
                return x == player
            end)

            if entity then
                return true -- Another player is looking at me
            end
        end
    end
    return false -- No one is looking at me
end

-- Helper function to check if a line intersects with a point (myPosition)
function lineIntersects(start, endPoint, point)
    local lineDirection = (endPoint - start):normalize()
    local pointToStart = point - start

    local t = pointToStart:dot(lineDirection)

    if t < 0 or t > (endPoint - start):length() then
        return false -- Point is not on the line segment
    end

    local closestPoint = start + lineDirection * t
    return (closestPoint - point):length() < 0.5 -- Adjust threshold as necessary
end

function events.tick()
    if isBeingLookedAt() then
        print("You are being watched")
    else
        print("You are NOT being watched")
    end
end
