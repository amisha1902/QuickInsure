require_relative "../models/customer"
require_relative "../models/account"
require_relative "../models/transaction"
require_relative "../modules/input_validator"
require_relative "../modules/interest_cal"
require_relative "../models/loan"

module BankManagementSystem
  class BankService
    include InputValidator
    include InterestCal

    def initialize
      @customers = {}
      @accounts = {}
      @transactions = []
      @loans = {}
    end

    def create_account
      cust_id = @customers.length + 1
      puts "Enter your name: "
      name = gets.chomp
      phone = nil
      3.times do |i|
        phone = validate_phone(@customers)
        if phone
          break
        else
          puts "enter valid phone, #{2 - i} attempst left"
        end
      end
      exit unless phone
      customer = Customer.new(cust_id, name, phone)
      @customers[cust_id] = customer
      acc_id = @accounts.length + 1
      balance = positive_input("Enter initial bal")
      account = Account.new(acc_id, cust_id, balance)
      @accounts[acc_id] = account
      puts "\naccount created successfully.."
      puts "account id: #{acc_id}"
      puts "customer name linked with acc: #{name}"
      puts "balance: #{balance}"
      p @accounts
    end

    def deposit
      acc_id = validate_id("Enter acc id")
      amount = positive_input("enter amount to be deposited")
      acc = @accounts[acc_id]
      if acc
        acc.deposit(amount)
        puts "Amount credited"
        p @accounts
      else
        puts "acc not found"
        return
      end
      @transactions << Transaction.new("deposit", acc_id, amount)
    end

    def withdraw
      acc_id = validate_id("Enter acc id")
      amount = positive_input("enter amount to be withdrawn")
      account = @accounts[acc_id]
      if account
        account.withdraw(amount)
        puts "Amount debited"
        p @accounts
      else
        puts "acc not found"
        return
      end
      @transactions << Transaction.new("withdraw", acc_id, amount)
    end

    def transfer_money
      from = validate_id("Enter valid from acc id:")
      unless @accounts[from]
        puts "Invalid from acc"
        return
      end
      to = validate_id("Enter valid to acc id:")
      unless @accounts[to]
        puts "Invalid to account"
        return
      end
      amount = positive_input("Enter Amount: ")
      if @accounts[from].balance < amount
        puts "Insufficient Balance"
        return
      end
      @accounts[from].withdraw(amount)
      @accounts[to].deposit(amount)
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
      cust_id = validate_id("Enter customer id: ")
      unless @customers[cust_id]
        puts "No such customer"
      end
      amount = positive_input("Enter loan amount")
      rate = positive_input("Enter rate of interest")
      years = positive_input("Enter year")
      si = cal_si(amount, rate, years)
      loan = Loan.new(loan_id, cust_id, amount, rate, years, si)
      @loans[loan_id] = loan
      @transactions << Transaction.new("loan_request", cust_id, amount)
      puts "Loan request created"
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
end