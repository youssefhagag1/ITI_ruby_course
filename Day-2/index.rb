# logger.rb
module Logger
  LOG_FILE = "app.log"

  def write_log(type, message)
    File.open(LOG_FILE, "a") do |file|
      file.puts("#{Time.now.iso8601} -- #{type} -- #{message}")
    end
  end

  def log_info(message)
    write_log("info", message)
  end

  def log_warning(message)
    write_log("warning", message)
  end

  def log_error(message)
    write_log("error", message)
  end
end

# =========================

require "time"

class User
  attr_reader :name
  attr_accessor :balance

  def initialize(name, balance)
    @name = name
    @balance = balance
  end

  def update_balance(value)
    if @balance + value < 0
      raise "Not enough balance"
    end

    @balance += value
  end
end

# =========================

class Transaction
  attr_reader :user, :value

  def initialize(user, value)
    @user = user
    @value = value
  end

  def to_s
    "User #{@user.name} transaction with value #{@value}"
  end
end

# =========================

class Bank
  def process_transactions(transactions, &callback)
    raise NotImplementedError, "You must implement process_transactions"
  end
end

# =========================

class CBABank < Bank
  include Logger

  def initialize(users)
    @users = users
  end

  def process_transactions(transactions, &callback)
    log_info(
      "Processing Transactions #{transactions.map(&:to_s).join(', ')}..."
    )

    transactions.each do |transaction|
      begin
        unless @users.include?(transaction.user)
          raise "#{transaction.user.name} not exist in the bank!!"
        end

        transaction.user.update_balance(transaction.value)

        log_info("#{transaction} succeeded")

        if transaction.user.balance == 0
          log_warning("#{transaction.user.name} has 0 balance")
        end

        callback.call(
          "success of #{transaction}"
        )

      rescue => e
        log_error("#{transaction} failed with message #{e.message}")

        callback.call(
          "failure of #{transaction} with reason #{e.message}"
        )
      end
    end
  end
end

# =========================
# Main

users = [
  User.new("Ali", 200),
  User.new("Peter", 500),
  User.new("Manda", 100)
]

out_side_bank_users = [
  User.new("Menna", 400)
]

transactions = [
  Transaction.new(users[0], -20),
  Transaction.new(users[0], -30),
  Transaction.new(users[0], -50),
  Transaction.new(users[0], -100),
  Transaction.new(users[0], -100),
  Transaction.new(out_side_bank_users[0], -100)
]

bank = CBABank.new(users)

bank.process_transactions(transactions) do |result|
  puts "Call endpoint for #{result}"
end
