class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, only: [:create]

  def index
    questions = Question.where(subject_id: params[:subject_id])
    render json: questions
  end

  def create
    question = Question.new(question_params)
    if question.save
      render json: { message: "Question added successfully", question: question }
    else
      render json: { errors: question.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def question_params
    params.require(:question).permit(:subject_id, :question_text, :option1, :option2, :option3, :option4, :answer)
  end

  def authorize_admin!
    render json: { error: "Access denied" }, status: :forbidden unless current_user.admin?
  end
end
