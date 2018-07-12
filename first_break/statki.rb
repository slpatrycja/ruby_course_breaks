require 'pp'


blank_row = Array.new(10,0)
@board = Array.new(10) { blank_row.clone }
# board = Array.new(10) { Array.new(10, 0) }
# board[0][0] = 1
# board[8][3] = 1

def cztero()
	x = rand(10)
	y = rand(10)
	@board[x][y] = 1
	directions = ['right','left','up','down']

	if y>6
		directions.delete('right')
	elsif y<3
		directions.delete('left')
	end
	
	if x<3
		directions.delete('up')
	elsif x>6
		directions.delete('down')
	end

	
	direction = directions[rand(0...directions.length)]
	puts direction

	case direction
	when 'right' 
		@board[x][y+1] = 1
		@board[x][y+2] = 1
		@board[x][y+3] = 1

		for i in (0..3) 		
			@board[x-1][y+i] = 2 if x > 0
			@board[x+1][y+i] = 2 if x < 9 
		end

			@board[x][y-1] = 2 if y > 0
			@board[x][y+4] = 2 if y+4 < 9 

	when 'left'
		@board[x][y-1] = 1
		@board[x][y-2] = 1
		@board[x][y-3] = 1

		for i in (0..3)
			@board[x-1][y-i] = 2 
			@board[x+1][y-i] = 2 if x < 9
		end
			if y-4 > 0
				@board[x][y-4] = 2 
				@board[x-1][y-4] = 2 if x > 0
				@board[x+1][y-4] = 2 if x < 9
			end
			
			if y < 9 
				@board[x][y+1] = 2 
				

	when 'up'
		@board[x-1][y] = 1
		@board[x-2][y] = 1
		@board[x-3][y] = 1
	when 'down'
		@board[x+1][y] = 1
		@board[x+2][y] = 1
		@board[x+3][y] = 1
	end


end

cztero()





pp @board