local GridFov = require('src.scenes.gridFov')
local PreciseFov = require('src.scenes.preciseFov')

local currentScene = PreciseFov

function love.load()
    currentScene.load()
end

function love.update(dt)
    currentScene.update(dt)
end

function love.draw()
    currentScene.draw()
end