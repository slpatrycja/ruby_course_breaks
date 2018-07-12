require 'curses'
include Curses 								#use include if dont want to prefix library commands with class name
require 'time'

class Snake
	attr_accessor :end_game, :pause 
	@@test = "something" 					#class variable
	@test2 = "something else"

	def initialize
		@win = Window.new(lines, cols, 0, 0)
		@title = 'Ssssnake'
		@pos_y = [5,4,3,2,1]
		@pos_x = [1,1,1,1,1]
		@dir = :right
		@snake_length = 3
		@start_time = Time.now.to_i
		@game_score = 0
		@end_game = false
	end

	def window_setup(border_side, border_top)
		@time_offset = Time.now.to_i - @start_time 		#time does not stop ticking when paused. this is a bit of logic. we use time only for score.
		@win.box(border_side, border_top)				# border

		@win.setpos(@food_x, @food_y)
		@win.addstr("*")								#draw food

		@win.setpos(0,3)
		@win.addstr("Snake Length: " + @snake_len.to_s)

		@win.setpos(0,cols/2-@title.length/2)
		@win.addstr(@title)

		@win.setpos(0,cols-12)
		@win.addstr("Ticks: " + @ticks.to_s)

		@win.setpos(lines-1,3)
		@win.addstr("Speed: " + @display_speed.to_s)

		@win.setpos(lines-1,cols-12)
		@win.addstr("Score: " + (@game_score-(@time_offset)/10.round(0)).to_s)

	end


		def make_food(max_h, max_w)
			@food_y = rand(2..max_w-2)
			@food_x = rand(2..max_h-2)
		end
		

		def change_of_dir?
			case getch
				when "q"
			      exit
			    when Curses::Key::LEFT
			      @dir = :left if @dir != :right
			    when Curses::Key::RIGHT
			     @dir = :right if @dir != :left
			    when Curses::Key::UP
			      @dir = :up if @dir != :down
			    when Curses::Key::DOWN
			      @dir = :down if @dir != :up
			    end

		end

		def change_of_dir!
		#account for change of direction if happened
		case @dir
			when :up then @pos_x[0] -= 1
			when :down  then @pos_x[0] += 1
			when :left  then @pos_y[0] -= 1
			when :right then @pos_y[0] += 1
		end
	end


	def remember_tail
		t = @snake_length + 1

		while t > 0 
			@pos_y[t] = @pos_y[t-1]
			@pos_x[t] = @pos_x[t-1]
			t-=1
		end

		for t in 0..@snake_length+1
			setpos(@pos_x[t],@pos_y[t])
			addstr(t == 1 ? "#" : "+")
		end
	end

def collision?

	if @pos_x[0] == lines-1 || @pos_x[0]== 0 || @pos_y[0] == cols-1 || @pos_y[0] = 0
		@end_game = true
	end

	for i in 2..@snake_length
		if @pos_y[0] == @pos_y[i] && @pos_x[0] == @pos_x[i]
			@end_game = true
		end
	end
end



def ate_food?
		#check if ate food
		if @pos_y[0] == @food_y and @pos_x[0] == @food_x
			make_food(lines,cols)
			@snake_len += 1
			@game_score += 1
		end
end

	def refresh_window	
		@win.refresh
		@win.clear
	end
end


Curses.init_screen
cbreak
noecho						#does not show input of getch
stdscr.nodelay = 1 			#the getch doesnt system_pause while waiting for instructions
curs_set(0)					#the cursor is invisible.
@snake = Snake.new
@snake.make_food(lines, cols)

begin
	loop do

		@snake.window_setup("|","-")

		@snake.change_of_dir!

		@snake.remember_tail

		@snake.collision?

		@snake.ate_food?

		@snake.refresh_window

		exit if @snake.end_game
	end
ensure
	close_screen	
end
