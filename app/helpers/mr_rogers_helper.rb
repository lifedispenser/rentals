module MrRogersHelper
  def nav_class(link)
    controller.controller_name.downcase.include?(link) ? 'active' : ''
  end
end
