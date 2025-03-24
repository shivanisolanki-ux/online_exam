class NoticesController < ApplicationController
  before_action :authenticate_user!

  def index
    notices = Notice.all
    render json: notices
  end

  def create
    notice = Notice.new(notice_params)
    if notice.save
      render json: { message: "Notice added successfully", notice: notice }
    else
      render json: { errors: notice.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def notice_params
    params.require(:notice).permit(:title, :content)
  end
end
