employees = {
 11 => { name: "Amisha", salary: 38000 },
 12 => { name: "Riya", salary: 50000 }
}

def add_emp(employees)
puts "enter emp id"
id = gets.to_i

puts "enter emp name"
name = gets.chomp

puts "enter salary"
salary = gets.to_i

employees[id] = { name: name, salary: salary }

puts "employees added:"
end

def display(employees)
puts "employee details:"
p employees
end

def update(employees)
puts "enter emp id to update salary"
update_id = gets.to_i

puts "enter new salary"
newSal = gets.to_i

if employees[update_id]
  employees[update_id][:salary] = newSal
  puts "salary updated"
else
  puts "employee not found"
end
end


def delete(employees)
puts "enter emp id to delete"
delete_id = gets.to_i

employees.delete(delete_id)
puts "employee deleted"
puts "remaining emps"
end

display(employees)
add_emp(employees)
display(employees)
update(employees)
display(employees)
delete(employees)
display(employees)