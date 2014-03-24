require './lib/pet_finder'
require './lib/pet_finder_api'
require './lib/helpers'

describe PetFinder do
  before :each do
    @pet_finder = PetFinder.new('secretz')
  end

  # Validate all API endpoints are available on
  # the class
  describe "it responds to all api methods" do
    PetFinderAPI.constants.each do |const|
      endpoint = PetFinderAPI.module_eval const.to_s
      method = Helpers.normalize(endpoint[:method])
      it "maps api method ##{const}" do
        expect(@pet_finder).to respond_to(method)
      end
    end
  end

  # Make sure the gather_params method only selects the actual parameters
  # from the available parameters passed.  This prevents sending junk parameters
  # in the API calls.
  describe "#gather_params" do
    it "gathers only the available parameters from the actual hash" do
      hash = @pet_finder.send(
        :gather_params,
        {},
        {'one' => 1, 'two' => 2, 'three' => 3},
        [{name: 'one'},{name: 'two'}]
      )
      expect(hash).to eq({'one' => 1, 'two' => 2})
      expect(hash[:three]).to be_nil
    end

  end

  describe "#create_url" do
    it "creates a url from passed parameters" do
      url = @pet_finder.send(:create_url, 'test_me', {'key' => 'abcd' })
      expect(url).to eq('http://api.petfinder.com/test_me?key=abcd')
    end
  end

end
