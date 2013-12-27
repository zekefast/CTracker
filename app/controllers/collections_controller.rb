class CollectionsController < ApplicationController
  # GET /collections
  # GET /collections.xml
  # GET /collections.json
  def index
    @countries_currencies              = CountriesCurrency.includes(:country, :currency).to_a
    @current_user_countries_currencies = current_user.countries_currencies.to_a

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml:  @countries_currencies.to_xml(only: [:id], include: {country: {only: [:id, :name, :code]}, currency: {only: [:id, :name, :code]}}, skip_types: true) }
      format.json { render json: @countries_currencies.to_json(only: [:id], include: {country: {only: [:id, :name, :code]}, currency: {only: [:id, :name, :code]}}) }
    end
  end
end
