class Transaction
  attr_accessor :type, :account_id, :amount
  def initialize(type, account_id, amount)
    @type = type
    @account_id = account_id
    @amount = amount
  end
end