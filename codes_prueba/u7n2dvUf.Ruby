class Calculator
  def set_numbers
    loop do
      puts "Please type num1:"
      @num1 = gets.chomp
      puts "Please type num2:"
      @num2 = gets.chomp
      break if Numbers.valid?(@num1, @num2)
      puts "[!] Please type valid numbers."
    end
  end
  
  def set_operator
    loop do
    puts "Please select operator 1) + 2) - 3) * 4) /"
    @operator = gets.chomp
    break if Operator.valid?(@operator)
    puts "[!] Please type a valid operator number."
    end
  end
  
  def result
    puts "Result: #{calculate(@num1, @num2, @operator)}"
  end
  
  private
  
  def calculate(num1, num2, operator)
    result =
    case operator
    when "1" then num1.to_i + num2.to_i
    when "2" then num1.to_i - num2.to_i
    when "3" then num1.to_i * num2.to_i
    when "4" then num1.to_f / num2.to_f
    end
    result
  end
end

class Numbers
  def self.valid?(num1, num2)
    true if num1.match(/\A\d+\z/) && num2.match(/\A\d+\z/)
  end
end

class Operator
  def self.valid?(operator)
    true if (1..4).include?(operator.to_i)
  end
end

my_calc = Calculator.new
my_calc.set_numbers
my_calc.set_operator
my_calc.result