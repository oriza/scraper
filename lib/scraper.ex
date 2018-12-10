defmodule Scraper do
  @moduledoc """
    Scraper module for scraping various sources
  """
  defdelegate scrape_archive(url, selectors), to: Scraper.Archive, as: :scrape
  defdelegate scrape_article(url, selectors), to: Scraper.Article, as: :scrape
  defdelegate scrape_gemius(url, sites), to: Scraper.Gemius, as: :scrape
  defdelegate scrape_rates(url), to: Scraper.Rates, as: :scrape
  defdelegate scrape_rss(url), to: Scraper.Rss, as: :scrape
  defdelegate scrape_weather(city), to: Scraper.Weather, as: :scrape
end
