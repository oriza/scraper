defmodule Scraper.Utils.HTTPClient do
  @callback get(String.t) :: {:ok, String.t} | {:error, String.t}
end
