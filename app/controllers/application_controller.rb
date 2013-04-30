class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout proc{ |controller| (controller.controller_path.include? 'devise') ? 'admin' : 'application' }

  def flashy(obj)
    if obj.errors.empty?
      flash.now[:success] = 'Saved successfully'
    else
      flash.now[:error] = 'There was an error saving'
    end
  end

end
