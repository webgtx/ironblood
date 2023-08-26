function love.load( ... )
	anime8 = require("lib/anime8")
	background = love.graphics.newImage("sprites/background.jpg")
	love.graphics.setDefaultFilter("nearest", "nearest")

	ply = {
		x = 400;
		y = 200;
		speed = 5;
		spriteSheet = love.graphics.newImage("sprites/knights.png");
		isMoving = false;

		move = function(direction, distance)
			if direction == "up" and love.keyboard.isDown(keymap[direction]) then
				ply.y = ply.y - distance
				ply.animationState = ply.animations.up
				ply.isMoving = true
			elseif direction == "right" and love.keyboard.isDown(keymap[direction]) then
				ply.x = ply.x + distance
				ply.animationState = ply.animations.right
				ply.isMoving = true
			elseif direction == "left" and love.keyboard.isDown(keymap[direction]) then
				ply.x = ply.x - distance
				ply.animationState = ply.animations.left
				ply.isMoving = true
			elseif direction == "down" and love.keyboard.isDown(keymap[direction]) then
				ply.y = ply.y + distance
				ply.animationState = ply.animations.down
				ply.isMoving = true
			end
		end
	}

	-- ply.grid = anime8.newGrid(12, 18, ply.spriteSheet:getWidth(), ply.spriteSheet:getHeight());
	ply.grid = anime8.newGrid(76, 103, ply.spriteSheet:getWidth(), ply.spriteSheet:getHeight())
	animationDuration = 0.2
	ply.animations = {
		up = anime8.newAnimation(ply.grid("1-3", 4), animationDuration);
		left = anime8.newAnimation(ply.grid("1-3", 2), animationDuration);
		right = anime8.newAnimation(ply.grid("1-3", 3), animationDuration);
		down = anime8.newAnimation(ply.grid("1-3", 1), animationDuration);
	};
	ply.animationState = ply.animations.down

	keymap = {
		up = "w";
		left = "a";
		right = "d";
		down = "s";
	}
end

function love.update(dt)
	ply.isMoving = false

	-- Movements
	ply.move("up", ply.speed)
	ply.move("right", ply.speed)
	ply.move("left", ply.speed)
	ply.move("down", ply.speed)

	if not ply.isMoving then
	  ply.animationState:gotoFrame(2)
	end
	ply.animationState:update(dt)
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.draw( ... )
	-- love.graphics.circle("fill", ply.x, ply.y, 50)
	love.graphics.draw(background, 0, 0, 0, 1.7)
	ply.animationState:draw(ply.spriteSheet, ply.x, ply.y, nil, 5)
end

