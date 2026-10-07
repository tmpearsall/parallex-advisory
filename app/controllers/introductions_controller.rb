class IntroductionsController < ApplicationController
  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(params.require(:lead).permit(:name, :email, :organization, :role_title, :investor_type, :message, :website))
    return redirect_to(thanks_introduction_path) if @lead.website.present? # bots fill the hidden field
    @lead.source = "site"
    if @lead.save
      redirect_to thanks_introduction_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def thanks; end
end
