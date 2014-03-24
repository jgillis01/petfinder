require './lib/helpers'

describe Helpers do
  
  describe "#normalize" do
    it "turns api methods into underscore methods" do
      test = Helpers.normalize("EAT.CHICKEN")
      expect(test).to eq("eat_chicken")
    end

  end

end
