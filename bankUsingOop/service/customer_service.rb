require_relative "../models/customer"
require_relative "../models/account"
require_relative "../models/transaction"
require_relative "../modules/input_validator"
require_relative "../modules/interest_cal"
require_relative "../models/loan"
require 'pry'
module BankManagementSystem
  class CustomerService
    include InputValidator
    include InterestCal

    def initialize(store)
      @store = store
    end

    def create_account
      cust_id = @store.customers.length + 1
      puts "Enter your name: "
      name = gets.chomp
      phone = nil
      3.times do |i|
        phone = validate_phone(@store.customers)
        if phone
          break
        else
          puts "enter valid phone, #{2 - i} attempst left"
        end
      end
      exit unless phone
      customer = Customer.new(cust_id, name, phone)
      @store.customers[cust_id] = customer
      acc_id = @store.accounts.length + 1
      balance = positive_input("Enter initial bal")
      account = Account.new(acc_id, cust_id, balance)
      @store.accounts[acc_id] = account
      puts "\naccount created successfully.."
      puts "account id: #{acc_id}"
      puts "customer name linked with acc: #{name}"
      puts "balance: #{balance}"
      p @store.accounts
    end

    def deposit
      acc_id = validate_id("Enter acc id")
      amount = positive_input("enter amount to be deposited")
      acc = @store.accounts[acc_id]
      if acc
        acc.deposit(amount)
        puts "Amount credited"
        p @store.accounts
      else
        puts "acc not found"
        return
      end
      @store.transactions << Transaction.new("deposit", acc_id, amount)
    end

    def withdraw
      acc_id = validate_id("Enter acc id")
      amount = positive_input("enter amount to be withdrawn")
      account = @store.accounts[acc_id]
      if account
        account.withdraw(amount)
        puts "Amount debited"
        p @store.accounts
      else
        puts "acc not found"
        return
      end
      @store.transactions << Transaction.new("withdraw", acc_id, amount)
    end

    def transfer_money
      from = validate_id("Enter valid from acc id:")
      unless @store.accounts[from]
        puts "Invalid from acc"
        return
      end
      to = validate_id("Enter valid to acc id:")
      unless @store.accounts[to]
        puts "Invalid to account"
        return
      end
      amount = positive_input("Enter Amount: ")
      if @store.accounts[from].balance < amount
        puts "Insufficient Balance"
        return
      end
      @store.accounts[from].withdraw(amount)
      binding.pry
      @store.accounts[to].deposit(amount)
      transaction = {
        type: "transfer",
        from: from,
        to: to,
        amount: amount
      }
      @store.transactions << transaction
      puts "Transfer successful"
      p @store.accounts
      p @store.transactions
    end

    def request_loan
      loan_id = @store.loans.length + 1
      cust_id = validate_id("Enter customer id: ")
      unless @store.customers[cust_id]
        puts "No such customer"
        return 
      end
      amount = positive_input("Enter loan amount")
      rate = positive_input("Enter rate of interest")
      years = positive_input("Enter year")
      si = cal_si(amount, rate, years)
      customer = @store.customers[cust_id].cust_name
      loan = Loan.new(loan_id, customer, cust_id, amount, rate, years, si)
      @store.loans[loan_id] = loan
      @store.transactions << Transaction.new("loan_request", cust_id, amount)
      puts "Loan request created"
      p @store.loans
      p @store.transactions
    end

    def show_account
      puts "enter customer id"
      cust_id = gets.to_i

      @store.accounts.each do |acc_id, account|
        if account.cust_id == cust_id
          puts "account id: #{acc_id}, balance: #{account.balance}"
        end
      end
    end

    def repay_loan
      cust_id = validate_id("Enter customer id: ")
      customer = @store.customers[cust_id]
      unless customer
        puts "no such customer foudn"
        return
      end
      customer_loan = @store.loans.values.select {|loan| loan.customer_id == cust_id && loan.status == "Approved"}
      if customer_loan.empty?
        puts "You don't have any aproved loan.."
        return
      end
      puts "\nYour approved loans:"
      customer_loan.each do |loan|
        puts "Loan id : #{loan.loan_id}"
        puts "Principal: #{loan.amount}"
        puts "EMI; #{loan.emi}"
        puts "Remaiining amount: #{loan.remaining_amount}"
        puts "Emis paid: #{loan.emis_paid}"
        puts "Total emis: #{loan.total_emis}"
        puts "Status: #{loan.status}"
      end
      loan_id = validate_id("Enter id of loan whose emi you wantto pay:")
      loan = customer_loan.find{|l| l.loan_id == loan_id}
      unless loan
        puts "invalid loan id or loan already closed"
      end

      acc = @store.accounts[cust_id]
      if acc.balance < loan.emi
       puts "Insufficient balance to pay EMI"
       return
      end
      if acc
        acc.withdraw(loan.emi)
      end
      # binding.pry
      payment = loan.repay
      p payment
      puts "Emi paymnet successuful"
      puts "Emi paid: #{payment[:emi_paid]}"
      puts "Interest paid: #{payment[:interest_paid]}"
      puts "principal amount paid: #{payment[:amount_paid]}"
      puts "remaining amout: #{payment[:remaining_amount]}"
      puts "Congratulations you have fully paid your loan" if loan.status == "Closed"
    end
    def amount_greater_than_balance
      cust_id= validate_id("Enter customer id: ")
      acc = @store.accounts[cust_id]
      loan = @store.loans.select{|loan| loan.amount > acc.balance}
      p loan
    end
  end
end