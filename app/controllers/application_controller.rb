class ApplicationController < ActionController::API
  include JwtAuthenticatable
  before_action :authorized
end
