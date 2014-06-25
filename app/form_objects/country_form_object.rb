class CountryFormObject < BaseFormObject
  attribute :id, Integer
  attribute :user, User
  attribute :visited, Boolean


  # @return [Boolean]
  def visited
    @visited ||= @user.countries.include?(country)
  end

  # @return [Country]
  #
  # @raise [ActiveRecord::RecordNotFound]
  def country
    Country.find(@id)
  end

  # @return [void]
  protected def persist!
    if @visited
      currency = Currency.find_by!(country_id: country)
      CollectionItem.find_or_create_by!(user: @user, currency: currency)
    else
      CollectionItem.
        joins(:currency).
        where(user: @user, currencies: {country_id: country}).
        delete_all
    end
  end
end
