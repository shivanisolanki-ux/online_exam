ActiveAdmin.register Exam do
  permit_params :exam_title, :subject_id, :total_score, question_ids: []
  # permit_params :exam_title, :subject_id, :total_score, question_ids: []

  controller do
    before_action :restrict_student_access, only: [:new, :create, :edit, :update, :destroy]

    def scoped_collection
      if current_admin_user.student?
        Exam.all
      else
        super
      end
    end

    private

    def restrict_student_access
      if current_admin_user.student?
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to admin_exams_path
      end
    end
  end

  controller do
    def attempt
      exam = Exam.find(params[:id])
      student = current_admin_user
      answers = params[:answers]

      total_questions = exam.questions.count
      correct_answers = 0

      exam.questions.each do |question|
        correct_answers += 1 if answers[question.id.to_s] == question.correct_answer
      end

      # Calculate score based on correct answers
      score_per_question = exam.total_score.to_f / total_questions
      score = correct_answers * score_per_question

      # Store the result
      Result.create!(
        admin_user: student,
        exam: exam,
        score: score,
        total_questions: total_questions,
        correct_answers: correct_answers
      )

      flash[:notice] = "Exam submitted successfully! Your Score: #{score.round(2)} out of #{exam.total_score}"
      redirect_to admin_exams_path
    end
  end

  # index do
  #   selectable_column unless current_admin_user.student? # Hide selection checkbox for students
  #   id_column
  #   column :exam_title
  #   # column :subject
  #   column :questions do |exam|
  #     exam.questions.pluck(:id, :question_text)
  #   end
  #   column :total_score
  #   column :total_questions do |exam|
  #     exam.questions.count # Display the number of questions
  #   end

  #   actions unless current_admin_user.student? # Hide action buttons for students
  # end
  index do
    selectable_column
    id_column
    column :exam_title

    # Show questions with index
    column :questions do |exam|
      if exam.questions.any?
        content_tag(:ol) do
          exam.questions.each_with_index.map do |question, index|
            content_tag(:li, "#{index + 1}. #{question.question_text}")
          end.join.html_safe
        end
      else
        "No questions available"
      end
    end

    actions
  end


 form do |f|
  f.inputs 'Exam Details' do
    f.input :exam_title
    f.input :questions,
            as: :check_boxes,
            collection: Question.all.collect { |q| ["Q#{q.id}. #{q.question_text}", q.id] }
  end
  f.actions
end



  show do
    attributes_table do
      row :exam_title
      row "Questions" do |exam|
        ol do
          exam.questions.each_with_index do |question, index|
            li "Q.#{index + 1} #{question.question_text}"
          end
        end
      end
    end

    panel "Exam Question Paper" do
      if current_admin_user.student?
        render partial: 'attempt_exam', locals: { exam: exam }
      else
        table_for exam.questions do
          column :id
          column :question_text
          column :correct_answer
          column :created_at
          column :updated_at
        end
      end
    end
  end
  # show do
  #   attributes_table do
  #     row :exam_title
  #     # row "Questions" do |exam|
  #     #   exam.questions.map(&:question_text).join(", ") # सभी प्रश्नों को कॉमा से अलग करके दिखाए
  #     # end
  #     # # row :total_score
  #     row :total_questions do |exam|
  #       exam.questions.count
  #     end
  #   end

  #   panel "Question Paper" do
  #     exam.questions.each_with_index do |question, index|
  #       div "#{index + 1}. #{question.question_text}"
  #     end
  #   end

  #   panel "Exam Question Paper" do
  #     table_for exam.questions do
  #       column :id
  #       column :question_text
  #       column :correct_answer
  #       column :created_at
  #       column :updated_at
  #     end
  #   end
  # end


end