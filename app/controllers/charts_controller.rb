class ChartsController < ApplicationController
  # GET /charts.json
  def index
    dataset = Collection.count_by_date

    respond_to do |format|
      format.json do
        render json: {
          labels: dataset.keys,
          data:   dataset.values
        }
      end
    end
  end
end
