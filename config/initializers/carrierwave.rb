CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     ENV["aws_access_key_id"],                        # required
    aws_secret_access_key: ENV["aws_secret_access_key"],                        # required
    region:                'eu-west-1',          # optional, defaults to 'us-east-1'
    path_style: true,   # optional, defaults to nil
    #host:                  's3.example.com',             # optional, defaults to nil
    endpoint:              'https://s3.eu-west-1.amazonaws.com'
  }
  config.fog_directory  = 'greffe-sans-frais'                         # required
  config.fog_public     = true
  config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" }                                   # optional, defaults to true
  #config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
end
