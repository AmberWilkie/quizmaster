class Quizmaster::QuizzesController < ApplicationController
  before_action :get_quiz, except: [:correct_answers,
                                    :broadcast_content,
                                    :mark_answers,
                                    :get_winner_message]

  def show
    @questions = @quiz.questions.sort
  end

  def start_quiz
    content = {message: params[:message], welcome: params[:welcome], quiz_id: params[:id]}
    BroadcastMessageJob.perform_now(content)
    @quiz.update_attribute(:is_started, true)
  end

  def send_question
    question = Question.find(params[:question_id])
    content = {question: question.body, index: params[:index], quiz_id: params[:id], question_id: params[:question_id], team_id: cookies['team_id']}
    broadcast_content(content)
    BroadcastMobileJob.perform_now({data: 'a string'})
    question.update_attribute(:is_sent, true)
  end

  def send_results
    content = {message: get_winner_message, welcome: 'true', quiz_id: @quiz.id}
    BroadcastMessageJob.perform_now(content)
    head :ok
  end

  def reset_quiz
    @quiz.reset_quiz_actions
    @questions = @quiz.questions.sort
    render :show
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
  end

  private

  def get_quiz
    @quiz = Quiz.find(params[:id])
  end

  def get_winner_message
    winner = Team.find_by(name: @quiz.get_scores.last[:team].name)
    winner.update_attribute(:is_winner, true)
    message = "#{winner.name} won!"
  end

end
