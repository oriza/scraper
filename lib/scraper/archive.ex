defmodule Scraper.Archive do
  @moduledoc """
    News archive scraper

    ## Example:
    iex> Scraper.Archive.scrape("http://nol.hu/belfold?page=1", %{container: ".cikkBlock.kethasabos", title: "h1", authors: ".cikkSzerzo", description: ".lead", published_at: ".cikkDatum.centered", url: ".vezetoCimkeAfter"})
  """

  alias Scraper.Http
  import Meeseeks.CSS

  def scrape(http_client, url, selectors) do
    url
    |> http_client.get()
    |> extract(selectors)
    |> articles_or_error()
  end

  defp extract({:ok, 200, body}, selectors) do
    document = Meeseeks.parse(body)

    for article <- Meeseeks.all(document, css(selectors.container)) do
      title = Meeseeks.one(article, css(selectors.title))
      author = Meeseeks.one(article, css(selectors.authors))
      description = Meeseeks.one(article, css(selectors.description))
      published_at = Meeseeks.one(article, css(selectors.published_at))

      %{
        title: Meeseeks.text(title),
        url: Meeseeks.attr(title, "href"),
        author: Meeseeks.text(author),
        description: Meeseeks.text(description),
        published_at: Meeseeks.text(published_at)
      }
    end
  end

  defp extract({:ok, _, body}, _), do: {:error, body}

  defp extract(error, _), do: error

  defp articles_or_error(articles) when is_list(articles) do
    {:ok, articles}
  end

  defp articles_or_error(message) do
    {:error, message}
  end
end
