require "./service/customer_service"
require "./service/admin_service"
require "./models/bankStore"
require "./modules/menue"
require "./modules/input_validator"
store = BankManagementSystem::BankStore.new
customer = BankManagementSystem::CustomerService.new(store)
admin = BankManagementSystem::AdminService.new(store)

loop do
  Menue.main_menu
  puts "Enter your choice:"
  choice = gets.to_i
  case choice
  when 1 
    puts "Exiting system"
    break
  when 2
    Menue.customer_menu
    c_choice = gets.to_i
    while c_choice!=1
      case c_choice
      when 1
       puts "Exit"
       break
      when 2
       customer.create_account
      when 3
       customer.deposit
      when 4
       customer.withdraw
      when 5
       customer.transfer_money
      when 6
       customer.request_loan
      when 7
       customer.show_account
      when 8
        customer.repay_loan
      else
       puts "Invalid choice"
      end
      Menue.customer_menu
      c_choice = gets.to_i
    end 
  when 3
    Menue.admin_menu
    puts "Enter admin choice:"
    a_choice = gets.to_i
    while a_choice!=1
      case a_choice
      when 1
        puts "Exiting"
        break
      when 2
        admin.view_all_loan_request
      when 3
        admin.approve_loan
      when 4
        admin.show_customer
      when 5
        admin.show_account
      when 6
        admin.amount_greater_than_balance
      else
        puts "Invalid choice"
      end
      Menue.admin_menu
      a_choice = gets.to_i
    end
  else
    puts "Invalid choice"
  end

end

