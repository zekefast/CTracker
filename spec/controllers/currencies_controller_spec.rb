require "rails_helper"


RSpec.describe CurrenciesController, :type => :controller do
  fixtures :currencies

  let(:currency) { currencies(:one) }


  it_behaves_like "controller does not respond to actions",
    :new     => :get,
    :destroy => :get,
    :create  => :post,
    :edit    => :get,
    :update  => :put

  it "gets index" do
    get :index

    expect(response).to have_http_status(:success)
    expect(assigns[:currencies]).not_to be_nil
  end

  it "shows currency" do
    get :show, :id => currency.to_param

    expect(response).to have_http_status(:success)
  end
end
