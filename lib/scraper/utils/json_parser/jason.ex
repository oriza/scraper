defmodule Scraper.Utils.Jason do
  @moduledoc """
    Abstraction over Jason
  """

  @behaviour Scraper.Utils.JSONParser

  @impl Scraper.Utils.JSONParser
  def decode(json), do: Jason.decode(json)
end
