class PagesController < ApplicationController

  # GET /page
  def show
    render params[:page]
  end
end
