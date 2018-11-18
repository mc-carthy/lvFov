local CELL_SIZE = 20
local GRID_X_SIZE, GRID_Y_SIZE = math.floor(love.graphics.getWidth() / CELL_SIZE), math.floor(love.graphics.getHeight() / CELL_SIZE)
local CELL_BORDER_SIZE = 1
local map = {}
local numSquaresToFill = 500

function love.load()
    visibleCanvas = love.graphics.newCanvas()
    exploredCanvas = love.graphics.newCanvas()
    createMap(numSquaresToFill)
end

function love.update(dt)

end

function love.draw()
    love.graphics.setCanvas(visibleCanvas)
        love.graphics.clear()
        love.graphics.setBackgroundColor(0, 0, 0, 1)
        for x = 1, GRID_X_SIZE do
            for y = 1, GRID_Y_SIZE do
                if map[x][y] == 0 then
                    love.graphics.setColor(0.75, 0, 0, 1)
                    love.graphics.rectangle('fill', (x - 1) * CELL_SIZE + CELL_BORDER_SIZE, (y - 1) * CELL_SIZE + CELL_BORDER_SIZE, CELL_SIZE - 2 * CELL_BORDER_SIZE, CELL_SIZE - 2 * CELL_BORDER_SIZE)
                end
            end
        end
        -- love.graphics.setColor(0, 0.75, 0, 1)
        -- love.graphics.rectangle('fill', 0, 0, 300, 300)
    love.graphics.setCanvas()

    love.graphics.setCanvas(exploredCanvas)
        love.graphics.clear()
        love.graphics.setBackgroundColor(0, 0, 0, 1)
        for x = 1, GRID_X_SIZE do
            for y = 1, GRID_Y_SIZE do
                if map[x][y] == 1 then
                    love.graphics.setColor(0, 0, 0.75, 1)
                    love.graphics.rectangle('fill', (x - 1) * CELL_SIZE + CELL_BORDER_SIZE, (y - 1) * CELL_SIZE + CELL_BORDER_SIZE, CELL_SIZE - 2 * CELL_BORDER_SIZE, CELL_SIZE - 2 * CELL_BORDER_SIZE)
                end
            end
        end
    love.graphics.setCanvas()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(exploredCanvas)
    love.graphics.draw(visibleCanvas)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key =='space' then
        createMap(numSquaresToFill)
    end
end

function createMap(numSquaresToFill)
    fillGridSquares(numSquaresToFill)
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