require "rails_helper"


RSpec.describe CountriesController, :type => :controller do
  context "when user authenticated" do
    include_context "authenticated user"

    let(:country) { FactoryGirl.create(:country) }


    it_behaves_like "controller does not respond to actions",
      :new     => :get,
      :create  => :post,
      :destroy => :get

    it "gets index" do
      get :index

      expect(response).to have_http_status(:success)
      expect(assigns[:countries]).not_to be_nil
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
      put :update, :id => country.to_param, country_form_object: {visited: false}

      expect(response).to redirect_to(country_path(assigns[:form].country))
    end
  end # whe user authenticated
end
