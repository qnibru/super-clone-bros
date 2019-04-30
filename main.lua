-- Cette ligne permet d'afficher des traces dans la console pendant l'exécution
io.stdout:setvbuf('no')

-- Cette ligne permet de debug dans ZeroBrane
if arg[#arg] == "-debug" then require ("mobdebug").start() end

-- Pixel perfect
love.graphics.setDefaultFilter("nearest")
-------------------------------------------------------------------------------

mario = require("mario")

function love.load()
    -- Dimensions écran
    widthScreen = love.graphics.getWidth()
    heightScreen = love.graphics.getHeight()

    mario.load()
end


function love.update(dt)
    mario.update(dt)
end


function love.draw()
    mario.draw()
end

function love.keypressed(key)
end