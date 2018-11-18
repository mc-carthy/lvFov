local CELL_SIZE = 20
local GRID_X_SIZE, GRID_Y_SIZE = math.floor(love.graphics.getWidth() / CELL_SIZE), math.floor(love.graphics.getHeight() / CELL_SIZE)
local CELL_BORDER_SIZE = 1
local map = {}
local numSquaresToFill = 500

function love.load()
    fillGridSquares(numSquaresToFill)
end

function love.update(dt)

end

function love.draw()
    love.graphics.setBackgroundColor(0, 0, 0, 1)
    for x = 1, GRID_X_SIZE do
        for y = 1, GRID_Y_SIZE do
            if map[x][y] == 1 then
                love.graphics.setColor(0, 0, 0, 1)
            else
                love.graphics.setColor(1, 1, 1, 1)
            end
            love.graphics.rectangle('fill', (x - 1) * CELL_SIZE + CELL_BORDER_SIZE, (y - 1) * CELL_SIZE + CELL_BORDER_SIZE, CELL_SIZE - 2 * CELL_BORDER_SIZE, CELL_SIZE - 2 * CELL_BORDER_SIZE)
        end
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key =='space' then
        fillGridSquares(numSquaresToFill)
    end
end

function initMap()
    for x = 1, GRID_X_SIZE do
        map[x] = {}
        for y = 1, GRID_Y_SIZE do
            map[x][y] = 0
        end
    end
end

function fillGridSquares(squaresToFill)
    initMap()
    for i = 1, squaresToFill do
        map[love.math.random(1, GRID_X_SIZE)][love.math.random(1, GRID_Y_SIZE)] = 1
    end
end