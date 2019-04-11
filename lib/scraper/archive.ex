defmodule Scraper.Archive do
  @moduledoc """
    News archive scraper

    ## Example:
    iex> Scraper.Archive.scrape("http://nol.hu/belfold?page=1", %{container: ".cikkBlock.kethasabos", title: "h1", authors: ".cikkSzerzo", description: ".lead", published_at: ".cikkDatum.centered", url: ".vezetoCimkeAfter"})
  """

  def scrape(http_client, html_parser, url, selectors) do
    url
    |> http_client.get()
    |> extract(html_parser, selectors)
    |> articles_or_error()
  end

  defp extract({:ok, body}, html_parser, selectors) do
    document = html_parser.parse(body)

    for article <- html_parser.query_selector_all(document, selectors.container) do
      title = html_parser.query_selector(article, selectors.title)
      author = html_parser.query_selector(article, selectors.authors)
      description = html_parser.query_selector(article, selectors.description)
      published_at = html_parser.query_selector(article, selectors.published_at)

      %{
        title: html_parser.text(title),
        url: html_parser.attr(title, "href"),
        author: html_parser.text(author),
        description: html_parser.text(description),
        published_at: html_parser.text(published_at)
      }
    end
  end

  defp extract(error, _, _), do: error

  defp articles_or_error(articles) when is_list(articles) do
    {:ok, articles}
  end

  defp articles_or_error(message) do
    {:error, message}
  end
end
