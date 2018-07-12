def show_board

letters = [' ', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J']

#print letter headings
for i in (0..@board.length)	
	print '+---'
end
print "+\n"
for j in (0..10)
	print "| #{letters[j]} "
end
	print "|\n"

for k in (1..10)

	for i in (0..10)	
	print '+---'
	end
#print row number
	print "+\n"
	print "| #{k} " if k<10
	print "|#{k} " if k==10
#print row content
	for j in (0...10)
	if @boardf[(k-1)*10+j] == 1 or @boardf[(k-1)*10+j] == ' ' or @boardf[(k-1)*10+j] == 5
			print "|   " 	
			elsif @boardf[(k-1)*10+j] == 3 then print "| . "
			else print "| X "
	end
	end
	print "|\n"
end
for i in (0..10)	
	print '+---'
end
	print "+\n"

end

def x_left?(x)
	return true if x%10 == 0
	return false
end

def x_right?(x)
	return true if x%10 == 9
	return false
end

def ships_placement
	a=0
	while a<4
		x = rand(0...@boardf.length)

	if @boardf[x] == ' '
		a+=1
		@ships_xy.push(x)	
		@boardf[x-10] = 5
		@boardf[x+10] = 5

		if x_right?(x)
			for i in -1..1
				@boardf[x+10*i -1] = 5
			end

		elsif x_left?(x)
			for i in -1..1
				@boardf[x+10*i+1] = 5
			end
		else
			for i in -1..1
				@boardf[x+10*i -1] = 5
				@boardf[x+10*i+1] = 5
			end
		end

		@boardf[x] = 1
	end

end
end

def game

	ships_placement
	show_board

	while @ships_xy.empty? == false
		puts "Give xy for your shot (i.e A4, b6 etc.). Press 'q' to exit"
		str = gets.chomp
		exit if str == 'q'
		a = str[0].upcase.ord-65
		b = str[1].to_i-1 if str.length == 2
		b = str[1,2].to_i-1 if str.length == 3
		

		guess_xy = b*10 + a

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

		else 
			@boardf[guess_xy] = 3
			puts "oops, nothing here, try again!"
			puts "You've got #{@ships_xy.length} ships left to shot"
		end

		show_board
		end

end

blank_row = Array.new(10,' ')
@board = Array.new(10) { blank_row.clone }
@boardf = @board.flatten(1)
@ships_xy = []
game