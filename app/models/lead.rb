class Lead < ApplicationRecord
  STAGES = %w[inquiry intro_call proposal signed active handoff declined].freeze
  INVESTOR_TYPES = ["Family office", "Private equity", "Venture capital", "Search fund", "Other"].freeze

  attr_accessor :website # honeypot

  validates :name, :email, :message, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :stage, inclusion: { in: STAGES }
  validates :name, :organization, :role_title, length: { maximum: 200 }
  validates :message, length: { maximum: 5000 }
end
