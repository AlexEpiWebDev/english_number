def english_number number
	if number < 0	# No negative numbers.
		return "Please enter a number that isn't negative."
	end
	if number == 0
		return "zero"
	end
	
	number_in_english = "" # This is the string we will return.
	
	ones_place = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine",]
	
	tens_place = ["ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
	
	teenagers = ["eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
	
	# "left" is how much of the number we still have left to right out.
	# "write" is the part we are writing out right now.
	
	left = number
	write = left/1000000	# How many millions are to be written out.
	left = left - write*1000000	# Subtracting off those millions.
	
	if write > 0
		millions = english_number write
		number_in_english = number_in_english + millions + " million"
		
		# Same process as for the hundreds.
		
		if left > 0
			number_in_english = number_in_english + " "
		end
	end
	
	write = left/1000		# How many thousands are to be written out.
	left = left - write*1000	# Subtracting off the thousands from the "number".
	
	if ((write > 0) and (write <= 999))
		thousands = english_number write
		number_in_english = number_in_english + thousands + " thousand"
		
		# Same process as for the hundreds
		
		if left > 0
			# So we don't write "two thousandfifty-one"
			number_in_english = number_in_english + " "
		end
	end
		
	write = left/100	# How many hundreds there are to be written out.
	left = left - write*100 # Subtracting off the hundreds from the number.
	
	if ((write > 0) and (write <= 10))
		hundreds = english_number write
		number_in_english = number_in_english + hundreds + " hundred"
		
		# The above is called "recursion".  So what did I just do?  I told this method to call itself, but with "write" instead of "number".  
		# Remember that "write" at this point is the number of hundreds we have to write out.
		# After we add hundreds to "english_number_string", we add the string hundred after it.
		# So, for example, if we originally called "english_number" with 1999 (so "number" = 1999), then at this point "write" would be 19 and "left" would be 99.
		# The laziest thing to do at this point is to have "english_number" write out the "nineteen" for us, then we write out "hundred", and then the rest of "english_number" writes out "ninety-nine".
	
		if  left > 0
			# So we don't write "two hundredfifty-one"...
			number_in_english = number_in_english + " & "
		end
	end
	
	write = left/10				# How many tens there are to write.
	left = left - write*10		# Subtract off those tens.

	if write > 0 
		if ((write == 1) and (left > 0))
			# Since we can't write "tenty-two" instead of "twelve", we have to make a special exception for these.
			number_in_english = number_in_english + 	teenagers[left-1]
			# The "-1" gives the correct index as arrays start at "0".
			# Since we took care of the digit in the one's place already, we have nothing left to write.
			left = 0
		else
			number_in_english = number_in_english + tens_place[write-1]
		end
		
		if left > 0
			number_in_english = number_in_english + "-"
		end
	end
	
	write = left	# How many ones left to write out.
	left = 0			# Subtract off those.
	
	if write > 0
		number_in_english = number_in_english + ones_place[write-1]
	end
	
	# Now we just return "number_in_english"...
	
	number_in_english
end

puts english_number(99)
puts english_number(9999)
puts english_number(1000)
puts english_number(10000)
puts english_number(10592)
puts english_number(999999)
puts english_number(1000000)
puts english_number(1427389)
		