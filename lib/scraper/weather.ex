defmodule Scraper.Weather do
  @moduledoc """
    Openweather scraper. Scraping current weather and forecast.
  """
  @key "3a96de8843294fc571b69c83c7c368c0"

  def scrape(city) do
    "http://api.openweathermap.org/data/2.5/weather?q=#{city}&units=metric&lang=hu&APPID=#{@key}"
    |> Scraper.Http.get()
    |> extract()
  end

  defp extract({:ok, 200, body}) do
    {:ok, data} = Jason.decode(body)

    %{
      temperature: data["main"]["temp"],
      description: List.first(data["weather"])["description"],
      icon: List.first(data["weather"])["icon"]
    }
  end

  defp extract({:ok, _, body}, _), do: {:error, body}

  defp extract(error), do: error
end
