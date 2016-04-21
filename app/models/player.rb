class Player < ActiveRecord::Base
  has_secure_password
  has_secure_token :auth_token
  has_many :player_sessions, dependent: :destroy
  has_many :characters, dependent: :destroy
  has_many :roles, dependent: :destroy
  
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  
  accepts_nested_attributes_for :roles
  
  before_save do
    self.activated = self.activated || "not activated"
  end
  
  after_create do
    self.roles.create(name: "player")
  end
  
  # DM is a priviledged player to build campaigns
  def is_dm?
    self.roles.where(name: "dm").any?
  end
  
  # GM is the equivalent of an admin
  def is_gm?
    self.roles.where(name: "gm").any?
  end
  
end