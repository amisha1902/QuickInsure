class Account
  attr_accessor :acc_id,:cust_id, :balance ,:status
  def initialize(acc_id, cust_id, balance)
    @acc_id = acc_id
    @cust_id = cust_id
    @balance = balance
    @status = "Active"
  end

  def withdraw(amount)
    @balance -= amount
  end

  def deposit(amount)
    @balance += amount
  end
end