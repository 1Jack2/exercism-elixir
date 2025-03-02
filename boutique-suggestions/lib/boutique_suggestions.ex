defmodule BoutiqueSuggestions do
  # Clothing items are stored as a map:
  # %{
  #   item_name: "Descriptive Name",
  #   price: 99.00,
  #   color: "Ochre Red",
  #   base_color: "red"
  # }

  def get_combinations(tops, bottoms, maximum_price: maximum_price) do
    for top <- tops,
        bottom <- bottoms,
        top.base_color != bottom.base_color &&
          top.price + bottom.price <= maximum_price do
      {top, bottom}
    end
    |> IO.inspect()
  end

  def get_combinations(tops, bottoms, _ \\ []) do
    get_combinations(tops, bottoms, maximum_price: 100)
  end
end
