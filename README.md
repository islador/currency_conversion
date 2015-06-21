# Problem Statement

Build a program to calculate change in proper denominations after accepting a starting USD$ value. For example, a starting value of $11.00 would result in (1) $10 and (1) $1 bills.

##Design specs
1. Make use of all common USD$ denominations
2. Calculate change using the minimum number of bills and coins necessary
3. Assume infinite amounts of each denomination in change machine
4. Functioning program must be demonstrable to reviewers in some fashion
5. Common USD$ denominations include:
  * 100, 50, 20, 10, 5 and 1 dollar bills
  * 25, 10, 5 and 1 cent pieces

# Solution Statement

This program uses a moderately more complicated, but slightly DRYer linked list with recursion approach instead of an iterative approach. Computationally it should be roughly identical in difficulty, though may run into memory and stack limitations with larger datasets.

I elected to use this approach because it was funner, and code challenges should be fun. In a production environment, I would opt for an iterative approach with an array and two loops. You can see a pseudo-code example below. I would opt for this in production because it is simpler to understand and that simplicity is worth far more than my fun in the long term.

```ruby
current_value = 100
currency_array = [hundred, fifty, twenty, ten, five, one, quarter, dime, nickle, penny]
change = []
currency_array.each do |currency|
  while current_value > currency.value
    if current_value - currency.value > 0
      change << currency.new
      current_value = current_value - currency.value
    end
  end
end

return change

```

# Usage Instructions
To run the example contained in currency_conversion:

cd into the directory
run
```
ruby example.rb
```
and follow the on-screen prompts.

# Testing Instructions
To run the specs contained in currency_conversion:
cd into the directory
run
```
rspec
```

All specs will run with documentation by default.
