class Figure
	def initialize(a,b)
		@a = a
		@b = b
	end

	def area
		@a*@b
	end

	def perimeter
		(@a + @b)*2
	end
end

class Rectangle < Figure
end

class Square < Figure
	def initialize(a)
		super(a,a)
	end
end

class Circle < Figure
	def initialize(r)
		super(r,r)
	end

	def area
		super*1.57
	end

	def perimeter
		super/2*3.14
	end
end

class Trapezoid < Figure
	def initialize(a,b,h)
		super(a+b,h)
	end

	def area 
		super/2
	end
end


puts Trapezoid.new(5,8,4).area

