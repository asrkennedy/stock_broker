class Portfolio

  attr_accessor :name, :stock
  attr_writer :worth

  def initialize (name)
    @name = name
    @stock = []
  end

  def to_s
    print @name
  end

  def list_stocks
    if @stock.size < 1
      puts "#{name} has #{@stock.size} stock(s)."
    else puts "#{name} has #{@stock.size} stock(s). The stock(s) included are:"
    puts @stock.join(', ')
    end
  end

  def list_stocks
    @stock.each do |stock|
      stock
    end
  end



 end


