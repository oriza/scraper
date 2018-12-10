defmodule Scraper.Gemius do
  @moduledoc """
    Gemius OLA scraper.

    ## Example:
    iex> Scraper.Gemius.scrape("https://rating.gemius.com/hu/reports/segmentation/data/table?&&selectedMetrics%5B0%5D%5Bformat%5D%5B%5D=integer&selectedPeriod%5BstartDate%5D=", ["index.hu", "origo.hu"])
  """

  def scrape(url, sites) do
    url
    |> Scraper.Http.get()
    |> extract(sites)
  end

  defp extract({:ok, 200, json}, sites) do
    case Jason.decode(json) do
      {:ok, items} ->
        items
        |> Map.get("data")
        |> Enum.filter(fn site -> Enum.member?(sites, site["fullPathName"]) end)
        |> Enum.map(fn site -> %{name: site["fullPathName"], visitors: site["7"]["value"]} end)

      error ->
        error
    end
  end

  defp extract({:ok, _, body}, _), do: {:error, body}

  defp extract(error, _), do: error
end
