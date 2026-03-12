module InputValidator
  def positive_input(message)
  loop do
    print message
    begin
      value = Float(gets.chomp)
      if value <= 0
        puts "Amount must be positive"
      else
        return value
      end
    end
  end
  end

  def validate_phone(customers)
    puts "Enter phone no"
    phone = gets.chomp
    if phone.length != 10
      puts "please enter valid 10 digit phone number"
      return nil
    elsif customers.values.any? {|c| c.phone == phone}
      puts "phone already exists"
      return nil
    else
      return phone 
    end 
  end

  def validate_id(message)
  loop do
    print message
    begin
      value = Integer(gets.chomp)
      if value <= 0
        puts "enter valid id.."
      else
        return value
      end
    end
  end
  end
end