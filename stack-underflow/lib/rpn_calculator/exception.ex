defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception([]), do: %StackUnderflowError{}

    @impl true
    def exception(message) do
      %StackUnderflowError{message: "stack underflow occurred, context: " <> message}
    end
  end

  def divide([]) do
    raise StackUnderflowError, "when dividing"
  end

  def divide([_]) do
    raise StackUnderflowError, "when dividing"
  end

  def divide([0, _]) do
    raise DivisionByZeroError
  end

  def divide([a, b]) do
    b / a
  end
end
