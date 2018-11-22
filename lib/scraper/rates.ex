defmodule Scraper.Rates do
  @moduledoc """
    napiarfolyam.hu scraper.

    ## Example
    iex> Scraper.Rates.scrape(http_client, html_parser, "api.napiarfolyam.hu/?bank=mnb")
  """

  def scrape(http_client, html_parser, url) do
    url
    |> http_client.get()
    |> extract(html_parser)
  end

  defp extract({:ok, body}, html_parser) do
    document = html_parser.parse(body)

    for rate <- html_parser.select_all(document, "arfolyamok deviza item") do
      currency = html_parser.select_one(rate, "penznem")
      buy = html_parser.select_one(rate, "vetel")
      sell = html_parser.select_one(rate, "eladas")
      average = html_parser.select_one(rate, "kozep")

      %{
        currency: html_parser.get_text(currency),
        buy: html_parser.get_text(buy),
        sell: html_parser.get_text(sell),
        average: html_parser.get_text(average)
      }
    end
  end

  defp extract(error, _), do: error
end
