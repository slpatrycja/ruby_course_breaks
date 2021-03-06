require 'curses'
include Curses 								#use include if dont want to prefix library commands with class name
require 'time'

class Snake
	attr_accessor :end_game, :pause 		#public accessor
	@@test = "something" 					#class variable
	@test2 = "something else" 				#instance variables

	def initialize							 #constructor
		@win = Window.new(lines, cols, 0, 0) #set the playfield the size of current terminal window
		@title = "Kirka's Snake"
		@pos_y = [5,4,3,2,1]
		@pos_x = [1,1,1,1,1]
		@dir = :right
		@pause = false
		@snake_len = 3
		@game_speed = 0.2
		@start_time = Time.now.to_i
		@speed_incremented = false
		@display_speed = 0
		@game_score = 0
		@end_game = false
		@ticks = 0
	end
	
	def setup_window(border_wall, border_roof)
		@time_offset = Time.now.to_i - @start_time 		#time does not stop ticking when paused. this is a bit of logic. we use time only for score.
		@win.box(border_wall, border_roof)				# border

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
		#generate food.
		@food_y = rand(2..max_w-2)
		@food_x = rand(1..max_h-2)
	end

	def change_of_dir?
		#check change of movement
		case getch
			when ?Q, ?q
				exit
			when ?W, ?w
				@dir = :up if @dir != :down
			when ?S, ?s
				@dir = :down if @dir != :up
			when ?D, ?d
				@dir = :right if @dir != :left
			when ?A, ?a
				@dir = :left if @dir != :right
			when ?P, ?p
				@pause = @pause ? false : true		#shorthand if. fun stuff.
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
		#remember the tail position during movement
		t = @snake_len+1
		while t > 0 do
			@pos_x[t] = @pos_x[t-1]
			@pos_y[t] = @pos_y[t-1]
			t -= 1
		end 

		#draw the snake and its tail
		for t in 0..@snake_len+1
			setpos(@pos_x[t],@pos_y[t])
			addstr(t == 1 ? "#" : "+")
		end
	end

	def speed_of_play
		#set speed of play, increment it automatically
		if ((@snake_len % 10 == 0) or (@time_offset%60 == 0))
			if @speed_incremented == false
				@game_speed -= (@game_speed*0.10) unless @game_speed < 0.05
				@speed_incremented = true
				@display_speed += 1
			end
		else
			@speed_incremented = false
		end

		if !@pause
			@ticks += 1
		end
		sleep( (@dir == :left or @dir == :right) ? @game_speed/2 : @game_speed) #actually acount for speed. the sleep here instroduces FPS.
	end

	def collision?
		#check collision with border
		if @pos_y[0] == cols-1 or @pos_y[0] == 0 or @pos_x[0] == lines-1 or @pos_x[0] == 0
			@end_game = true
		end

		#check collision with self
		for i in 2..@snake_len
			if @pos_y[0] == @pos_y[i] and @pos_x[0] == @pos_x[i]
				@end_game = true
			end
		end
	end

	def ate_food?
		#check if ate food
		if @pos_y[0] == @food_y and @pos_x[0] == @food_x
			make_food(lines,cols)
			@snake_len += 1
			@game_score += 1*@display_speed
		end
	end

	def refresh_window	
		@win.refresh
		@win.clear
	end

end

def end_game
	lost_string = "You LOST"

	win = Window.new(lines, cols, 0, 0) 	#set the playfield the size of current terminal window
		
	win.refresh
	win.clear

	win.box("|", "-")						# border

	win.setpos(4, 4)
	win.addstr(lost_string)		

	exit
end

def pause?
	@snake.change_of_dir?
	if @snake.pause
		sleep(0.5)			
		pause?
	end
end

init_screen
cbreak
noecho						#does not show input of getch
stdscr.nodelay = 1 			#the getch doesnt system_pause while waiting for instructions
curs_set(0)					#the cursor is invisible.
@snake = Snake.new
@snake.make_food(lines, cols)

begin
	loop do
		pause?

		@snake.setup_window("|","-")

		@snake.change_of_dir!

		@snake.remember_tail

		@snake.speed_of_play

		@snake.collision?

		@snake.ate_food?

		@snake.refresh_window

		end_game if @snake.end_game
	end
ensure
	close_screen	
end