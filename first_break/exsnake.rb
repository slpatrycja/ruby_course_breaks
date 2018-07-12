require "curses"
include  Curses

ROWS = 30
COLS = 80
class Snake
  def initialize
    @pos_y = [5,4,3,2,1]
    @pos_x = [1,1,1,1,1]
    @dir = :right
    @snake_length = 3
    @pause = false
    @game_speed = 0.2
    @start_time = Time.now.to_i
    @speed_incremented = false
    @display_speed = 0
    @game_score = 0
    @end_game = false
    @ticks = 0
  end

def speed_of_play
    #set speed of play, increment it automatically
   
    sleep( (@dir == :left or @dir == :right) ? @game_speed/2 : @game_speed) #actually acount for speed. the sleep here instroduces FPS.
  end

  def change_dir?
    case getch
    when "q"
      exit
    when Curses::Key::LEFT
      @pos_y[0] -= 1
    when Curses::Key::RIGHT
       @pos_y[0] += 1
    when Curses::Key::UP
      @pos_x[0] -= 1
    when Curses::Key::DOWN
     @pos_x[0] += 1
    end

  end

def remember_tail
    #remember the tail position during movement
    t = @snake_length+1
    while t > 0 do
      @pos_x[t] = @pos_x[t-1]
      @pos_y[t] = @pos_y[t-1]
      t -= 1
    end 

    #draw the snake and its tail
    for t in 0..@snake_length+1
      setpos(@pos_x[t],@pos_y[t])
      addstr(t == 1 ? "#" : "+")
    end
  end

end
begin
  @snake = Snake.new
  init_screen
  start_color
  # init_pair(1, Curses::COLOR_WHITE, Curses::COLOR_RED) # define color pair (foreground + background), used by color_set
  init_pair(2, Curses::COLOR_WHITE, Curses::COLOR_YELLOW)
  Curses.curs_set(0)
  Curses.noecho
  window = Curses::Window.new(ROWS, COLS, 0, 0)
  window.keypad = true
  window.nodelay = true
  
  loop do
    

    @snake.change_dir?
    @snake.remember_tail
    @snake.speed_of_play
    window.refresh
    window.clear
  end
ensure
  Curses.close_screen
end
