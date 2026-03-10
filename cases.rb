print "enter a capacity: "
num = gets.to_i   

case num
when 1..20
  puts "please charge the battery!!"
when 21..50
  puts "battery is moderately low"
else
  puts "Battery is charged enough"
end  