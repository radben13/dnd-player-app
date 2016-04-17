class Character < ActiveRecord::Base
  include ConfiguringObject
  
  belongs_to :player
  has_many :levels, class_name: "CharacterLevel", dependent: :destroy
  has_many :journal_entries
  has_and_belongs_to_many :items
  has_and_belongs_to_many :special_attributes
  
  
  def level
    self.levels.count
  end
  
end