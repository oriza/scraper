defmodule Scraper.Rss do
  @moduledoc """
    RSS scraper

    ## Example
    iex> Scraper.Rss.scrape("https://index.hu/24ora/rss/")
  """

  alias Scraper.Http
  import Meeseeks.CSS

  def scrape(url) do
    url
    |> Http.get()
    |> extract()
  end

  defp extract({:ok, 200, body}) do
    document = Meeseeks.parse(body, :xml)

    for entry <- Meeseeks.all(document, css("channel item")) do
      title = Meeseeks.one(entry, css("title"))
      url = Meeseeks.one(entry, css("link"))
      description = Meeseeks.one(entry, css("description"))
      published_at = Meeseeks.one(entry, css("pubDate")) || Meeseeks.one(entry, css("pubdate"))
      category = Meeseeks.one(entry, css("category"))
      author = Meeseeks.one(entry, css("author"))

      %{
        title: Meeseeks.text(title),
        url: Meeseeks.text(url),
        description: Meeseeks.text(description),
        published_at: Meeseeks.text(published_at),
        category: Meeseeks.text(category),
        author: Meeseeks.text(author)
      }
    end
  end

  defp extract({:ok, _, body}), do: {:error, body}

  defp extract({:error, reason}), do: {:error, reason}
end
