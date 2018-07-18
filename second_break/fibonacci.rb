def fibonacci(n)
	a = 0
	b = 1
	count = 0

	while count < n 
		puts a 
		puts b
		a, b = a + b, 2*b + a
		count += 2
	end
end

fibonacci(ARGV[0].to_i)