local GridFov = require('src.scenes.gridFov')

function love.load()
    GridFov.load()
end

function love.update(dt)
    GridFov.update(dt)
end

function love.draw()
    GridFov.draw()
end