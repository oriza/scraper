defmodule Scraper.Rss do
  @moduledoc """
    RSS scraper

    ## Example
    iex> Scraper.Rss.scrape(http_client, rss_parser, "https://index.hu/24ora/rss/")
  """

  def scrape(http_client, rss_parser, url) do
    url
    |> http_client.get()
    |> extract(rss_parser)
  end

  defp extract({:ok, body}, rss_parser) do
    body
    |> rss_parser.parse()
    |> Enum.map(fn entry ->
      %{
        title: entry.title,
        description: entry.description,
        published_at: entry.updated,
        url: entry.url,
        categories: entry.categories,
        author: entry.author
      }
    end)
  end

  defp extract(error, _), do: error
end
