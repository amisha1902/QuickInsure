customers ={}
account = {}
transactions = []
loan ={}
choice = 0;

# def create_customer(customers)
#   cust_id = customers.length+1
#   puts "Enter customer name"
#   cust_name = gets.chomp
#   phone = 0
#   loop do
#    puts "Enter customer phone: "
#    phone = gets.chomp
#    if phone.length != 10
#     puts "Please enter valid phone number!!!!!"
#    elsif customers.values.any? { |c| c[:phone] == phone }
#     puts "phone already exists"
#     return
#    else
#     break
#    end
#   end
#   customers[cust_id] = {name: cust_name, phone: phone}
#   puts "Customer created successfully"
#   p customers
# end

# def create_account(customers, accounts)
#   acc_id = accounts.length + 1
#   print "Enter customer id: "
#   cust_id = gets.to_i
#   # print "Enter Balance: "
#   # balance = gets.to_f
#   balance = positive_input("Enter initial bal")
#   if customers[cust_id]
#     accounts[acc_id] = {
#       customer_id: cust_id,
#       balance: balance
#     }
#    puts "Account created successfully"
#     p accounts
#   else
#     puts "Customer not found"
#   end
# end
def validate_phone(customers)
  loop do 
    puts "Enter phone no"
    phone = gets.chomp
    if phone.length != 10
      puts "please enter valid 10 digit pone number"
    elsif customers.values.any? {|c| c[:phone] == phone}
      puts "phone laredy exists"
    else
      return phone 
    end
  end  
end

def create_bank_account(customers, accounts)
  cust_id = customers.length+1
  puts "Enter your name: "
  name = gets.chomp
  phone = validate_phone(customers)
  customers[cust_id] = {name: name, phone: phone}
  acc_id = accounts.length + 1
  puts "Enter initial balance:"
  balance = gets.to_i
  accounts[acc_id] = {customer_id: cust_id, customer_name: name, balance: balance}
  puts "\naccount created successfully.."
  puts "account id: #{acc_id}"
  puts "customer name linked with acc: #{name}"
  puts "balance: #{balance}"
  p accounts
end

def deposit(accounts, transactions)
  # puts "Enter account id"
  # acc_id = gets.to_i
  # puts "Enter amount to be deposited"
  acc_id = validate_id("Enter acc id:")
  amount = positive_input("enter amount to be deposited")
  if accounts[acc_id]
    accounts[acc_id][:balance] += amount
    transactions << {
      type: "deposit",
      account_id: acc_id,
      amount: amount,
      time: Time.now
    }
    puts "amount added successfully"
    p accounts
    p transactions
  else 
    puts "no such acc exists"
  end
end

def withdraw(accounts, transactions)
  # print "Enter Account ID: "
  # acc_id = gets.to_i
  acc_id = validate_id("Enter acc id:")
  unless accounts[acc_id]
    puts "Account not found"
    return
  end
  amount = positive_input("Enter Amount: ")
  if accounts[acc_id][:balance] < amount
    puts "Insufficient Balance"
    return
  end
 accounts[acc_id][:balance] -= amount
  transactions << {
    type: "withdraw",
    account_id: acc_id,
    amount: amount,
    time: Time.now
  }
  puts "Withdrawal successful"
  p accounts
  p transactions
end

def transfer_money(accounts, transactions)
  # print "From Account id: "
  # from = gets.to_i
  # print "To Account id: "
  # to = gets.to_i
  from = validate_id("from acc id: ")
  unless accounts[from]
    puts "invalid account id from which money has to be sent.."
    return
  end
  to = validate_id("to acc id: ")
  unless accounts[to]
    puts "invalid account id to which money has to be sent.."
    return
  end
  amount = positive_input("Enter Amount: ")
  if accounts[from][:balance] < amount
    puts "Insufficient Balance"
    return
  end
  accounts[from][:balance] -= amount
  accounts[to][:balance] += amount
  transactions << {
    type: "transfer",
    from: from,
    to: to,
    amount: amount,
    time: Time.now
  }
  puts "Transfer successful"
  p accounts
  p transactions
end


def positive_input(message)
  loop do
    print message
    begin
      value = Float(gets.chomp)
      if value <= 0
        # raise "Amount must be positive"
        puts "enter a positive number"
      else
        return value
      end
    end
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

si_cal = lambda do |principal , rate, year|
  (principal * rate * year) / 100.0
end

def take_loan(loans, customers, si_lambda)
  begin
    # print "enter loan id: "
    loan_id = loans.length + 1
    print "Enter Customer ID: "
    cust_id = gets.to_i
    unless customers[cust_id]
      puts "customer not found"
      return
    end
    print "enter loan Amount: "
    amount = gets.to_f
    raise "loan amount must be positive value" if amount <= 0
    print "Interest Rate: "
    interest = gets.to_i
    raise "Interest must be positive" if interest <= 0
    print "Years: "
    years = gets.to_i
    raise "Years must be positive" if years <= 0
    si = si_lambda.call(amount, interest, years)
    loans[loan_id] = {
      customer_id: cust_id,
      amount: amount,
      interest: interest,
      years: years,
      simple_interest: si
    }
    puts "loan granted successfully"
    puts "interest = #{si}"
    p loans

  rescue => e
    puts "error: #{e.message}"
  end
end

while choice!=6
  puts "--Bank Management System-----"
  puts "1.Create account"
  puts "2.Deposit"
  puts "3.Withdraw"
  puts "4.Transfer money"
  puts "5.Take loan"
  puts "6.Exit"
  puts "Enter your choice"
  choice = gets.to_i
  case choice
  when 1
    create_bank_account(customers, account)
  when 2
    deposit(account, transactions)
  when 3
    withdraw(account, transactions)
  when 4
    transfer_money(account, transactions)
  when 5
    take_loan(loan, customers, si_cal)
  when 6
    puts "Exiting"
    break
  else
    puts "Invalid choice"
  end
end