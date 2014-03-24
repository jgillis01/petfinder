# Place all api methods within the module below
#
module PetFinderAPI

  # TODO: Make sure all api calls are implemented
  FIND_PET = {
    :method => 'pet.find',
    :parameters => [
      { :name => 'animal', :optional => true },
      { :name => 'breed', :optional => true },
      { :name => 'size', :optional => true },
      { :name => 'sex', :optional => true },
      { :name => 'location', :optional => false },
      { :name => 'age', :optional => true },
      { :name => 'offset', :optional => true },
      { :name => 'count', :optional => true },
      { :name => 'output', :optional => true },
      { :name => 'format', :optional => true }
    ] 
  }

  RANDOM_PET = {
    :method => 'pet.getRandom',
    :parameters => [
      { :name => 'animal', :optional => true },
      { :name => 'breed', :optional => true },
      { :name => 'size', :optional => true },
      { :name => 'sex', :optional => true },
      { :name => 'location', :optional => true },
      { :name => 'shelterid', :optional => true },
      { :name => 'output', :optional => true },
      { :name => 'format', :optional => true }
    ]
  }

  FIND_SHELTER = {
    :method => 'shelter.find',
    :parameters => [
      { :name => 'location', :optional => false },
      { :name => 'name', :optional => true },
      { :name => 'offset', :optional => true },
      { :name => 'count', :optional => true },
      { :name => 'format', :optional => true }
    ]
  }

  SHELTER_BY_BREED = {
    :method => 'shelter.listByBreed',
    :parameters => [
      { :name => 'animal', :optional => false },
      { :name => 'breed', :optional => false },
      { :name => 'offset', :optional => false },
      { :name => 'count', :optional => false },
      { :name => 'format', :optional => false }
    ]
  }

  SHELTER_GET_PETS = {
    :method => 'shelter.getPets',
    :parameters => [
      { :name => 'id', :optional => false },
      { :name => 'status', :optional => true },
      { :name => 'offset', :optional => true },
      { :name => 'count', :optional => true },
      { :name => 'output', :optional => true },
      { :name => 'format', :optional => true }
    ]
  }

  BREED_LIST = {
    :method => 'breed.list',
    :parameters => [
      { :name => 'animal', :optional => false },
      { :name => 'format', :optional => true }
    ]
  }

end
