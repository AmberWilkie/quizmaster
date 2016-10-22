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

  def send_results
    quiz = Quiz.find(params[:id])
    scores = []
    quiz.teams.each do |team|
      points = team.answers.where(is_correct: true).count
      scores << {team: team, score: points}
    end
    scores.sort_by! {|_key, value| value}
    message = "#{scores.last[:team].name} won!"
    content = {message: message, welcome: 'true', quiz_id: quiz.id}
    BroadcastMessageJob.perform_now(content)
    head :ok
  end

  def correct_answers
    @question = Question.find(params[:id])
    render :answers
  end

  def broadcast_content(content)
    # This method will broadcast content to Team
    BroadcastQuizJob.perform_now(content)
  end

  def mark_answers
    answer = Answer.find(params[:id])
    if params[:correct] == 'true'
      answer.update_attribute(:is_correct, true)
    elsif params[:correct] == 'false'
      answer.update_attribute(:is_correct, false)
    end
    head :ok
  end

  def results
    @quiz = Quiz.find(params[:id])
  end

  private

  def get_quiz
    @quiz = Quiz.find(params[:id])
  end
end
