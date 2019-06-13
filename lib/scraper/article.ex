defmodule Scraper.Article do
  @moduledoc """
    Article scraper

    ## Example
    iex> Scraper.Article.scrape("https://atlatszo.hu/2018/10/31/a-holtakra-epitett-varos-a-miniszterelnoki-rezidencia-a-kongresszusi-kozpont-es-a-szechenyi-ter-helyen-is-temetok-voltak-egykor-budapesten/", %{title: ".heading.n9 h1", authors: ".the_author.ib", published_at: ".the_post_date", category: ".heading.n9 a", content: ".the_content"})
  """

  alias Scraper.Parser

  def scrape(http_client, html_parser, url, selectors) do
    url
    |> http_client.get()
    |> extract(html_parser, selectors)
    #|> parse_datetime()
  end

  defp parse_datetime({:ok, article}) do
    {:ok, parsed} = Parser.Datetime.parse(article.published_at)

    Map.put(article, :published_at, parsed)
  end

  defp parse_datetime({:error, error}), do: {:error, error}

  defp extract({:ok, body}, html_parser, selectors) do
    document = html_parser.parse(body)

    {:ok,
     %{
       title: html_parser.text(html_parser.query_selector(document, selectors.title)),
       author: html_parser.text(html_parser.query_selector(document, selectors.authors)),
       published_at: html_parser.text(html_parser.query_selector(document, selectors.published_at)),
       category: html_parser.text(html_parser.query_selector(document, selectors.category)),
       content: html_parser.text(html_parser.query_selector(document, selectors.content)),
       html: body
     }}
  end

  defp extract({:error, error}, _, _), do: {:error, error}
end
