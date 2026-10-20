# Backed by the posts table already in Parallex's Supabase project (app_id, kind, status, published_at).
# A post shows only with status "published" AND a published_at in the past; anything else is a draft.
class Post < ApplicationRecord
  default_scope { where(app_id: "parallex", kind: "blog") }

  validates :title, :slug, :body, presence: true
  validates :slug, format: { with: /\A[a-z0-9-]+\z/ }

  scope :published, -> { where(status: "published").where.not(published_at: nil).where(published_at: ..Time.current).order(published_at: :desc) }

  def to_param = slug
end
