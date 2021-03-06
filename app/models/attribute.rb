class SpecialAttribute < ActiveRecord::Base
  include ConfigurableObject
  
  has_and_belongs_to_many :characters
  has_and_belongs_to_many :items
  
  before_save do
    self.config_data ||= "{}"
  end
end