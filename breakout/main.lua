push = require 'push'

Class = require 'class'


require 'Paddle'
require 'Ball'
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
---this is from https://cs50.harvard.edu/x/2020/tracks/games/
PADDLE_SPEED = 200
paddlex = VIRTUAL_WIDTH / 2.1 - 2

ballx= VIRTUAL_WIDTH / 2.1 + 100
bally = VIRTUAL_HEIGHT / 1.21 - 2
ball = Ball(bally, ballx, 4, 4)
balldx = math.random(-1000,100)
balldy = math.random(-1,-50)
ballvelocityx = 0
ballvelocityy = 0

local brick = {}
local brickset = {}

function brickTable()
    gameState = 'play'

    brickset = {}
    local row,col

    for row = 1,8 do 
        brickset[row] =  {}
        for col = 1,15 do 
            brickset[row][col] = 1
        end
    end
end
function brickcolors(row)
    if row < 3 then
      love.graphics.setColor(100/255,0,100/255)
    end
    if row >= 3 and row < 5 then
      love.graphics.setColor(150/255,0,150/255)
    end
    if row >= 5 and row < 7 then
      love.graphics.setColor(200/255,0,150/255)
    end
    if row >= 7 then
      love.graphics.setColor(250/255,0,250/255)
    end
  end





function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')
    love.window.setTitle('Breakout')
    math.randomseed(os.time())
    brickTable()
    brick.height = 15
    brick.width = VIRTUAL_WIDTH / 15 
    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    gameState = 'start'
   
end


function love.update(dt)

    
    if gameState == 'play' then
        ballx = ballx + ballvelocityx * dt 
        bally = bally + ballvelocityy * dt
    elseif gameState == 'start'then 
        ballx = VIRTUAL_WIDTH / 2.1 + 13
        bally = VIRTUAL_HEIGHT / 1.2 - 2
        
    end
    if bally >= WINDOW_HEIGHT then
        gameState = 'start'

    if ballx >= 0 then
       ballvelocityx =-ballvelocityx
    end
    if ballx >= VIRTUAL_WIDTH then
        ballvelocity = -ballvelocityx
    end 

    if bally > -500 then
        gameState = 'start'
    end
       
    end 
    local row = math.floor(ballx / brick.width) + 1
    local col = math.floor (bally / brick.height) + 1

    if row >= 1 and row <= #brickset and col >=1 and col <=15 then
        if brickset [row][col] == 1 then
          ballvelocityy = 0 -ballvelocityy
          brickset[row][col] = 0
        end
      
    end

    if love.keyboard.isDown('a') then
            paddlex = paddlex - PADDLE_SPEED *dt
    elseif love.keyboard.isDown('d') then
            paddlex = paddlex + PADDLE_SPEED * dt
    elseif love.keyboard.isDown('space')then    
        gameState = 'play'
        ballvelocityx = 200
        ballvelocityy = -200
        
    elseif love.keyboard.isDown('return')then 
        gameState = 'start'
        
    end

end



function love.keypressed(key)
    if key =='escape' then
        love.event.quit()
    end
end


function love.draw()
    push:apply('start')
    love.graphics.clear(150/255, 102/255, 208/255, 1)

    Paddle:render()
    love.graphics.setColor(0,0,0,1)
    Ball:render()
    
    local row,col
    brickx = 0 
    bricky= 0
    for row = 1,8 do 
        brickcolors(row)
        brickx = 0
        for col = 1,15 do 
            if brickset[row][col] == 1 then 
                love.graphics.rectangle('fill', brickx + 1, bricky + 1,brick.width - 2, brick.height - 2)

            end 
            brickx = brickx + brick.width
        end
        bricky = bricky + brick.height

    end 
    push:apply('end')
    
end
