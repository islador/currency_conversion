require 'spec_helper'

require_relative '../model/change'
require_relative '../model/currency'
require_relative '../model/machine'

describe Change do

  before do
    @change = Change.new()
    @machine = Machine.new()
  end

  subject {@change}

  it { is_expected.to respond_to(:amounts) }

  describe "add_currency" do
    it "throws an error if a currency object is not passed" do
      expect {@change.add_currency("Cash")}.to raise_error(ArgumentError)
    end

    context "amounts hash does not contain that name" do
      it "adds the currency's name to the amounts hash" do
        expect(@change.amounts["Penny"]).to be_nil
        @change.add_currency(Currency.new("Penny", "Pennies", 1, nil, @machine))
        expect(@change.amounts["Penny"]).not_to be_nil
      end

      it "adds a value of one to amounts['currency_name']" do
        expect(@change.amounts["Penny"]).to be_nil
        @change.add_currency(Currency.new("Penny", "Pennies", 1, nil, @machine))
        expect(@change.amounts["Penny"]).to be 1
      end
    end

    context "amounts hash contains that name" do
      before do
        @penny = Currency.new("Penny", "Pennies", 1, nil, @machine)
        @change.amounts.store("Penny", 1)
        @change.currencies.store("Penny", @penny)
      end
      it "increments the value of amounts['currency_name']" do
        expect(@change.amounts["Penny"]).not_to be_nil
        expect(@change.amounts["Penny"]).to be 1
        @change.add_currency(@penny)
        expect(@change.amounts["Penny"]).to be 2
      end
    end
  end

  describe "reset" do
    before do
      @change.amounts.store("Hundred", 1)
      @change.amounts.store("Fifty", 1)
    end

    it "blanks the amounts hash" do
      @change.reset
      expect(@change.amounts).to be_empty
    end
  end

  describe "to_s" do
    before do
      @twenty = Currency.new("Twenty", "Twenties", 2000, nil, @machine)
      @fifty = Currency.new("Fifty", "Fifties", 5000, @twenty, @machine)
      @hundred = Currency.new("Hundred", "Hundreds", 10000, @fifty, @machine)
      @change.currencies = {"Hundred" => @hundred, "Fifty" => @fifty, "Twenty" => @twenty}
      @change.amounts = {"Hundred" => 2, "Fifty" => 1, "Twenty" => 2}
    end
    it "returns a formatted string of the amounts hash" do
      expect(@change.to_s).to match "Change:\n2 Hundreds\n1 Fifty\n2 Twenties\n"
    end
  end
end
