class CollectionsController < ApplicationController
  # GET /collections
  # GET /collections.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: ::CollectionDatatable.new(view_context, current_user) }
    end
  end
end
