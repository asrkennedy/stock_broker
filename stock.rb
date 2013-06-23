class Stock

  attr_accessor :name, :number_shares
  attr_reader :share_price

  def initialize (name, number_shares, share_price)
    @name = name
    @number_shares = number_shares.to_i
    @share_price = share_price
  end

  def to_s
    "#{name}, at #{share_price} per share. You have #{number_shares} shares, which is a total of #{number_shares.to_i*share_price.to_f} pounds."
  end




end
