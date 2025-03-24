class SubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    subjects = Subject.all
    render json: subjects
  end

  def create
    subject = Subject.new(subject_params)
    if subject.save
      render json: { message: "Subject created successfully", subject: subject }
    else
      render json: { errors: subject.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:name)
  end

  def authorize_admin!
    render json: { error: "Access denied" }, status: :forbidden unless current_user.admin?
  end
end
