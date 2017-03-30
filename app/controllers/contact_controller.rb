class ContactController < ApplicationController
  def index
  end
  def create
    @name = params[:name]
    # render plain:"Thank you for #{@name} for contacting us!"
    # redirect_to contact_path({ name: params[:name]})
    render :index
  end

end
