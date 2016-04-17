class Item < ActiveRecord::Base
  include ConfiguringObject
  
  
  has_and_belongs_to_many :characters
  has_and_belongs_to_many :special_attributes
end