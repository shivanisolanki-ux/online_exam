ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :role

  controller do
    before_action :restrict_student_access, only: [:destroy, :new, :create]

    def restrict_student_access
      if current_admin_user.student?
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to admin_dashboard_path
      end
    end
  end

# Customizing the index page
  index do
    selectable_column unless current_admin_user.student?
    id_column
    column :email
    column :role do |admin_user|
      admin_user.role.present? ? admin_user.role.capitalize : "N/A"
    end
    column :created_at
    actions unless current_admin_user.student?
  end

  form do |f|
    if current_admin_user.admin?
      f.inputs "Admin User Details" do
        f.input :email
        f.input :password
        f.input :password_confirmation
        f.input :role, as: :select, collection: AdminUser.roles.keys
      end
      f.actions
    else
      "You are not authorized to edit this page."
    end
  end

  show do
    attributes_table do
      row :email
      row :role do |admin_user|
        admin_user.role.present? ? admin_user.role.capitalize : "N/A"
      end
      row :created_at
      row :updated_at
    end
  end

  filter :email
  filter :role, as: :select, collection: AdminUser.roles.keys, unless: proc { current_admin_user.student? }
  filter :created_at
end