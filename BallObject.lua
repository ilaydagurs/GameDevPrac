BallObject = Class{}

function BallObject:initialize(posX, posY, width, height)
  -- Set the initial position and size of the ball
  self.posY = posY
  self.posX = posX

  self.height = height
  self.width = width

  -- Randomize initial movement direction of the ball
  self.deltaY = math.random(2) == 1 and -100 or 100
  self.deltaX = math.random(-50, 50) == 1 and math.random(-80, -100) or math.random(80, 100)
end

function BallObject:reset(player)
  -- Center the ball on the screen with a new random direction
  self.posY = VIRTUAL_HEIGHT / 2 - 2
  self.posX = VIRTUAL_WIDTH / 2 - 2

  self.deltaY = math.random(-50, 50)

  if player == 1 then
    self.deltaX = 100
  elseif player == 2 then
    self.deltaX = -100
  else
    self.deltaX = math.random(2) == 1 and 100 or -100
  end
end

function BallObject:update(deltaTime)
  -- Update the ball's position based on its velocity
  self.posX = self.posX + (self.deltaX * 1.5) * deltaTime
  self.posY = self.posY + (self.deltaY * 1.5) * deltaTime
end

function BallObject:render()
  -- Draw the ball on the screen
  love.graphics.rectangle('fill', self.posX, self.posY, self.width, self.height)
end

function BallObject:collides(withPaddle)
  -- Check if the ball collides with the paddle
  if self.posX > withPaddle.posX + withPaddle.width or withPaddle.posX > self.posX + self.width then
    return false
  end

  if self.posY > withPaddle.posY + withPaddle.height or withPaddle.posY > self.posY + self.height then
    return false
  end

  return true
end
