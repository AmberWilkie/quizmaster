class Quizmaster::QuizzesController < ApplicationController
  before_action :get_quiz, only: [:show, :start_quiz, :send_question]

  def show
    @questions = @quiz.questions
  end

  def start_quiz
    @questions = @quiz.questions
    content = {message: params[:message], welcome: params[:welcome], quiz_id: params[:id]}
    BroadcastMessageJob.perform_now(content)
    render :show
  end

  def send_question
    question = Question.find(params[:question_id])
    content = {question: question.body, index: params[:index], quiz_id: params[:id], question_id: params[:question_id], team_id: cookies['team_id']}
    broadcast_content(content)
  end

  def broadcast_content(content)
    # This method will broadcast content to Team
    BroadcastQuizJob.perform_now(content)
  end

  private

  def get_quiz
    @quiz = Quiz.find(params[:id])
  end
end
