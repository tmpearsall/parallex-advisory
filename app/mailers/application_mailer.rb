class ApplicationMailer < ActionMailer::Base
  default from: -> { ENV.fetch("MAIL_FROM", "Parallex <hello@parallexllc.com>") }
  layout false
end
