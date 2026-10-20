class PostsController < ApplicationController
  def index
    @all = Post.published
    @tags = @all.flat_map { |p| p.tags.to_a }.tally.sort_by { |t, n| [-n, t] }.map(&:first)
    @tag = params[:tag].presence
    @posts = @tag ? @all.select { |p| p.tags.to_a.include?(@tag) } : @all.to_a
  end

  def show
    @post = Post.published.find_by!(slug: params[:id])
  end
end
