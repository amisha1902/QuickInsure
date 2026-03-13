require './models/bankStore'
require './models/account'
require 'tty-prompt'
require './modules/input_validator'
module BankManagementSystem
  class AdminService
    include InputValidator
    def initialize(store)
      @store = store
    end

    def view_all_loan_request
      if @store.loans.empty?
      puts "No loan requests found"
      return
      end
      puts "\nLoan Requests:\n"
      @store.loans.each do |id, loan|
        puts "Loan ID: #{id}"
        puts "Customer ID: #{loan.customer_id}"
        puts "Customer Name: #{loan.customer_name}" 
        puts "Amount: #{loan.amount}"
        puts "Rate: #{loan.rate}"
        puts "Years: #{loan.years}"
        puts "Interest: #{loan.interest}"
        puts "Status: #{loan.status}"
        puts "-----------------------------"
      end
    end

    def approve_loan
      prompt = TTY::Prompt.new
      pending_loans = @store.loans.select {|id, loan| loan.status == "Pending"}
      if pending_loans.empty?
        puts "No pending loans"
        return
      end
      choices = pending_loans.map do |id, loan|
        {
          name: "Loan #{id}| Customer id:  #{loan.customer_id} | Customer Name: #{loan.customer_name} | Amount #{loan.amount}",
          value: id
        }
      end
      select_loan = prompt.select("select loan to approve", choices)
      loan = @store.loans[select_loan]
      loan.approve

      account = @store.accounts.values.find {|acc| acc.cust_id == loan.customer_id}
      if account
        account.deposit(loan.amount)
        customer = @store.customers[loan.customer_id]
        puts "loan amount creadited to #{customer.cust_name}'s account"
      else
        puts "no customer ofund"
      end
    end

    def show_customer
      @store.customers.each do |id, customer|
        puts "#{id} => #{customer.cust_name}"
      end
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

    def amount_greater_than_balance
      cust_id= validate_id("Enter customer id: ")
      acc = @store.accounts[cust_id]
      unless acc
        puts "no such acc exists"
      end
      loan_gt = @store.loans.values.select do |loan| 
        loan.customer_id == acc.cust_id && loan.amount > 5 * acc.balance
      end
      if loan_gt.empty?
        puts "no such loan present whose principal amount is greater than 5 time its balance"
      else
        p loan_gt
      end
    end
  end
end