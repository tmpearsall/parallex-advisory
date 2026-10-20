class Lead < ApplicationRecord
  STAGES = %w[inquiry intro_call proposal signed active handoff declined].freeze
  INVESTOR_TYPES = ["Single-family office (professionally led)", "Multi-family office", "Family-run office (invests near the family business)", "Advisor or deal lead to a family office", "Other"].freeze

  attr_accessor :website # honeypot

  validates :name, :email, :message, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :stage, inclusion: { in: STAGES }
  validates :name, :organization, :role_title, length: { maximum: 200 }
  validates :message, :family_goal, length: { maximum: 5000 }
end
