module IpValidator
  def positive_input(message)
  loop do
    print message
    begin
      value = Float(gets.chomp)
      if value <= 0
        # raise "Amount must be positive"
        puts "Amount must be positive"
      else
        return value
      end
    end
  end
  end
end