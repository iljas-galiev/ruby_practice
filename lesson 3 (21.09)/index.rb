require "./Node.rb"
require "./LinkedList.rb"

list = LinkedList.new
list << 5
list << 6

list.print

list.remove 5

list.print


list << 7
list << 9
list << 1
list << 15
list << 1

puts list.max


uniq = list.uniq

uniq.each do |item|
  puts item
end

sorted = list.sort

puts "\n"

sorted.each do |item|
  puts item
end
