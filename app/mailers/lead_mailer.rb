class LeadMailer < ApplicationMailer
  def new_lead(lead)
    @lead = lead
    mail to: ENV.fetch("LEAD_ALERT_TO", "troy@parallexllc.com"), reply_to: lead.email,
         subject: "New introduction: #{lead.name}#{" (#{lead.organization})" if lead.organization.present?}"
  end
end
