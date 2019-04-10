defmodule Scraper do
  @moduledoc """
    Scraper module for scraping various sources
  """

  defdelegate scrape_archive(http_client, url, selectors), to: Scraper.Archive, as: :scrape
  defdelegate scrape_article(http_client, html_parser, url, selectors), to: Scraper.Article, as: :scrape
  defdelegate scrape_gemius(http_client, url, sites), to: Scraper.Gemius, as: :scrape
  defdelegate scrape_rates(http_client, url), to: Scraper.Rates, as: :scrape
  defdelegate scrape_rss(http_client, html_scraper, url), to: Scraper.Rss, as: :scrape
  defdelegate scrape_weather(http_client, city), to: Scraper.Weather, as: :scrape
end
