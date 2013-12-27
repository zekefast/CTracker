class UsersController < ApplicationController
  def update
    current_user.countries_currencies = if params[:user] && params[:user][:countries_currencies]
      CountriesCurrency.find(user_params[:countries_currencies])
    else
      []
    end

    if current_user.save
      redirect_to collections_path, notice: "Your ownership was updated successfully."
    else
      redirect_to collections_path, alert: "An error occurs during collections update."
    end
  end

  private
    def user_params
      params.require(:user).permit(countries_currencies: [])
    end
end
