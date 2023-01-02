defmodule Mastery.Core.Template do
  # sigil ~w creates a list of words, the a modifier at the end will create
  # a list of atoms instead of strings.
  defstruct ~w[name category instructions raw compiled generators checker]a
end
