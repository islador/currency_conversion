require 'spec_helper'

require_relative '../model/machine'

describe Machine do
  before do
    @machine = Machine.new()
    @hundred = Currency.new("Hundred", 10000, nil, @machine)
    @machine.largest_currency = @hundred
  end

  subject {@machine}

  it { is_expected.to respond_to(:change) }
  it { is_expected.to respond_to(:largest_currency) }

  describe "make_change" do
    it "calls largest_currency.add" do
      expect(@hundred).to receive(:add)
      @machine.make_change(100.00)
    end

    it "calls change.to_s" do
      expect(@machine.change).to receive(:to_s)
      @machine.make_change(100.00)
    end

    it "calls change.reset" do
      expect(@machine.change).to receive(:reset)
      @machine.make_change(100.00)
    end

    describe "correctness" do
      before do
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
      end

      it "outputs 5 hundred & 1 fifty for a dollar value of 550" do
        expect{@machine.make_change(550.00)}.to output("Change:\n5 Hundred\n1 Fifty\n").to_stdout
      end

      it "outputs 5 hundred, 1 fifty, 1 twenty for a dollar value of 570" do
        expect{@machine.make_change(570.00)}.to output("Change:\n5 Hundred\n1 Fifty\n1 Twenty\n").to_stdout
      end

      it "outputs 5 hundred, 1 fifty, 1 twenty, 1 ten for a dollar value of 580" do
        expect{@machine.make_change(580.00)}.to output("Change:\n5 Hundred\n1 Fifty\n1 Twenty\n1 Ten\n").to_stdout
      end

      it "outputs 5 hundred, 1 fifty, 1 twenty, 1 ten, and 1 five for a dollar value of 585" do
        expect{@machine.make_change(585.00)}.to output("Change:\n5 Hundred\n1 Fifty\n1 Twenty\n1 Ten\n1 Five\n").to_stdout
      end

      it "outputs 5 hundred, 1 fifty, 1 twenty, 1 ten, 1 five and 1 one for a dollar value of 586" do
        expect{@machine.make_change(586.00)}.to output("Change:\n5 Hundred\n1 Fifty\n1 Twenty\n1 Ten\n1 Five\n1 One\n").to_stdout
      end

      it "outputs 5 hundred, 1 fifty, 1 twenty, 1 ten, 1 five, 1 one and 1 quarter for a dollar value of 586.25" do
        expect{@machine.make_change(586.25)}.to output("Change:\n5 Hundred\n1 Fifty\n1 Twenty\n1 Ten\n1 Five\n1 One\n1 Quarter\n").to_stdout
      end

      it "outputs 5 hundred, 1 fifty, 1 twenty, 1 ten, 1 five, 1 one, 1 quarter and one dime for a dollar value of 586.35" do
        expect{@machine.make_change(586.35)}.to output("Change:\n5 Hundred\n1 Fifty\n1 Twenty\n1 Ten\n1 Five\n1 One\n1 Quarter\n1 Dime\n").to_stdout
      end

      it "outputs 5 hundred, 1 fifty, 1 twenty, 1 ten, 1 five, 1 one, 1 quarter, 1 dime and 1 nickle for a dollar value of 586.40" do
        expect{@machine.make_change(586.40)}.to output("Change:\n5 Hundred\n1 Fifty\n1 Twenty\n1 Ten\n1 Five\n1 One\n1 Quarter\n1 Dime\n1 Nickle\n").to_stdout
      end

      it "outputs 5 hundred, 1 fifty, 1 twenty, 1 ten, 1 five, 1 one, 1 quarter, 1 dime, 1 nickle and 1 penny for a dollar value of 586.41" do
        expect{@machine.make_change(586.41)}.to output("Change:\n5 Hundred\n1 Fifty\n1 Twenty\n1 Ten\n1 Five\n1 One\n1 Quarter\n1 Dime\n1 Nickle\n1 Penny\n").to_stdout
      end
    end
  end

  # Machine.add_currency functions as a wrapper for change.add_currency to shield Currency
  # from an unnecessary interdependency.
  describe "add_currency" do
    it "calls change.add_currency" do
      expect(@machine.change).to receive(:add_currency)
      @machine.add_currency(Currency.new("Hundred", 10000, @fifty, @machine))
    end
  end
end
