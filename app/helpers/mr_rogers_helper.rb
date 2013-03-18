module MrRogersHelper
  def nav_class(link)
    'active' if controller.controller_name.downcase.include?(link)
  end
  
  def input_class(obj, attribute)
    'error' unless obj.errors.messages[attribute].blank?
  end
  
  def input_error_help(obj, attribute)
    Haml::Engine.new("%span.help-inline #{obj.errors.messages[attribute]}").render unless obj.errors.messages[attribute].blank?
  end
end
