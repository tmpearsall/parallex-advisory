module Admin
  class LeadsController < ApplicationController
    http_basic_authenticate_with(
      name: ENV.fetch("ADMIN_USER", "admin"),
      password: ENV.fetch("ADMIN_PASSWORD") { Rails.env.production? ? SecureRandom.hex(32) : "dev" }
    )
    layout "application"

    def index
      @leads = Lead.order(created_at: :desc)
      @leads = @leads.where(stage: params[:stage]) if Lead::STAGES.include?(params[:stage])
    end

    def show
      @lead = Lead.find(params[:id])
    end

    def update
      @lead = Lead.find(params[:id])
      attrs = params.require(:lead).permit(:stage, :notes)
      attrs[:contacted_at] = Time.current if attrs[:stage].present? && attrs[:stage] != "inquiry" && @lead.contacted_at.nil?
      @lead.update(attrs)
      redirect_to admin_lead_path(@lead)
    end
  end
end
