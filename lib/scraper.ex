defmodule Scraper do
  defdelegate scrape_archive(http_client, html_parser, url, selectors), to: Scraper.Archive, as: :scrape
  defdelegate scrape_article(http_client, html_parser, url, selectors), to: Scraper.Article, as: :scrape
  defdelegate scrape_gemius(http_client, json_parser, url, sites), to: Scraper.Gemius, as: :scrape
  defdelegate scrape_rates(http_client, html_parser, url), to: Scraper.Rates, as: :scrape
  defdelegate scrape_rss(http_client, rss_parser, url), to: Scraper.Rss, as: :scrape
  defdelegate scrape_weather(http_client, json_parser, city), to: Scraper.Weather, as: :scrape
end
