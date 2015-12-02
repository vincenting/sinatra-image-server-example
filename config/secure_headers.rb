configure :production do
  include SecureHeaders
  before do
    set_csp_header
  end
  ::SecureHeaders::Configuration.configure do |config|
    config.x_frame_options = 'DENY'
    config.x_content_type_options = 'nosniff'
    config.x_xss_protection = {:value => 1, :mode => false}
    config.x_permitted_cross_domain_policies = 'none'
  end
end
