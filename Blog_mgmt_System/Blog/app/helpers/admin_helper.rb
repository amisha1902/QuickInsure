module AdminHelper
    def trending_post_today
        start_time = Time.current.beginning_of_day
        end_time = Time.current.end_of_day
        post = Post.published.where(created_at: start_time..end_time).includes(:likes, :shares, :views)
        post_scores = post.map do |post|
            like_count = post.likes.where(created_at: start_time..end_time).count
            share_count = post.shares.where(created_at: start_time..end_time).count
            view_count = post.views.where(created_at: start_time..end_time).count
            score =(like_count * 0.5) + (share_count * 0.3) + (view_count * 0.2)
            {
                id: post.id,
                title: post.title,
                likes: like_count,
                shares: share_count,
                views: view_count,
                score: score.round(2)
            }
        end
        post_scores
        .sort_by { |p| -p[:score] }
        .first(5)
    end

    def top_5_posts
    posts = Post.where(status: "published").includes(:likes, :views)
    post_scores = posts.map do |post|
      like_count = post.likes.count
      view_count = post.views.count
      score = like_count + view_count
      {
        id: post.id,
        title: post.title,
        likes: like_count,
        views: view_count,
        score: score
      }
    end
    post_scores.sort_by { |p| -p[:score] }.first(5)
  end

  def most_reported_posts(limit = 5)
    posts = Post.includes(:reports)
    post_scores = posts.map do |post|
      report_count = post.reports.count
      {
        id: post.id,
        title: post.title,
        reports: report_count
      }
    end
    post_scores
      .sort_by { |p| -p[:reports] }
      .first(limit)
  end

  def inactive_users_last30days
    mindays = 30.days.ago
    users = User
      .left_joins(:views)
      .select("users.*, MAX(views.created_at) AS last_viewed_at")
      .group("users.id")
      .having("MAX(views.created_at) IS NULL", mindays)
    users.map do |user|
      {
        id: user.id, 
        name: user.name,
        email: user.email,
        last_viewed_at: user.last_viewed_at
      }
    end
  end

  def category_performance
    Category
      .joins(posts: [:likes, :views, :shares])
      .select("
        categories.id,
        categories.category_name,
        COUNT(DISTINCT posts.id) AS posts_count,
        COUNT(DISTINCT likes.id) AS likes_count,
        COUNT(DISTINCT views.id) AS views_count,
        COUNT(DISTINCT shares.id) AS shares_count
      ")
      .group("categories.id")
      .map do |category|
        score = (category.likes_count.to_i * 0.5) + (category.shares_count.to_i * 0.3) + (category.views_count.to_i * 0.2)
        {
          id: category.id,
          category: category.category_name,
          posts: category.posts_count.to_i,
          likes: category.likes_count.to_i,
          shares: category.shares_count.to_i,
          views: category.views_count.to_i,
          score: score.round(2)
        }
      end
      .sort_by { |c| -c[:score] }
  end
end 