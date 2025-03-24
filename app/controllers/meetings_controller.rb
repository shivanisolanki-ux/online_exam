class MeetingsController < ApplicationController
  before_action :authenticate_user!

  def index
    meetings = current_user.admin? ? Meeting.all : Meeting.where(user: current_user)
    render json: meetings
  end

  def create
    meeting = Meeting.new(meeting_params)
    if meeting.save
      render json: { message: "Meeting scheduled successfully", meeting: meeting }
    else
      render json: { errors: meeting.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:title, :date, :user_id)
  end
end
