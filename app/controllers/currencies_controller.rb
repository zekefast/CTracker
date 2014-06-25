class CurrenciesController < ApplicationController
  # GET /currencies
  # GET /currencies.xml
  def index
    @currencies           = Currency.all
    @collected_currencies = current_user.currencies.to_a

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @currencies }
    end
  end

  # GET /currencies/1
  # GET /currencies/1.xml
  def show
    @currency = Currency.find(params.require(:id))

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @currency }
    end
  end
end
