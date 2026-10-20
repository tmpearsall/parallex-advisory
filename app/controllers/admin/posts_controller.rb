module Admin
  # Draft preview: shows a post (draft or published) exactly as visitors will see it, behind the admin login.
  class PostsController < ApplicationController
    http_basic_authenticate_with(
      name: ENV.fetch("ADMIN_USER", "admin"),
      password: ENV.fetch("ADMIN_PASSWORD") { Rails.env.production? ? SecureRandom.hex(32) : "dev" }
    )
    layout "application"

    def show
      @post = Post.find(params[:id])
      @post.published_at ||= Time.current # preview only, never saved
      render "posts/show"
    end
  end
end
