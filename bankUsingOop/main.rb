require "./bank"
bank = BankService.new
choice = 0
while choice!=9
  puts "--Bank Management System-----"
  puts "1.Add customer"
  puts "2.Create account"
  puts "3.Deposit"    
  puts "4.Withdraw"
  puts "5.Transfer money"
  puts "6.Request loan"
  puts "7.View all custommers"
  puts "8.View account for particular customer"
  puts "9.Exit"
  puts "Enter your choice"
  choice = gets.to_i
  case choice
  when 1
     bank.create_customer
  when 2
    bank.create_account
  when 3
    bank.deposit
  when 4
    bank.withdraw
  when 5
    bank.transfer_money
  when 6
    bank.request_loan
  when 7
    bank.show_customer
  when 8
    bank.show_account
  when 9
    puts "Exiting"
    break
  else
    puts "Invalid choice"
  end
end
