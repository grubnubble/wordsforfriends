class PagesController < ApplicationController

  # GET /page
  def show
    render params[:page]
  end

  # POST /contact
  def contact
    ContactMailer.contact_email( params).deliver
    flash[:notice] = "Your message done did get sent."  
  end
end
