defmodule Scraper.Utils.HTMLParser.Meeseeks do
  @moduledoc """
    Abstraction over Meeseeks
  """

  import Meeseeks.CSS
  @behaviour Scraper.Utils.HTMLParser

  @impl Scraper.Utils.HTMLParser
  def parse(nil), do: nil

  def parse(html), do: Meeseeks.parse(html)

  @impl Scraper.Utils.HTMLParser
  def parse(html, mode) when is_nil(html) or is_nil(mode), do: nil
  def parse(html, mode), do: Meeseeks.parse(html, mode)

  @impl Scraper.Utils.HTMLParser
  def query_selector(document, selector) when is_nil(document) or is_nil(selector), do: nil

  def query_selector(document, selectors) when is_list(selectors) do
    [selector | tail] = selectors

    case query_selector(document, selector) do
      nil ->
        query_selector(document, tail)
      element ->
        element
    end
  end

  def query_selector(document, selector) do
    Meeseeks.one(document, css(selector))
  end

  @impl Scraper.Utils.HTMLParser
  def query_selector_all(document, selectors) when is_nil(document) or is_nil(selectors), do: nil

  def query_selector_all(document, selectors) when is_list(selectors) do
    [selector | tail] = selectors

    case query_selector_all(document, selector) do
      nil ->
        query_selector_all(document, tail)
      elements ->
        elements
    end
  end

  def query_selector_all(document, selector), do: Meeseeks.all(document, css(selector))

  @impl Scraper.Utils.HTMLParser
  def text(nil), do: nil

  def text(element), do: Meeseeks.text(element)

  @impl Scraper.Utils.HTMLParser
  def attr(element, attr), do: Meeseeks.attr(element, attr)
end
