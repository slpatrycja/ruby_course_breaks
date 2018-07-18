def menu
	puts "Choose operation:"
	puts "1. Add", "2. Substract","3. Multiply","4. Divide", "5. Quit"
	print "What is your choice?: "
	choice =  gets.to_i

	if choice == 5 
		exit
	elsif choice.between?(1,4) == false 
		puts "No such operation. Try again"
		menu
	else
		print "\nEnter first number: "
		a = gets.to_i
		print "\nEnter second number: "
		b = gets.to_i
		print " ==> " 
		case choice
		when 1
			puts a + b
			menu
		when 2
			puts a - b
			menu
		when 3
			puts a * b
			menu
		when 4
			puts a/b if b!=0
			puts "No division by 0" if b == 0
			menu
		end
	end
end
menu