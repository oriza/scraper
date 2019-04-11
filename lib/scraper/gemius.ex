defmodule Scraper.Gemius do
  @moduledoc """
    Gemius OLA scraper.

    ## Example:
    iex> Scraper.Gemius.scrape("https://rating.gemius.com/hu/reports/segmentation/data/table?&&selectedMetrics%5B0%5D%5Bformat%5D%5B%5D=integer&selectedPeriod%5BstartDate%5D=", ["index.hu", "origo.hu"])
  """

  def scrape(http_client, json_parser, url, sites) do
    url
    |> http_client.get()
    |> extract(json_parser, sites)
  end

  defp extract({:ok, json}, json_parser, sites) do
    case json_parser.decode(json) do
      {:ok, items} ->
        items
        |> Map.get("data")
        |> Enum.filter(fn site -> Enum.member?(sites, site["fullPathName"]) end)
        |> Enum.map(fn site -> %{name: site["fullPathName"], visitors: site["7"]["value"]} end)

      error ->
        error
    end
  end

  defp extract(error, _, _), do: error
end
