class CountriesController < ApplicationController
  # GET /countries
  # GET /countries.xml
  def index
    @countries         = Country.all
    @visited_countries = current_user.countries.to_a

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @countries }
    end
  end

  # GET /countries/1
  # GET /countries/1.xml
  def show
    @country = Country.find(params.require(:id))

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @country }
    end
  end

  # GET /countries/1/edit
  def edit
    @form = CountryFormObject.new(params.permit(:id).merge(user: current_user))
  end

  # PUT /countries/1
  # PUT /countries/1.xml
  def update
    @form = CountryFormObject.new(country_form_object_params)

    respond_to do |format|
      if @form.save
        format.html { redirect_to(@form.country, :notice => 'Country was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @form.errors, :status => :unprocessable_entity }
      end
    end
  end

  private def country_form_object_params
    params.permit(:id).
      merge(params.require(:country_form_object).permit(:visited)).
      merge(user: current_user).
      symbolize_keys
  end
end
