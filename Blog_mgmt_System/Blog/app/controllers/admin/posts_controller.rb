class Admin::PostsController < ApplicationController
before_action :is_admin!, only: [:trending_today, :top_posts, :most_reported, :inactive_users]
  include AdminHelper
  def trending_today
    posts = trending_post_today
    render json: {
      success: true,
      message: "today's top 5 trending posts",
      data: posts
    }
  end
  def top_posts
    posts = top_5_posts
    render json: {
      success: true,
      message: "top 5 posts based on likes & views",
      data: posts
    }
  end
  def most_reported
    posts = most_reported_posts
    render json: {
        success: true,
        message: "most reported posts",
        data: posts
    }
  end

  def inactive_users
    users = inactive_users_last30days
    render json: {
        success: true,
        message: "these users are inative for last 30 days",
        data: users
    }
  end
  def category_performance
    category = category_performance
    render json: {
        message: "category wise performace"
        data: category
    }
end
end