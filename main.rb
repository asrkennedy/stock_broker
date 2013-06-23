require 'pry'
require 'yahoofinance'

require_relative 'stock'
require_relative 'portfolio'
require_relative 'client'
require_relative 'broker'

b = Broker.new

def menu
  puts "------Welcome to the Stock Brokerage App!------"
  puts
  puts "What would you like to do today?"
  puts
  puts "1) Register a new client"
  puts "2) Add a portfolio"
  puts "3) Buy some stock"
  puts "4) See client list"
  puts "5) See client portfolios"
  puts "6) Find out how much all of a client's stocks are worth"
  puts "Q) Quit the program"
  gets.chomp.downcase
end

def new_client
  b = Broker.new
  puts "Enter the new client's name:"
  name = gets.chomp
  puts "Enter the new client's age:"
  age = gets.chomp
  puts "Enter the new client's sex:"
  sex = gets.chomp.downcase
  puts "Enter the new client's budget:"
  budget = gets.chomp
  c = Client.new name, age, sex, budget.to_i
  puts c.to_s
  b.clients << c
  c
end

def new_portfolio
  puts "Enter a name for your new stock portfolio:"
  puts
  portfolio_name = gets.chomp
  puts "\nYou now have a new portfolio called '#{portfolio_name}.'"
  p = Portfolio.new portfolio_name
end

def select_portfolio
    puts "What portfolio would you like to add your stock to?"
    selected_portfolio = gets.chomp
end

def get_price (stock_name)
     share_price = YahooFinance::get_quotes(YahooFinance::StandardQuote, stock_name)[stock_name].lastTrade
end


andrea = Client.new "Andrea", 24, "female", 10000
stuart = Client.new "Stuart", 26, "male", 86798
les = Client.new "Les", 62, 'male', 100287
ilona = Client.new "Ilona", 63, "female", 67392

b.clients << andrea << stuart << les << ilona

response = menu

