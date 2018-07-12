require 'pp'
require "curses"
ROWS = 20
COLS = 70

def init
Curses.init_screen
Curses.start_color
Curses.curs_set(0)
Curses.noecho
Curses.init_pair(1, Curses::COLOR_WHITE, Curses::COLOR_RED)
Curses.init_pair(2, Curses::COLOR_WHITE, Curses::COLOR_YELLOW)

@window = Curses::Window.new(ROWS,COLS,0,0)
@window.keypad = true
@window.nodelay = true
@x = 0
@y = 0
@dir = :right
blank_row = Array.new(70,0)
@board = Array.new(20) { blank_row.clone }
@pause = false
@stop = false
@add_second = 0
@snake_len = 1
end

def food
	loop do
		tmpX = rand(20)
		tmpY = rand(70)

		next if @board[tmpX][tmpY]!= 0 and @board[tmpX][tmpY]!= -1
		@board[tmpX][tmpY] = -1
		@add_second += 1
		@snake_len += 1
end

end

def show
	@window.clear
	@window.color_set(2)
	@window.box(" ", " ", " ")
	for tmpX in (0...20)
		@window.setpos(tmpX,0)
		@window.color_set(1)
		for tmpY in (0...70)
			@window.setpos(tmpX,tmpY)	 
			if @board[tmpX][tmpY] == -1 
				@window.addstr("*") 
			elsif @board[tmpX][tmpY] > 0 and @board[tmpX][tmpY] <= @snake_len 
				@window.addstr("■") 
			end
		end
	end

end

def move

	case @dir
		when :right then @y+=1
		when :left then @y-=1
		when :up then @x-=1
		when :down then @x+=1
	end

	if @y>69 or @y<0 or @x>19 or @x<0 or @board[@x][@y]!=0 && @board[@x][@y]!=-1
		@stop = true
	else
		food if @board[@x][@y] == -1 
		
		for tmpY in (0...70)
			for tmpX in (0...20)
				if @board[tmpX][tmpY] > 0
					@board[tmpX][tmpY] -= 1
				end
			end
		end
		@board[@x][@y] == @snake_len
	end

end

def clear_board
	@x = 0
	@y = 0
	@dir = :right
	@snake_len = 1

	for tmpY in 0...70
		for tmpX in 0...20
			@board[tmpX][tmpY] == 0
		end
	end
end

def game
	init
	@window.getstr
	@window.clear
	food
	@snake_len -= 1

	while(!stop)
		
			if @window.getch == 'p'
				@pause = false if @pause
				@pause = true
			end
				case @window.getch
					when Curses::Key::LEFT then @dir = :left
				    when Curses::Key::RIGHT then @dir = :right
				    when Curses::Key::UP then @dir = :up
				    when Curses::Key::DOWN then @dir = :down
				end
			
	
		move
		sleep 0.2
		show

		while @pause
			@pause = false if @window.getch == 'p'
		end

	end
end

begin 
	loop do
	game
ensure
	Curses.close_screen
end
end


