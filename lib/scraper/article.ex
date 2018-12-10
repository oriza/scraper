defmodule Scraper.Article do
  @moduledoc """
    Article scraper

    ## Example
    iex> Scraper.Article.scrape("https://atlatszo.hu/2018/10/31/a-holtakra-epitett-varos-a-miniszterelnoki-rezidencia-a-kongresszusi-kozpont-es-a-szechenyi-ter-helyen-is-temetok-voltak-egykor-budapesten/", %{title: ".heading.n9 h1", authors: ".the_author.ib", published_at: ".the_post_date", category: ".heading.n9 a", content: ".the_content"})
  """

  alias Scraper.Http
  import Meeseeks.CSS

  def scrape(url, selectors) do
    url
    |> Http.get()
    |> extract(selectors)
    |> article_or_error()
  end

  defp extract({:ok, 200, body}, selectors) do
    document = Meeseeks.parse(body)

    title = Meeseeks.one(document, css(selectors.title))
    authors = Meeseeks.one(document, css(selectors.authors))
    published = Meeseeks.one(document, css(selectors.published_at))
    category = Meeseeks.one(document, css(selectors.category))
    content = Meeseeks.one(document, css(selectors.content))

    %{
      title: Meeseeks.text(title),
      authors: Meeseeks.text(authors),
      published: Meeseeks.text(published),
      category: Meeseeks.text(category),
      content: Meeseeks.text(content)
    }
  end

  defp extract({:ok, _, body}, _), do: {:error, body}

  defp extract(error, _), do: error

  defp article_or_error(article) when is_map(article) do
    {:ok, article}
  end

  defp article_or_error(message) do
    {:error, message}
  end
end
