ActiveAdmin.register Subject do
  permit_params :name

  controller do
    before_action :restrict_student_access, only: [:new, :create, :edit, :update, :destroy]

    def scoped_collection
      if current_admin_user.student?
        Subject.all
      else
        super
      end
    end

    private

    def restrict_student_access
      if current_admin_user.student?
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to admin_subjects_path
      end
    end
  end

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  form do |f|
    if current_admin_user.admin?
      f.inputs 'subject Details' do
        f.input :name
      end
      f.actions
    else
      "You are not authorized to create or edit exams."
    end
  end
end
