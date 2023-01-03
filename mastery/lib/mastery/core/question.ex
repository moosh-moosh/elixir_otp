defmodule Mastery.Core.Question do
  alias Mastery.Core.Template

  defstruct ~w[asked substitutions template]a

  def new(%Template{} = template) do
    template.generators
    |> Enum.map(&build_substitution/1)
    |> evaluate(template)
  end

  def build_substitution({name, choices_or_generator}) do
    {name, choose(choices_or_generator)}
  end

  # if choose called with a list of choices, pick one at random
  defp choose(choices) when is_list(choices) do
    Enum.random(choices)
  end

  # if choose called with a function that generates a substitution, call it
  defp choose(generator) when is_function(generator) do
    generator.()
  end

  defp compile(template, substitutions) do
    template.compiled
    |> Code.eval_quoted(assigns: substitutions)
    |> elem(0)
  end

  defp evaluate(substitutions, template) do
    %__MODULE__{
      asked: compile(template, substitutions),
      substitutions: substitutions,
      template: template
    }
  end
end
