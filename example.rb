require_relative './model/change'
require_relative './model/currency'
require_relative './model/machine'

#This example assembles the currency chain, machine and funnels user input to the library.
@machine = Machine.new()
@penny = Currency.new("Penny", "Pennies", 1, nil, @machine)
@nickle = Currency.new("Nickle", "Nickles", 5, @penny, @machine)
@dime = Currency.new("Dime", "Dimes", 10, @nickle, @machine)
@quarter = Currency.new("Quarter", "Quarters", 25, @dime, @machine)
@one = Currency.new("One", "Ones", 100, @quarter, @machine)
@five = Currency.new("Five", "Fives", 500, @one, @machine)
@ten = Currency.new("Ten", "Tens", 1000, @five, @machine)
@twenty = Currency.new("Twenty", "Twenties", 2000, @ten, @machine)
@fifty = Currency.new("Fifty", "Fifties", 5000, @twenty, @machine)
@hundred = Currency.new("Hundred", "Hundreds", 10000, @fifty, @machine)
@machine.largest_currency = @hundred

input = ""
until input.downcase.eql?("exit")
  puts "Type an amount to convert, or exit to exit."
  puts "EG: 110.22"
  input = gets.chomp
  unless input.downcase.eql?("exit")
    @machine.make_change(input.to_f)
  end
end
