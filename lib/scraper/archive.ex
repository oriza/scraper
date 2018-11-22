defmodule Scraper.Archive do
  @moduledoc """
    News archive scraper

    ## Example:
    iex> Scraper.Archive.scrape(http_client, html_parser,"http://nol.hu/belfold?page=1", %{container: ".cikkBlock.kethasabos", title: "h1", authors: ".cikkSzerzo", description: ".lead", published: ".cikkDatum.centered", url: ".vezetoCimkeAfter"})
  """

  def scrape(http_client, html_parser, url, selectors) do
    url
    |> http_client.get()
    |> extract(selectors, html_parser)
  end

  defp extract({:ok, body}, selectors, html_parser) do
    document = html_parser.parse(body)

    for article <- html_parser.select_all(document, selectors.container) do
      title = html_parser.select_one(article, selectors.title)
      url = html_parser.select_one(article, selectors.url)
      authors = html_parser.select_one(article, selectors.authors)
      description = html_parser.select_one(article, selectors.description)
      published = html_parser.select_one(article, selectors.published)

      %{
        title: html_parser.get_text(title),
        url: html_parser.get_attribute(url, "href"),
        authors: html_parser.get_text(authors),
        description: html_parser.get_text(description),
        published: html_parser.get_text(published)
      }
    end
  end

  defp extract(error, _, _), do: error
end
