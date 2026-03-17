json.extract! notification, :id, :user_id, :post_id, :message, :notification_type, :is_read, :created_at, :updated_at
json.url notification_url(notification, format: :json)
