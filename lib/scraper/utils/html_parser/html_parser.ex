defmodule Scraper.Utils.HTMLParser do
  @callback parse(String.t()) :: map | nil
  @callback parse(String.t(), atom) :: map | nil
  @callback query_selector(map, String.t() | list(String.t())) :: map | nil
  @callback query_selector_all(map, String.t() | list(String.t())) :: list(map) | nil
  @callback text(map) :: String.t() | nil
  @callback attr(map, String.t()) :: String.t() | nil
end
