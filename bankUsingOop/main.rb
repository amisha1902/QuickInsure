require "./service/bank_service"
bank = BankManagementSystem::BankService.new
choice = 0
while choice!=1
  puts "--Bank Management System-----"
  puts "1.Exit"
  puts "2.Create account"
  puts "3.Deposit"    
  puts "4.Withdraw"
  puts "5.Transfer money"
  puts "6.Request loan"
  puts "7.View all custommers"
  puts "8.View account for particular customer"
  puts "Enter your choice"
  choice = gets.to_i
  case choice
  when 1
     puts "Exit"
     break
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
  else
    puts "Invalid choice"
  end
end
