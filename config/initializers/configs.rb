FACEBOOK_CONFIG = YAML.load_file("#{::Rails.root}/config/facebook.yml")[::Rails.env]
TWITTER_CONFIG = YAML.load_file("#{::Rails.root}/config/twitter.yml")[::Rails.env]
MANDRILAPP_CONFIG = YAML.load_file("#{::Rails.root}/config/mandrilapp.yml")[::Rails.env]
