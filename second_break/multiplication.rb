vals = [1,2,3,4,5,6,7,8,9,10]

vals.each { |n| print "%5d" % n } 
print "\n"
print "    "
vals.each { |n| print "____ " } 
print "\n"

vals.each do  |i|
	print "%-2d" % i, "| "
	vals.each { |n| print "%-5d" % (n*i) }
	print "\n"
end
