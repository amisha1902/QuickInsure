require 'faker'
Faker::UniqueGenerator.clear

puts "Seeding started..."

['admin', 'author', 'reader'].each do |role_name|
  Role.find_or_create_by!(name: role_name)
end

admin_role = Role.find_by!(name: 'admin')
author_role = Role.find_by!(name: 'author')
reader_role = Role.find_by!(name: 'reader')
puts " Roles created"

admin = User.find_or_create_by!(email: "admin@example.com") do |u|
  u.name = "Admin User"
  u.password = "password123"
  u.status = "active"
  u.role_id = admin_role.id
end

authors = 10.times.map do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "password123",
    status: "active",
    role_id: author_role.id
  )
end

readers = 20.times.map do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "password123",
    status: "active",
    role_id: reader_role.id
  )
end
puts "Users created (#{1 + authors.count + readers.count} total)"

category_names = ["Technology", "Health", "Finance", "Lifestyle", "Education", "Entertainment", "Sports", "Business"]
categories = category_names.map do |name|
  Category.find_or_create_by!(category_name: name) do |c|
    c.description = Faker::Lorem.sentence(word_count: 10)
  end
end
puts "Categories created (#{categories.count} total)"

posts = []

authors.each do |author|
  rand(3..5).times do
    selected_categories = categories.sample(rand(1..3))
    
    post = Post.new(
      title: Faker::Book.title,
      content: Faker::Lorem.paragraphs(number: 3).join("\n\n"),
      status: "published",
      user_id: author.id,
      created_at: Faker::Time.between(from: 30.days.ago, to: Time.current)
    )
    
    post.categories = selected_categories
    post.save!
    
    posts << post
  end
end

today_start = Date.today.beginning_of_day
today_posts = authors.sample(3).each do |author|
  rand(2..3).times do
    selected_categories = categories.sample(rand(1..3))
    
    post = Post.new(
      title: "Breaking: #{Faker::Book.title}",
      content: Faker::Lorem.paragraphs(number: 3).join("\n\n"),
      status: "published",
      user_id: author.id,
      created_at: Faker::Time.between(from: today_start, to: Time.current)
    )
    
    post.categories = selected_categories
    post.save!
    
    posts << post
  end
end

puts "Posts created (#{posts.count} total - including #{posts.select { |p| p.created_at.to_date == Date.today }.count} from today)"

posts.each do |post|
  rand(2..5).times do
    Comment.create!(
      user_id: readers.sample.id,
      post_id: post.id,
      content: Faker::Lorem.paragraph(sentence_count: 2)
    )
  end
end
puts "Comments created"

posts.each do |post|
  readers.sample(rand(5..15)).each do |reader|
    Like.create!(
      user_id: reader.id,
      post_id: post.id
    ) if rand < 0.6
  end
end
puts "Likes created"

posts.each do |post|
  readers.sample(rand(0..8)).each do |reader|
    Share.create!(
      user_id: reader.id,
      post_id: post.id
    ) if rand < 0.4
  end
end
puts "Shares created"

posts.each do |post|
  readers.sample(rand(10..30)).each do |reader|
    View.create!(
      user_id: reader.id,
      post_id: post.id,
      created_at: Faker::Time.between(from: post.created_at, to: Time.current)
    )
  end
end
puts "Views created"

todays_posts = posts.select { |p| p.created_at.to_date == Date.today }
todays_posts.each do |post|
  readers.sample(rand(20..35)).each do |reader|
    Like.create!(
      user_id: reader.id,
      post_id: post.id
    ) if rand < 0.8
  end
  
  rand(5..10).times do
    Comment.create!(
      user_id: readers.sample.id,
      post_id: post.id,
      content: Faker::Lorem.paragraph(sentence_count: 2)
    )
  end
  
  readers.sample(rand(10..18)).each do |reader|
    Share.create!(
      user_id: reader.id,
      post_id: post.id
    ) if rand < 0.6
  end
  
  readers.sample(rand(30..50)).each do |reader|
    View.create!(
      user_id: reader.id,
      post_id: post.id,
      created_at: Time.current
    )
  end
end

posts.sample(rand(2..5)).each do |post|
  rand(1..3).times do
    Report.create!(
      user_id: readers.sample.id,
      post_id: post.id,
      reason: ["spam", "offensive", "inappropriate", "misinformation"].sample,
      description: Faker::Lorem.sentence(word_count: 10),
      status: ["pending", "reviewed", "resolved"].sample
    )
  end
end
puts "Reports created"

posts.sample(rand(5..15)).each do |post|
  Notification.create!(
    user_id: post.user_id,
    post_id: post.id,
    message: ["Your post got #{rand(5..50)} likes!", "#{Faker::Name.first_name} commented on your post", "Your post is trending!"].sample,
    notification_type: ["like", "comment", "share"].sample,
    is_read: [true, false].sample
  )
end
puts "Notifications created"

puts "Seeding completed successfully!"
puts "=" * 50
puts "Summary:"
puts "  - Roles: #{Role.count}"
puts "  - Users: #{User.count}"
puts "  - Categories: #{Category.count}"
puts "  - Posts: #{Post.count}"
puts "  - Comments: #{Comment.count}"
puts "  - Likes: #{Like.count}"
puts "  - Shares: #{Share.count}"
puts "  - Views: #{View.count}"
puts "  - Reports: #{Report.count}"
puts "  - Notifications: #{Notification.count}"
puts "=" * 50
