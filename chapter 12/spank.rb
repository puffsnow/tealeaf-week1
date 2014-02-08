puts "Hello! What's your birthyear?"
birthyear = gets.chomp.to_i
puts "Your birthmonth?"
birthmonth = gets.chomp.to_i
puts "Your birthday?"
birthday = gets.chomp.to_i

birthtime = Time.local(birthyear, birthmonth, birthday)
localtime = Time.new

while birthtime < localtime
  puts "SPANK!!!"
  birthyear += 1
  birthtime = Time.local(birthyear, birthmonth, birthday)
end