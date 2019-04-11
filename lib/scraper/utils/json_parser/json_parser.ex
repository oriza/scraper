defmodule Scraper.Utils.JSONParser do
  @callback decode(String.t) :: map
end
