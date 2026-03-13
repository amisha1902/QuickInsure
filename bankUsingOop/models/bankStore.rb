module BankManagementSystem
  class BankStore
    attr_accessor :customers, :accounts, :transactions, :loans
    def initialize
      @customers = {}
      @accounts = {}
      @transactions = []
      @loans = {}
    end
  end
end