class CurrenciesController < ApplicationController
  # GET /currencies.xml
  # GET /currencies.json
  def index
    @currencies = Currency.all

    respond_to do |format|
      format.xml  { render xml:  @currencies.to_xml(only: [:id, :name, :code], skip_types: true) }
      format.json { render json: @currencies.to_json(only: [:id, :name, :code]) }
    end
  end

  # GET /currencies/1.xml
  # GET /currencies/1.json
  def show
    @currency = Currency.find(params[:id])

    respond_to do |format|
      format.xml  { render xml:  @currency.to_xml(only: [:id, :name, :code], skip_types: true)  }
      format.json { render json: @currency.to_json(only: [:id, :name, :code]) }
    end
  end
end
