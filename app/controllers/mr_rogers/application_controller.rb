class MrRogers::ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  layout 'admin'
end
