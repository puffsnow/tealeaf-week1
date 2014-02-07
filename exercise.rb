#1. Use the "each" method of Array to iterate over [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], and print out each value."

arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
arr.each do |x|
  puts x
end

#2. Same as above, but only print out values greater than 5.

arr.each do |x|
  puts x if x > 5
end

#3. Now, using the same array from #2, use the "select" method to extract all odd numbers into a new array.

arr.select {|x| x.odd?}

#4. Append "11" to the end of the array. Prepend "0" to the beginning.

arr << 11
arr.unshift(0)

#5. Get rid of "11". And append a "3".

arr.pop
arr << 3

#6. Get rid of duplicates without specifically removing any one value. 

arr.uniq!

#7. What's the major difference between an Array and a Hash?

#Ans. Hash has key-value relationship. It use key to find value, and everything can be a key.
#     Array is always index with integer and from 0, just like a list.

#8. Create a Hash using both Ruby 1.8 and 1.9 syntax.
#   Suppose you have a h = {a:1, b:2, c:3, d:4}

h = {:a=>1, :b=>2, :c=>3, :d=>4}
h = {a: 1, b: 2, c: 3, d: 4}

#9. Get the value of key "b".
puts h[:b]

#10. Add to this hash the key:value pair {e:5}
h[:e] = 5

#13. Remove all key:value pairs whose value is less than 3.5
h.delete_if {|key, value| value < 3.5}
puts h

#14. Can hash values be arrays? Can you have an array of hashes? (give examples)
#1) Yes, ex. {number: [1, 2, 3, 4], year: [95, 96]}
#2) Yes, ex. [{a: 1, b: 2}, {c: 3, d: 4}]

#15. Look at several Rails/Ruby online API sources and say which one your like best and why.
