module ConfiguringObject
  extend ActiveSupport::Concern
  
  before_save do
    self.config_data ||= "{}"
  end
  
  def get_config
    JSON.parse self.config_data
  end
  
  def set_config (data)
    self.config_data = data.to_json
  end
end