class Customer 
  attr_accessor :cust_id, :cust_name, :phone
  def initialize(cust_id, cust_name, phone)
    @cust_id = cust_id
    @cust_name = cust_name
    @phone = phone
  end
end