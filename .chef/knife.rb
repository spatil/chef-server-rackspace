# See http://docs.opscode.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "shaileshp"
client_key               "#{current_dir}/shaileshp.pem"
validation_client_name   "joshsoftware-validator"
validation_key           "#{current_dir}/joshsoftware-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/joshsoftware"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
