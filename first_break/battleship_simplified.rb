
blank_row = Array.new(5,' ')
@board = Array.new(5) { blank_row.clone }
@boardf = @board.flatten(1)
@shots = 10
@ships_xy = []

def ships_placement

	until @ships_xy.length == 4
		ship_xy = rand(0...25)
		if @ships_xy.include?(ship_xy) == false
			@ships_xy.push(ship_xy)
			@boardf[ship_xy] = 1
		end
	end
end

def game

	ships_placement
	show_board

	while @shots > 0
		puts "Give xy for your shot (i.e A4, b6 etc.). Press 'q' to exit"
		str = gets.chomp
		exit if str == 'q'
		a = str[0].upcase.ord-65
		b = str[1].to_i-1

		guess_xy = b*5 + a

		if @ships_xy.include?(guess_xy)
			puts "one ship there!!"
			@boardf[guess_xy] = 2
			@ships_xy.delete(guess_xy) 
			if @ships_xy.empty? 
				show_board
				puts "you won!"
				exit
			else puts "You've got #{@ships_xy.length} ships left to shot!"
			end 

		elsif @shots == 1 and @ships_xy.length != 0
			puts "no chances left, you lost! "
			exit
		else 
			@boardf[guess_xy] = 3
			puts "oops, nothing here, try again!"
			puts "You've got #{@ships_xy.length} ships left to shot and #{@shots-1} chances left"
		end

		@shots -= 1
		show_board
		end

end


def show_board

	letters = [' ', 'A', 'B', 'C', 'D', 'E']
	#print letter headings
	for i in (0..@board.length)	
		print '+---'
	end
	print "+\n"

	for j in (0..5)
		print "| #{letters[j]} "
	end
	print "|\n"

	for k in (1..5)

		for i in (0..5)	
		print '+---'
		end
	#print row number
		print "+\n"
		print "| #{k} "
	#print row content
		for j in (0...5)
			if @boardf[(k-1)*5+j] == 1 or @boardf[(k-1)*5+j] == ' ' 
			print "|   " 	
			elsif @boardf[(k-1)*5+j] == 3 then print "| . "
			else print "| X "
			end
		end

		print "|\n"
	end

	for i in (0..5)	
		print '+---'
	end
		print "+\n"
end


game