class CollectionDatatable
  # @return [Integer] default number of items per each page
  DEFAULT_TABLE_PER_PAGE_LENGTH = 25

  # @return [Array<String>] list of sort column names
  COLUMNS = %w[
    countries.name
    countries.code
    currencies.name
    currencies.code
  ].freeze


  def initialize(view, user)
    @view = view
    @user = user
  end

  def as_json(options = {})
    {
      sEcho:                @view.params[:sEcho].to_i,
      iTotalRecords:        ::CountriesCurrency.count,
      iTotalDisplayRecords: items.except(:limit, :offset).count,
      aaData:               data
    }
  end

private

  def data
    items.map do |cc|
      [
        @view.check_box_tag("user[countries_currencies][]", cc.id, @user.owned?(cc)),
        cc.country.name,
        cc.country.code,
        cc.currency.name,
        cc.currency.code
      ]
    end
  end

  # @return [ActiveRecord::Relation]
  def items
    @items ||= fetch_items
  end

  # @return [ActiveRecord::Relation] collection to show in a table
  def fetch_items
    items = CountriesCurrency.
      includes(:country, :currency).
      order("#{sort_column} #{sort_direction}").
      page(page).
      per(per_page)

    if @view.params[:sSearch].present?
      items = items.where("
        countries.name like :search OR
          countries.code like :search OR
            currencies.name like :search OR
              currencies.code like :search",
        search: "%#{@view.params[:sSearch]}%")
    end

    items
  end

  # @return [Integer] number of page to display
  def page
    @view.params[:iDisplayStart].to_i/per_page + 1
  end

  # @return [Integer] displayed quantity items
  def per_page
    length = @view.params[:iDisplayLength].to_i

    length > 0 ? length : DEFAULT_TABLE_PER_PAGE_LENGTH
  end

  # @return [String] name of the sorting column
  def sort_column
    COLUMNS[@view.params[:iSortCol_0].to_i - 1]
  end

  # @return [String] abbreviation of sorting direction name
  def sort_direction
    @view.params[:sSortDir_0] == "desc" ? "DESC" : "ASC"
  end
end
