defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible do
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(_, character) do
      character = %{character | health: character.health + 5}
      {nil, character}
    end
  end

  defimpl Edible, for: ManaPotion do
    alias RPG.EmptyBottle

    def eat(item, character) do
      character = %{character | mana: character.mana + item.strength}
      {%EmptyBottle{}, character}
    end
  end

  defimpl Edible, for: Poison do
    def eat(_, character) do
      character = %{character | health: 0}
      {%EmptyBottle{}, character}
    end
  end
end
