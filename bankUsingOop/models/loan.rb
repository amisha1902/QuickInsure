class Loan
  attr_accessor :loan_id, :customer_name, :customer_id, :amount, :rate, :years, :outstanding_amount, :interest, :status
  attr_reader :emi, :remaining_amount, :total_emis, :emis_paid
  def initialize(loan_id, customer_name,customer_id, amount, rate, years, interest)
    @loan_id = loan_id
    @customer_name = customer_name,
    @customer_id = customer_id
    @amount = amount
    @rate = rate
    @years = years
    @interest = interest
    @status = "Pending"
    @remaining_amount= amount.to_f
    @total_emis = @years * 12
    @emis_paid = 0
    @emi = calculate_emi
  end
  def approve
    @status = "Approved"
  end
  def reject
    @status = "Rejected"
  end
  def repay
     return 0 if @status == "Closed"
     r = @rate / (12 * 100.0)
     interest = (@remaining_amount * r).round(2)
     amount_paid = (@emi - interest).round(2)
     if amount_paid > @remaining_amount
      amount_paid = @remaining_amount
      @emi = (amount_paid + interest).round(2)
     end
     @remaining_amount -= amount_paid
     @emis_paid += 1
     close if @remaining_amount == 0
     { emi_paid: @emi, amount_paid: amount_paid, interest_paid: interest, remaining_amount: @remaining_amount }
   
  end
  def calculate_emi
    r = @rate / (12 * 100.0)          
    n = @total_emis                  
    a = @amount
    emi = a * r * ((1 + r) ** n) / (((1 + r) ** n) - 1)
    emi.round(2)
  end
  def close
    @status = "Closed"
    @remaining_amount = 0
  end
end