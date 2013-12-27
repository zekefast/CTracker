class CountriesController < ApplicationController
  # GET /countries.xml
  # GET /countries.json
  def index
    @countries = Country.all

    respond_to do |format|
      format.xml  { render xml:  @countries.to_xml(only: [:id, :name, :code], skip_types: true) }
      format.json { render json: @countries.to_json(only: [:id, :name, :code]) }
    end
  end

  # GET /countries/1.xml
  # GET /countries/1.json
  def show
    @country = Country.find(params[:id])

    respond_to do |format|
      format.xml  { render xml:  @country.to_xml(only: [:id, :name, :code], skip_types: true) }
      format.json { render json: @country.to_json(only: [:id, :name, :code]) }
    end
  end
end
