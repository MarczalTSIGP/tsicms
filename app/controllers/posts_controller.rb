class PostsController < ApplicationController
  add_breadcrumb I18n.t('breadcrumbs.posts.name'), :posts_path

  def index
    @posts = Post.order(created_at: :desc)
                 .where(posted: true)
                 .page params[:page]
    @categories = PostCategory.order(name: :asc)
    @posts_category = Post.order(created_at: :desc)
                          .where(posted: true, post_category_id: params[:id])
  end

  def show
    @post = Post.find(params[:id])
    add_breadcrumb I18n.t('breadcrumbs.posts.show', name: "##{@post.id}"),
                   :post_path
  end

  def posts_by_category
    @posts_category = PostCategory.find(params[:id])
  end
end
