class MrRogers::ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  layout 'admin'
  helper MrRogersHelper
  
    
  def flashy(obj)
    if obj.errors.empty?
      flash.now[:success] = 'Saved successfully'
    else
      flash.now[:error] = 'There was an error saving'
    end
  end
end
