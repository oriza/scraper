defmodule Scraper.Article do
  @moduledoc """
    Article scraper

    ## Example
    iex> Scraper.Article.scrape(http_client, html_parser, "https://atlatszo.hu/2018/10/31/a-holtakra-epitett-varos-a-miniszterelnoki-rezidencia-a-kongresszusi-kozpont-es-a-szechenyi-ter-helyen-is-temetok-voltak-egykor-budapesten/", %{title: ".heading.n9 h1", authors: ".the_author.ib", published: ".the_post_date", category: ".heading.n9 a", content: ".the_content"}
  """

  def scrape(http_client, html_parser, url, selectors) do
    url
    |> http_client.get()
    |> extract(selectors, html_parser)
  end

  defp extract({:ok, body}, selectors, html_parser) do
    document = html_parser.parse(body)

    title = html_parser.select_one(document, selectors.title)
    authors = html_parser.select_one(document, selectors.authors)
    published = html_parser.select_one(document, selectors.published)
    category = html_parser.select_one(document, selectors.category)
    content = html_parser.select_one(document, selectors.content)

    %{
      title: html_parser.get_text(title),
      authors: html_parser.get_text(authors),
      published: html_parser.get_text(published),
      category: html_parser.get_text(category),
      content: html_parser.get_text(content)
    }
  end

  defp extract(error, _, _), do: error
end
