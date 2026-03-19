# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Seeding data..."

['admin', 'author', 'reader'].each do |role_name|
  Role.find_or_create_by!(name: role_name)
end

admin_role  = Role.find_by!(name: 'admin')
author_role = Role.find_by!(name: 'author')
reader_role = Role.find_by!(name: 'reader')

admin = User.find_or_create_by!(email: "admin@example.com") do |u|
  u.name = "Admin User"
  u.password = "password"
  u.status = "active"
  u.role_id = admin_role.id
end

authors = []
4.times do |i|
  authors << User.find_or_create_by!(email: "author#{i+1}@example.com") do |u|
    u.name = "Author #{i+1}"
    u.password = "password"
    u.status = "active"
    u.role_id = author_role.id
  end
end

readers = []
5.times do |i|
  readers << User.find_or_create_by!(email: "reader#{i+1}@example.com") do |u|
    u.name = "Reader #{i+1}"
    u.password = "password"
    u.status = "active"
    u.role_id = reader_role.id
  end
end

tech = Category.find_or_create_by!(category_name: "Technology") do |c|
  c.description = "Tech stuff"
end

life = Category.find_or_create_by!(category_name: "Lifestyle") do |c|
  c.description = "Daily life content"
end

categories = [tech, life]

posts = []

authors.each_with_index do |author, i|
  2.times do |j|
    post = Post.find_or_create_by!(title: "Post #{i+1}-#{j+1}") do |p|
      p.content = "Content for post #{i+1}-#{j+1}"
      p.status = ["published", "drafted"].sample
      p.user_id = author.id
    end

    posts << post

    PostCategory.find_or_create_by!(
      post_id: post.id,
      category_id: categories.sample.id
    )
  end
end

readers.each do |reader|
  post = posts.sample

  Comment.find_or_create_by!(
    user_id: reader.id,
    post_id: post.id
  ) do |c|
    c.content = "Nice post by #{reader.name}"
  end

  Like.find_or_create_by!(
    user_id: reader.id,
    post_id: post.id
  ) do |l|
    l.like_type = "like"
  end

  Share.find_or_create_by!(
    user_id: reader.id,
    post_id: post.id
  )

  View.find_or_create_by!(
    user_id: reader.id,
    post_id: post.id
  )
end

Report.find_or_create_by!(
  user_id: readers.first.id,
  post_id: posts.first.id
) do |r|
  r.reason = "Spam"
  r.description = "Looks suspicious"
  r.status = "pending"
end

Notification.find_or_create_by!(
  user_id: authors.first.id,
  post_id: posts.first.id
) do |n|
  n.message = "Your post got engagement!"
  n.notification_type = "activity"
  n.is_read = false
end

puts "Seeding completed successfully!"