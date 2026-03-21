class ApplicationController < ActionController::Base
  
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  def admin_user?
    admin_id = request.headers['adminId']
    if admin_id.present?
      user = User.find_by(id: admin_id)
      return user&.role&.name == 'admin'
    end
    false
  end

  def is_admin!
    render json: { error: "Unauthorized. Admin access required." }, status: :unauthorized unless admin_user?
  end

  helper_method :admin_user?
end
