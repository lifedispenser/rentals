module ApplicationHelper
  def nav_class(link)
    'active' if controller.controller_name.downcase.include?(link)
  end
end
