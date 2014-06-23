require "rails_helper"


RSpec.describe CountriesController, :type => :controller do
  fixtures :countries

  let(:country) { countries(:one) }


  it_behaves_like "controller does not respond to actions",
    :new     => :get,
    :destroy => :get

  it "gets index" do
    get :index

    expect(response).to have_http_status(:success)
    expect(assigns[:countries]).not_to be_nil
  end

  it "creates country" do
    expect do
      post :create, :country => country.attributes.merge({:code => Time.now.to_s})
    end.to change { Country.count }

    expect(response).to redirect_to(country_path(assigns[:country]))
  end

  it "does not create duplicate currency" do
    expect do
      post :create, :country => country.attributes
    end.not_to change { Currency.count }

    expect(assigns[:country].errors[:code]).not_to be_empty
  end

  it "shows country" do
    get :show, :id => country.to_param

    expect(response).to have_http_status(:success)
  end

  it "gets edit" do
    get :edit, :id => country.to_param

    expect(response).to have_http_status(:success)
  end

  it "updates country" do
    put :update, :id => country.to_param, :country => country.attributes

    expect(response).to redirect_to(country_path(assigns[:country]))
  end
end
