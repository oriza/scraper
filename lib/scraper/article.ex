defmodule Scraper.Article do
  @moduledoc """
    Article scraper

    ## Example
    iex> Scraper.Article.scrape("https://atlatszo.hu/2018/10/31/a-holtakra-epitett-varos-a-miniszterelnoki-rezidencia-a-kongresszusi-kozpont-es-a-szechenyi-ter-helyen-is-temetok-voltak-egykor-budapesten/", %{title: ".heading.n9 h1", authors: ".the_author.ib", published_at: ".the_post_date", category: ".heading.n9 a", content: ".the_content"})
  """

  alias Scraper.{Parser}
  import Meeseeks.CSS

  def scrape(http_client, url, selectors) do
    url
    |> http_client.get()
    |> extract(selectors)
    |> parse_datetime()
  end

  defp parse_datetime({:ok, article}) do
    {:ok, parsed} = Parser.Datetime.parse(article.published_at)

    Map.put(article, :published_at, parsed)
  end

  defp parse_datetime({:error, error}), do: {:error, error}

  defp extract({:ok, body}, selectors) do
    document = Meeseeks.parse(body)

    {:ok,
     %{
       author: get_text_from_element(document, selectors.authors),
       published_at: get_text_from_element(document, selectors.published_at),
       category: get_text_from_element(document, selectors.category),
       content: get_text_from_element(document, selectors.content),
       html: body
     }}
  end

  defp extract({:error, error}, _), do: {:error, error}

  defp get_text_from_element(document, selector) do
    document
    |> Meeseeks.one(css(selector || ""))
    |> Meeseeks.text() || nil
  end
end
