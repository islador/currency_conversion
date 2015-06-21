require_relative './model/change'
require_relative './model/currency'
require_relative './model/machine'

#This example assembles the currency chain, machine and funnels user input to the library.
@machine = Machine.new()
@penny = Currency.new("Penny", 1, nil, @machine)
@nickle = Currency.new("Nickle", 5, @penny, @machine)
@dime = Currency.new("Dime", 10, @nickle, @machine)
@quarter = Currency.new("Quarter", 25, @dime, @machine)
@one = Currency.new("One", 100, @quarter, @machine)
@five = Currency.new("Five", 500, @one, @machine)
@ten = Currency.new("Ten", 1000, @five, @machine)
@twenty = Currency.new("Twenty", 2000, @ten, @machine)
@fifty = Currency.new("Fifty", 5000, @twenty, @machine)
@hundred = Currency.new("Hundred", 10000, @fifty, @machine)
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
