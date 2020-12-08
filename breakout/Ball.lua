Ball = Class{}

function Ball:init(x,y,width,height)
    self.x = VIRTUAL_WIDTH / 2.1 - 2
    self.y = VIRTUAL_HEIGHT / 1.2 - 2
    self.width = width
    self.height = height
    self.dy= math.random(0,1)
    balldy = math.random(-1,-50)
    self.dx=math.random(2) == 1 and 100 or -100
    ballx = VIRTUAL_WIDTH / 2.1 + 13
    bally = VIRTUAL_HEIGHT / 1.2 - 2
    ballstick = true


end
function Ball:collides(box)
    
    if self.x > box.x + box.width or self.x + self.width < box.x then
        return false
    end

    if self.y > box.y +box.height or self.y +self.height < box.y then
        return false
    end

    return true

end
function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 -2
    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50,50)*1.5
end
function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.circle('fill',ballx,bally,5)
end