class Client

  attr_accessor :name, :age, :sex, :budget, :portfolios

  def initialize (name, age, sex, budget)
    @name = name
    @age = age
    @sex = sex
    @budget = budget
    @portfolios = []
  end

def name
  print @name
end

  def to_s
    puts "#{name} is #{sex}, #{age} years old, and has a budget of #{budget}."
  end

end