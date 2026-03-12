class Loan
  attr_accessor :loan_id, :customer_id, :amount, :rate, :years, :interest, :status
  def initialize(loan_id, customer_id, amount, rate, years, interest)
    @loan_id = loan_id
    @customer_id = customer_id
    @amount = amount
    @rate = rate
    @years = years
    @interest = interest
    @status = "Pending"
  end
  def approve
    @status = "Approved"
  end
  def reject
    @status = "Rejected"
  end
  def close
    @status = "Closed"
  end
end