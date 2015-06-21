require 'spec_helper'

require_relative '../model/currency'
require_relative '../model/machine'

describe Currency do
  before do
    @machine = Machine.new()
    @hundred = Currency.new("Hundred", "Hundreds", 10000, nil, @machine)
  end

  subject {@hundred}

  describe "initialize" do
    it "throws an argument error if the first arg is not a string" do
      expect{Currency.new(123, "Hundreds", 10000, nil, @machine)}.to raise_error(ArgumentError)
    end

    it "throws an argument error if the second arg is not a string" do
      expect{Currency.new("Hundred", 123, 10000, nil, @machine)}.to raise_error(ArgumentError)
    end

    it "throws an argument error if the third arg is not an int" do
      expect{Currency.new("Hundred", "Hundreds", 1.00, nil, @machine)}.to raise_error(ArgumentError)
    end

    it "throws an argument error if the fourth arg is not a currency or nil" do
      expect{Currency.new("Hundred", "Hundreds", 10000, @machine, @machine)}.to raise_error(ArgumentError)
    end

    it "throws an argument error if the fifth arg is not a machine" do
      expect{Currency.new("Hundred", "Hundreds", 10000, nil, nil)}.to raise_error(ArgumentError)
    end
  end

  describe "Add" do
    it "throws an argument error if not passed an int" do
      expect{@hundred.add("100")}.to raise_error(ArgumentError)
    end

    context "currency value 10000 & current_value is 50" do
      it "does not send itself to the machine" do
        expect(@machine).not_to receive(:add_currency).with(@hundred)
        @hundred.add(50)
      end

      it "calls check_next_currency" do
        expect(@hundred).to receive(:check_next_currency).exactly(1).times
        @hundred.add(50)
      end
    end

    context "currency value is 10000 & current_value is 10000" do
      it "sends itself to machine once" do
        expect(@machine).to receive(:add_currency).with(@hundred).exactly(1).times
        @hundred.add(10000)
      end

      it "calls check_next_currency" do
        expect(@hundred).to receive(:check_next_currency).exactly(1).times
        @hundred.add(10000)
      end
    end
  end

  describe "next_currency" do
    it "throws an argument error if not passed an int" do
      expect{@hundred.check_next_currency("100")}.to raise_error(ArgumentError)
    end

    context "currency.next is not nil" do
      before do
        @fifty = Currency.new("Fifty", "Fifties", 5000, nil, @machine)
        @hundred = Currency.new("Hundred", "Hundreds", 10000, @fifty, @machine)
      end

      it "runs currency.next_currency.add" do
        expect(@fifty).to receive(:add)
        @hundred.check_next_currency(5000)
      end
    end
  end
end
