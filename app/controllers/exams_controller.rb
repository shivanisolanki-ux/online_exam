class ExamsController < ApplicationController
  before_action :authenticate_user!

  def index
    exams = current_user.exams.includes(:subject)
    render json: exams.as_json(include: :subject)
  end

  def create
    subject = Subject.find(params[:subject_id])
    questions = subject.questions.order("RANDOM()").limit(5)
    score = calculate_score(questions, params[:answers])

    exam = current_user.exams.create(subject: subject, score: score)
    render json: { message: "Exam submitted successfully", score: score, exam: exam }
  end

  def rank
    students = User.joins(:exams)
                   .group("users.id")
                   .order("AVG(exams.score) DESC")
                   .select("users.id, users.email, AVG(exams.score) as avg_score")
    render json: students
  end

  private

  def calculate_score(questions, answers)
    score = 0
    questions.each do |q|
      score += 1 if q.answer == answers[q.id.to_s]
    end
    score
  end
end
