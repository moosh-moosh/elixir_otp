defmodule Mastery.Core.Response do
  @moduledoc """
  quiz_title:
    Title field from the quiz.
  template_name:
    Name field identifying the template.
  to
    The question being answered, as in "this is a response /to/ the asked question".
  email
    The email address of the user answering the question.
  answer
    The answer provided by the user.
  correct
    Whether the given answer was correct.
  timestamp
    The time the answer was provided
  """
  defstruct ~w[quiz_title template_name to email answer correct timestamp]a

  def new(quiz, email, answer) do
    question = quiz.current_question
    template = question.template

    %__MODULE__{
      quiz_title: quiz.title,
      template_name: template.name,
      to: question.asked,
      email: email,
      answer: answer,
      correct: template.checker.(question.substitutions, answer),
      timestamp: DateTime.utc_now()
    }
  end
end
