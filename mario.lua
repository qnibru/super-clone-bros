local mario = {}
    mario.spritesheet = love.graphics.newImage("assets/images/mario_alt.png")
    mario.sprite = {}
    mario.spriteType = {}
    mario.imgCurrent = 1

    mario.zoom = 4

    mario.x = 100
    mario.y = 100
    mario.vx = 0
    mario.vy = 0
    mario.jumpHeight = -300
    mario.gravity = 500

    mario.run = false
    mario.flip = false


SPRITE_WIDTH = 15
SPRITE_HEIGHT = 19

function mario.load()

    local nbLines = mario.spritesheet:getHeight() / SPRITE_HEIGHT
    local nbColumns = mario.spritesheet:getWidth() / SPRITE_WIDTH

    local l,c
    local id = 1
    mario.sprite[0] = nil

    for l=1, nbLines do 
        for c=1, nbColumns do
            mario.sprite[id] = love.graphics.newQuad(
                (c-1)*SPRITE_WIDTH,
                (l-1)*SPRITE_HEIGHT,
                SPRITE_WIDTH,
                SPRITE_HEIGHT,
                mario.spritesheet:getWidth(),
                mario.spritesheet:getHeight()
            )

            id = id + 1
        end
    end
    
    mario.spriteType[0] = nil
    mario.spriteType[1] = "idle"
    mario.spriteType[2] = "run"
    mario.spriteType[3] = "run"
    mario.spriteType[4] = "run"
    mario.spriteType[5] = "runblock"
    mario.spriteType[7] = "jump"
    mario.spriteType[8] = "dead"
    mario.spriteType[9] = "idle"
    mario.spriteType[10] = "swim"
    mario.spriteType[11] = "swim"
    mario.spriteType[12] = "swim"
    mario.spriteType[13] = "swim"
    mario.spriteType[14] = "swim"
    mario.spriteType[15] = "swim"

end



function mario.update(dt)

    if love.keyboard.isDown("q") or love.keyboard.isDown("d") then
       
        -- Animation de mario qui court
        mario.imgCurrent = mario.imgCurrent + 20*dt
        if mario.imgCurrent > 14 then
            mario.imgCurrent = 2
        end

        mario.vx =  mario.vx  + 8*dt
            if math.abs(mario.vx) > 6.5 then 
                mario.vx = 6.5
            end

        if love.keyboard.isDown("q") then
            mario.x = mario.x - mario.vx
            mario.flip = true

        elseif love.keyboard.isDown("d") then
            mario.x = mario.x + mario.vx
            mario.flip = false
        end
        
    else
        mario.imgCurrent = 1
        mario.vx = 4
    end


    
 
    if love.keyboard.isDown("z") then
        -- Vérifie si Mario est bien au sol
        if mario.vy == 0 then
            mario.vy = mario.jumpHeight
            print("saut")
        end
    end
    
    -- Action de saut
    if mario.vy ~= 0 then
        mario.y = mario.y + mario.vy*dt
    end
    
    -- Fait redescendre
    if mario.y < 0 then
        mario.vy = mario.vy + mario.gravity*dt*5
    end

    -- Remet Mario au niveau du sol
    if mario.y > 100 then 
        mario.y = 100
        mario.imgCurrent = 1
        mario.vy = 0
    end

    if mario.vy ~= 0 then
        mario.imgCurrent = 14
    end
end




function mario.draw()
    if mario.flip == false then
        love.graphics.draw(mario.spritesheet, mario.sprite[math.floor(mario.imgCurrent)], mario.x, mario.y, 0, mario.zoom, mario.zoom)
    elseif mario.flip == true then
        love.graphics.draw(mario.spritesheet, mario.sprite[math.floor(mario.imgCurrent)], mario.x, mario.y, 0, -mario.zoom, mario.zoom, 16)

        --love.graphics.draw(texture, quad, x, y, r, sx, sy, ox, oy, kx, ky )
    end

    love.graphics.print(mario.vx,0,0)
    love.graphics.print(mario.vy, 10, 10)

end

return mario