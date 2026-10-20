class IntroductionsController < ApplicationController
  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(params.require(:lead).permit(:name, :email, :organization, :role_title, :investor_type, :family_goal, :message, :website))
    return redirect_to(thanks_introduction_path) if @lead.website.present? # bots fill the hidden field
    @lead.source = "site"
    if @lead.save
      begin
        LeadMailer.new_lead(@lead).deliver_now
      rescue => e # the lead is already saved; never lose it to a mail failure
        Rails.logger.error("lead alert failed for lead #{@lead.id}: #{e.class}: #{e.message} (smtp host set: #{ENV["SMTP_ADDRESS"].present?}, user set: #{ENV["SMTP_USERNAME"].present?}, password length: #{ENV["SMTP_PASSWORD"].to_s.size})")
      end
      redirect_to thanks_introduction_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def thanks; end
end