while response != 'q'
  case response

  when '1'
    b.clients << new_client
    puts
    puts "Press enter to return to main menu"


  when '2'
    while true
      puts "Which client are you?"
      puts
      x = 1
      while x < (b.clients.size) + 1
        print "#{x})"
        puts "#{b.clients[x-1].to_s}"
        x += 1
      end
      index = gets.chomp
      if index.to_i > 0
        if index.to_i < (b.clients.size) + 1
        client = b.clients[index.to_i-1]
        client.portfolios << new_portfolio
        puts
        if client.portfolios.empty?
          puts p.to_s
        end
        break
      else
        puts "Please enter a number between 1 and #{b.clients.size}. Press enter to return to the menu."
        gets
      end
      else puts "Please enter a number. Press enter to continue."
        gets
        puts
     end
    end


  when '3'
    while true
    puts "Which client are you?"
    puts
    x = 1
    while x < (b.clients.size) + 1
      print "#{x})"
      puts "#{b.clients[x-1].to_s}"
      x += 1
    end
    index = gets.chomp
     if index.to_i > 0
          if index.to_i < (b.clients.size) + 1
              client = b.clients[index.to_i-1]
              if client.portfolios.size < 1
                puts "You do not have any portfolios set up yet. \nPlease set up a portfolio before buying stock."
                break
              else
                puts
                puts "What is the ticker symbol for the stock you would like to buy?"
                stock_name = gets.chomp
                puts
                value = get_price stock_name
                if value == 0
                  puts "This is not a valid stock name. Please visit http://www.eoddata.com/stockList/NASDAQ.htm to look up the symbol you are looking for."
                else
                puts "This stock is selling at #{value.to_f} per share. How much would you like to buy?"
                number_share = gets.chomp
                puts
                s = Stock.new stock_name, number_share, value
                puts s.to_s
                p_value = (number_share.to_i*value.to_f)
                puts
                if (client.budget) - p_value.to_f < 0
                  puts "I'm sorry you don't have enough money to buy that much stock! Press enter to return to the menu."
                else
                    client.budget = (client.budget) - p_value.to_f
                    puts "You now have #{(client.budget)} pounds left."
                    while true
                    puts "Which portfolio would you like to add #{stock_name} stocks to?"
                    x = 1
                    while x < (client.portfolios.size) + 1
                      print "#{x})"
                      puts "#{client.portfolios[x-1].to_s}"
                      x += 1
                    end
                    index = gets.chomp
                      if index.to_i > 0
                        if index.to_i < client.portfolios.size + 1
                        portfolio = client.portfolios[index.to_i-1]
                        print "#{stock_name} has now been added to "
                        print portfolio.to_s
                        portfolio.stock << s
                        break
                        else
                           puts "Please enter a number between 1 and #{client.portfolios.size}."
                        gets
                        end
                      else
                        puts "Please enter a number. Press enter to return to the menu."
                        puts
                      end
                      end
                end
                end
              end
              break
          else
            puts "Please enter a number between 1 and #{b.clients.size}. Press enter to return to the menu."
            gets
          end
      else
        puts "Please enter a number. Press enter to continue."
        gets
      end
    end

  when '4'
      puts "Our clients are:"
      puts
      b.clients.each { |client| puts client.to_s }
      puts "Press enter to return to the main menu."

  when '5'
    while true
    puts "Enter the number of the client portfolio you would you like to see:"
   puts
      x = 1
      while x < (b.clients.size) + 1
        print "#{x})"
        puts "#{b.clients[x-1].to_s}"
        x += 1
      end
       index = gets.chomp
    if index.to_i > 0
      if index.to_i < (b.clients.size) + 1
      client = b.clients[index.to_i-1]
          while true
                  if client.portfolios.size < 1
                    puts "#{client.name} doesn't have any portfolios."
                    break
                  else
                        puts "Which portfolio would you like to view?"
                        puts "#{client.name}'s portfolios include: \n"
                        x = 1
                        while x < (client.portfolios.size) + 1
                          print "#{x})"
                          puts "#{client.portfolios[x-1].to_s}"
                          x += 1
                        end

                        index = gets.chomp
                              if index.to_i > 0
                              portfolio = client.portfolios[index.to_i-1]
                                  if portfolio.stock.size > 0
                                  print "#{portfolio.to_s} stocks include: \n"
                                  puts portfolio.list_stocks
                                  break
                                else
                                  puts "This portfolio does not have any stocks!"
                                  break
                                end
                              else
                                puts "Please enter a number. Press enter to return to menu."
                                gets
                              end

                  end
          end
          break
    else
      puts "Please enter a number between 1 and #{b.clients.size}. Press enter to return to the menu."
      gets
    end
    else
      puts "Please enter a number. Press enter to return to menu."
      gets
    end
  end



  when '6'
        puts "Which client's worth would you like to see?"
        puts
        x = 1
        while x < (b.clients.size) + 1
          print "#{x})"
          puts "#{b.clients[x-1].to_s}"
          x += 1
        end
        index = gets.chomp
          if index.to_i > 0
            client = b.clients[index.to_i-1]
        # x = 1
        # while x < (client.portfolios.size) + 1
        #   print "#{x})"
        #   puts "#{client.portfolios[x-1].to_s}"
        #   x += 1
        # end
          if client.portfolios.size < 1
            puts "This client has no stocks."
          else
            x =1
            worth_array = []
            while x < (client.portfolios.size) + 1
             client.portfolios[x-1].stock.each do |stock|
              worth_array << ((stock.number_shares).to_i*(stock.share_price).to_f).to_f
                end
            portfolio_worth = worth_array.inject {|sum,x| sum + x }
            x+= 1
            end
            client_worth = []
              client.portfolios.each do |portfolio|
                client_worth << portfolio_worth
              end
            client_value = client_worth.inject{|sum,x| sum + x}
            if client_value == nil
              puts "This client has no stocks."
            else
            puts "#{client.name} is worth #{client_value/(client.portfolios.size)}."
          end
          end
        else
          puts "Please enter a number"
          gets
        end



        # puts "Which portfolio would you like to view?"
        # index = gets.chomp
        # portfolio = client.portfolios[index.to_i-1]
        # #binding.pry

          # client.portfolios.stock.each do |stock|


  else
    puts "Please enter numbers 1-6 or Q."
  end
  gets
  response = menu
end


binding.pry



