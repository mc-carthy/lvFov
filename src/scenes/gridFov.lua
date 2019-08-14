local gridFov = {}

local CELL_SIZE = 20
local GRID_X_SIZE, GRID_Y_SIZE = math.floor(love.graphics.getWidth() / CELL_SIZE), math.floor(love.graphics.getHeight() / CELL_SIZE)
local CELL_BORDER_SIZE = 1
local map = {}
local visibleMap = {}
local exploredMap = {}
local numSquaresToFill = 500
local exploredMapDimFactor = 0.5

function gridFov.load()
    visibleCanvas = love.graphics.newCanvas()
    exploredCanvas = love.graphics.newCanvas()
    createMap(numSquaresToFill)
end

function gridFov.update(dt)
    updateFovMap()
end

function gridFov.draw()
    love.graphics.setCanvas(visibleCanvas)
        love.graphics.clear()
        love.graphics.setBackgroundColor(0, 0, 0, 1)
        for x = 1, GRID_X_SIZE do
            for y = 1, GRID_Y_SIZE do
                if visibleMap[x][y] == 1 then
                    if map[x][y] == 0 then
                        love.graphics.setColor(0.75, 0.85, 0.5, 1)
                    else
                        love.graphics.setColor(0.75 * exploredMapDimFactor, 0.85 * exploredMapDimFactor, 0.5 * exploredMapDimFactor, 1)
                    end
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
                if exploredMap[x][y] == 1 then
                    if map[x][y] == 0 then
                        love.graphics.setColor(0.5, 0.75, 0.25, 1)
                    else
                        love.graphics.setColor(0.5 * exploredMapDimFactor, 0.75 * exploredMapDimFactor, 0.25 * exploredMapDimFactor, 1)
                    end
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

function isVisible(x, y)
    local viewRadius = 100
    local originX, originY = love.mouse.getPosition()
    local worldTileX, worldTileY = (x - 1) * CELL_SIZE + CELL_SIZE / 2, (y - 1) * CELL_SIZE + CELL_SIZE / 2

    return distance(originX, originY, worldTileX, worldTileY) < viewRadius

end

function updateFovMap() 
    for x = 1, GRID_X_SIZE do
        for y = 1, GRID_Y_SIZE do
            if isVisible(x, y) then
                visibleMap[x][y] = 1
                exploredMap[x][y] = 1
            else
                visibleMap[x][y] = 0
            end
        end
    end
end

function createMap(numSquaresToFill)
    fillGridSquares(numSquaresToFill)
end

function initMap()
    for x = 1, GRID_X_SIZE do
        map[x] = {}
        visibleMap[x] = {}
        exploredMap[x] = {}
        for y = 1, GRID_Y_SIZE do
            map[x][y] = 0
            visibleMap[x][y] = 0
            exploredMap[x][y] = 0
        end
    end
end

function fillGridSquares(squaresToFill)
    initMap()
    for i = 1, squaresToFill do
        map[love.math.random(1, GRID_X_SIZE)][love.math.random(1, GRID_Y_SIZE)] = 1
    end
end

function distance(x1, y1, x2, y2)
    return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2))
end

return gridFov