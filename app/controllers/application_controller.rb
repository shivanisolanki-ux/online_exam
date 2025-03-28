class ApplicationController < ActionController::Base
  before_action :check_admin_access

  def check_admin_access
    return if current_admin_user.nil?

# Prevent students from accessing certain paths inside ActiveAdmin
    if current_admin_user.student? && restricted_admin_paths.include?(request.path)
      flash[:alert] = "Access restricted for students."
      redirect_to admin_root_path
    end
  end

  private

  def restricted_admin_paths
    ["/admin/admin_users", "/admin/new", "/admin/create", "/admin/destroy"]
  end
end
