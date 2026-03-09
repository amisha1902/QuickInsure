name = :amisha
puts name
puts name.class
puts name.object_id

a = "name"
puts a.class
puts a.object_id

#combining two hash 
h1 = {"name" => "Amisha", "role" => "engineer"}
h2 = {"age" => 23}
result = h1.merge(h2)
puts result

##string concat
 a = "Amisha"
 d = "Deshmukh"
 str = a <<" "<< d
 puts "str" +"="+ str
 puts a.include?("Ami") 
 
 puts str.dump
 str2 = "Amisha"
 string  = "i am amisha"
 
 puts string.sub("am", "is")
 
spl="ruby"
puts spl.split(",")

duplicate = " aamiishaa "
puts duplicate.strip()
puts duplicate.squeeze()
puts duplicate.lstrip()
puts duplicate.rstrip()

puts "hello from" + " " + self.to_s

arr = Array.new(3, "ruby")
puts arr
arr1 = Array(4) {|i| i.to_s}
puts arr1

 