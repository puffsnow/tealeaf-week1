born_time = Time.local(1988, 9, 29, 22)
puts "My born:" + born_time.to_s
after_billion_time = born_time + 1_000_000_000
puts "After 1 billion seconds:" + after_billion_time.to_s