module Helpers

  def self.normalize(name)
    name.downcase.gsub(/\./,'_')
  end

end
