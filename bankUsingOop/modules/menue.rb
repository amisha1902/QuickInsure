module Menue

  def self.main_menu
    puts "1.Exit"
    puts "2.Customer"
    puts "3.Admin"
  end

  def self.customer_menu
    puts "1.Exit"
    puts "2.Create account"
    puts "3.Deposit"    
    puts "4.Withdraw"
    puts "5.Transfer money"
    puts "6.Request loan"
    puts "7.Check my account"
    puts "8.Pay EMI"
    puts "Enter your choice"
  end

  def self.admin_menu
    puts "1.Exit"
    puts "2.View all loan requests"
    puts "3.Approve loan"
    puts "4.View all customers"
    puts "5.View customer account"
    puts "6.Principal greater than balance"
  end

end