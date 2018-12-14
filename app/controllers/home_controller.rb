class HomeController < ApplicationController
  def index
    @contact = Contact.new
    @last_posts = Post.order(created_at: :desc).where(posted: true).last(4)
    @last_recommendations = Recommendation.order(created_at: :desc).last(4)
  end
end
