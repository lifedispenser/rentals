module ApplicationHelper
  def nav_class(path)
    request_path = request.path
    return 'active' if request_path.to_s == path
    path_array = request_path.to_s.split('/')
    'active' if path_array[1] == rentals_path.split('/')[1] && path_array[2] =~ /^[0-9]+$/ and path == rentals_path
  end
end
