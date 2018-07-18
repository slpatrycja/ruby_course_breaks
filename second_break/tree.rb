def draw(blanks,stars,stars_max)
	

	while stars < stars_max + 1
		blanks.times { |i| print ' '}
		stars.times { |i| print '*' }
		blanks.times { |i| print ' ' }
		print "\n"

		blanks -= 1
		stars += 2

	end



end

draw(5,1,7)
draw(4,3,11)
draw(5,1,1)