defmodule Scraper.Rates do
  @moduledoc """
    napiarfolyam.hu scraper.

    ## Example
    iex> Scraper.Rates.scrape("api.napiarfolyam.hu/?bank=mnb")
  """

  def scrape(http_client, html_parser, bank) do
    "http://api.napiarfolyam.hu/?bank=#{bank}"
    |> http_client.get()
    |> extract(html_parser)
  end

  defp extract({:ok, body}, html_parser) do
    document = html_parser.parse(body)

    for rate <- html_parser.query_selector_all(document, "arfolyamok deviza item") do
      currency = html_parser.query_selector(rate, "penznem")
      buy = html_parser.query_selector(rate, "vetel")
      sell = html_parser.query_selector(rate, "eladas")
      average = html_parser.query_selector(rate, "kozep")

      %{
        currency: html_parser.text(currency),
        buy: html_parser.text(buy),
        sell: html_parser.text(sell),
        average: html_parser.text(average)
      }
    end
  end

  defp extract({:error, reason}, _), do: {:error, reason}
end
