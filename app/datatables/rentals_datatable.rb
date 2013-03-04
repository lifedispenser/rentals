class RentalsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view
  include Rails.application.routes.url_helpers

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Rental.count,
      iTotalDisplayRecords: rentals.total_entries,
      aaData: data
    }
  end

private

  def data
    rentals.map do |rental|
      [
        link_to(rental.id, edit_mr_rogers_rental_path(rental)),
        link_to(rental.name, edit_mr_rogers_rental_path(rental)),
        link_to(rental.description, edit_mr_rogers_rental_path(rental))
      ]
    end
  end

  def rentals
    @rentals ||= fetch_rentals
  end

  def fetch_rentals
    rentals = Rental.order("#{sort_column} #{sort_direction}")
    rentals = rentals.page(page).per_page(per_page)
    if params[:sSearch].present?
      rentals = rentals.where("name like :search", search: "%#{params[:sSearch]}%")
    end
    rentals
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[id name description]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end

