require "./models/customer"
require "./models/account"
require "./models/transaction"
require "./modules/ip_validator"
require "./modules/interest_cal"
class BankService
  include IpValidator
  include InterestCal
  def initialize
    @customers = {}
    @accounts ={}
    @transactions = []
    @loans ={}
  end

def create_customer
  cust_id = @customers.length+1
  puts "Enter customer name"
  cust_name = gets.chomp
  phone = 0
  loop do
  puts "Enter customer phone: "
  phone = gets.chomp
  if phone.length != 10
    puts "Please enter valid phone number!!!!!"
  else
    break
  end
end
  customer = Customer.new(cust_id, cust_name, phone)
  @customers[cust_id] = customer
  puts "Customer created successfully"
  p @customers
end

def create_account
  acc_id = @accounts.length + 1
  print "Enter customer id: "
  cust_id = gets.to_i
  balance = positive_input("Enter initial bal")
  if @customers[cust_id]
    account = Account.new(acc_id, cust_id, balance)
    @accounts[acc_id] = account
    puts "Account created successfully"
    p @accounts
  else
    puts "Customer not found"
  end
end

def deposit
  puts "Enter account id"
  acc_id = gets.to_i
  amount = positive_input("enter amount to be deposited") 
  account = @accounts[acc_id]
  if @accounts[acc_id]
    account.balance += amount
    puts "Amount credited"
    p @accounts
  else
    puts "acc not found"
    return
  end
  @transactions << Transaction.new("deposit", acc_id, amount)
end

def withdraw
  puts "Enter account id"
  acc_id = gets.to_i
  amount = positive_input("enter amount to be withdrawn") 
  account = @accounts[acc_id]
  if @accounts[acc_id]
    account.balance -= amount
    puts "Amount debited"
    p @accounts
  else
    puts "acc not found"
    return
  end
  @transactions << Transaction.new("withdraw", acc_id, amount)
end

def transfer_money
  print "From Account id: "
  from = gets.to_i
  print "To Account id: "
  to = gets.to_i
  unless @accounts[from] && @accounts[to]
    puts "Invalid account"
    return
  end
  amount = positive_input("Enter Amount: ")
  if @accounts[from].balance < amount
    puts "Insufficient Balance"
    return
  end
  @accounts[from].balance -= amount
  @accounts[to].balance += amount
  transaction = {
      type: "transfer",
      from: from,
      to: to,
      amount: amount
    }
    @transactions << transaction 
   puts "Transfer successful"
  p @accounts
  p @transactions
end

def request_loan
  loan_id = @loans.length + 1
  puts "Enter customer id"
  cust_id = gets.to_i
  unless @customers[cust_id]
    puts "No such customer"
  end
  amount = positive_input("Enter loan amount")
  rate = positive_input("Enter rate of interest")
  years = positive_input("Enter year")
  si = cal_si(amount, rate, years)
  @loans[loan_id]={
    customer_id: cust_id,
    amount: amount,
    rate: rate,
    years: years,
    si: si
  }
  @transactions << Transaction.new("loan", cust_id, amount)
  puts "Loan granted successfully"
  p @loans
  p @transactions
end

def show_customer
  @customers.each do |id, customer|
    puts "#{id} => #{customer.cust_name}"
  end
end

def show_account
  puts "enter customer id"
  cust_id = gets.to_i
  @accounts.each do |acc_id, account|
    if account.cust_id == cust_id
      puts "account id: #{acc_id}, balance: #{account.balance}"
    end
  end
end
end