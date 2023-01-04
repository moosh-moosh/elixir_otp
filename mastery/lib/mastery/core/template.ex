defmodule Mastery.Core.Template do
  # sigil ~w creates a list of words, the a modifier at the end will create
  # a list of atoms instead of strings.
  defstruct ~w[name category instructions raw compiled generators checker]a

  # FIXME: This is not working currently
  # ** (FunctionClauseError) no function clause matching in Kernel.struct!/2
  def new(fields) do
    raw = Keyword.fetch!(fields, :raw)
    struct!{
      __MODULE__,
      # EEx is a module used to compile idiomatic Elixir templates, called EEx templates.
      Keyword.put(fields, :compiled, EEx.compile_string(raw))
    }
  end
end
