# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application

use Rack::Cors do
  allow do
    # origins 'localhost:3000', '127.0.0.1:3000', 'localhost:4567'
    origins '*'
    resource '*', :headers => :any, :methods => :any
  end
end
