def sum_using_step(n)
	(2..n).step(2).sum
end

def sum_using_formula(n)
	q = n/2
	if n%2 == 0
		sum = (2+n)/2*q
	else 
		sum = (1+n)/2*q
	end
	sum
end



def sum_using_loop(n)
	n-= 1 if n%2 == 1
	sum = 0

	while(n>0)
		sum += n
		n -= 2
	end
	sum
end

puts sum_using_formula(16)
puts sum_using_step(16)
puts sum_using_loop(16)