defmodule Scraper.Weather do
  @moduledoc """
    Openweather scraper. Scraping current weather and forecast.
  """

  @key "2104b50520622124732b407213d8d4b2"

  def scrape(http_client, json_parser, city) do
    "http://api.openweathermap.org/data/2.5/weather?q=#{city}&units=metric&lang=hu&APPID=#{@key}"
    |> http_client.get()
    |> extract(json_parser)
  end

  defp extract({:ok, body}, json_parser) do
    {:ok, data} = json_parser.decode(body)

    %{
      current_temperature: data["main"]["temp"],
      description: List.first(data["weather"])["description"],
      icon: List.first(data["weather"])["icon"]
    }
  end

  defp extract({:error, error}, _), do: {:error, error}
end
