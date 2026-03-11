class Account
  attr_accessor :acc_id,:cust_id, :balance
  def initialize(acc_id, cust_id, balance)
    @acc_id = acc_id
    @cust_id = cust_id
    @balance = balance
  end
end