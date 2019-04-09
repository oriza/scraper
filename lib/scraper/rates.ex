defmodule Scraper.Rates do
  @moduledoc """
    napiarfolyam.hu scraper.

    ## Example
    iex> Scraper.Rates.scrape("api.napiarfolyam.hu/?bank=mnb")
  """

  import Meeseeks.CSS

  def scrape(http_client, bank) do
    "http://api.napiarfolyam.hu/?bank=#{bank}"
    |> http_client.get()
    |> extract()
  end

  defp extract({:ok, body}) do
    document = Meeseeks.parse(body)

    for rate <- Meeseeks.all(document, css("arfolyamok deviza item")) do
      currency = Meeseeks.one(rate, css("penznem"))
      buy = Meeseeks.one(rate, css("vetel"))
      sell = Meeseeks.one(rate, css("eladas"))
      average = Meeseeks.one(rate, css("kozep"))

      %{
        currency: Meeseeks.text(currency),
        buy: Meeseeks.text(buy),
        sell: Meeseeks.text(sell),
        average: Meeseeks.text(average)
      }
    end
  end

  defp extract({:error, reason}), do: {:error, reason}
end
