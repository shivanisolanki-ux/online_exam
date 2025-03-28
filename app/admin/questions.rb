  ActiveAdmin.register Question do
    permit_params :subject_id, :question_text, :exam_id, :option_a, :option_b, :option_c, :option_d, :correct_answer

    controller do
      before_action :restrict_student_access, only: [:new, :create, :edit, :update, :destroy]

      def scoped_collection
        if current_admin_user.student?
          Question.none
        else
          super
        end
      end

      private

      def restrict_student_access
        if current_admin_user.student?
          flash[:alert] = "You are not authorized to perform this action."
          redirect_to admin_questions_path
        end
      end
    end

    index do
      selectable_column
      column :id
      column :subject
      column :question_text
      column :correct_answer
      column :exam
      actions
    end

    form do |f|
      if current_admin_user.admin?
        f.inputs "Question Details" do
          f.input :subject
          f.input :exam
          f.input :question_text
          f.input :option_a
          f.input :option_b
          f.input :option_c
          f.input :option_d
          f.input :correct_answer
        end
        f.actions
      else
        "You are not authorized to create or edit exams."
      end
    end
  end
