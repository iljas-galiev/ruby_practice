puts "Enter start number"
number = gets


puts "Enter length"
length = gets


puts number

(1..length.to_i).each do |i|
	reversed = number.to_s.reverse
	prev = reversed.to_i % 10
	count = 0
	newnumber = 0

	tmp = reversed.to_i

	while tmp > 0 do
		current = tmp % 10

		if (current != prev) 
			newnumber = newnumber * 10 + count 
			newnumber = newnumber * 10 + prev

			prev = current
			count = 1
		else count += 1
		end

		tmp = tmp / 10
	end


	newnumber = newnumber * 10 + count
	newnumber = newnumber * 10 + prev


	number = newnumber
	puts number
end