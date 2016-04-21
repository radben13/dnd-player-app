module ConfiguringObject
  extend ActiveSupport::Concern
  
  def get_config
    JSON.parse self.config_data
  end
  
  def set_config (data)
    self.config_data = data.to_json
  end
end