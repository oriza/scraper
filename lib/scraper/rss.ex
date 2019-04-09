defmodule Scraper.Rss do
  @moduledoc """
    RSS scraper

    ## Example
    iex> Scraper.Rss.scrape("https://index.hu/24ora/rss/")
  """

  import Meeseeks.CSS

  def scrape(http_client, url) do
    url
    |> http_client.get()
    |> extract()
    |> Enum.map(&format_datetime/1)
  end

  defp extract({:ok, body}) do
    document = Meeseeks.parse(body, :xml)

    for entry <- Meeseeks.all(document, css("channel item")) do
      title = Meeseeks.one(entry, css("title"))
      url = Meeseeks.one(entry, css("link"))
      description = Meeseeks.one(entry, css("description"))
      published_at = Meeseeks.one(entry, css("pubDate")) || Meeseeks.one(entry, css("pubdate"))
      category = Meeseeks.one(entry, css("category"))
      author = Meeseeks.one(entry, css("author"))

      %{
        title: Meeseeks.text(title),
        url: Meeseeks.text(url),
        description: Meeseeks.text(description),
        published_at: Meeseeks.text(published_at),
        category: Meeseeks.text(category),
        author: Meeseeks.text(author)
      }
    end
  end

  defp extract({:error, reason}), do: {:error, reason}

  defp format_datetime(article) do
    Map.put(article, :published_at, parse(article.published_at))
  end
  # "Tue, 08 Jan 2019 20:26:00 +0100"
  def parse(datetime_string) do
    ~r/(?<day>[\d]{1,2})[\s]+(?<month>[^\d]{3})[\s]+(?<year>[\d]{2,4})[\s]+(?<hour>[\d]{2})[^\d]?(?<min>[\d]{2})[^\d]?(?<sec>[\d]{2})[^\d]?(((?<offset_sign>[+-])(?<offset_hours>[\d]{2})(?<offset_mins>[\d]{2})|(?<offset_letters>[A-Z]{1,3})))?/
    |> Regex.named_captures(datetime_string)
    |> create_datetime_string()
  end

  def create_datetime_string(dt_map) do
    "#{dt_map["year"]}-#{get_month(dt_map["month"])}-#{format_day(dt_map["day"])}T#{dt_map["hour"]}:#{dt_map["min"]}:#{dt_map["sec"]}#{create_offset(dt_map)}"
  end

  def create_offset(dt_map) do
    if (String.trim(dt_map["offset_sign"]) == "") do
      "+01:00"
    else
      "#{dt_map["offset_sign"]}#{dt_map["offset_hours"]}:#{dt_map["offset_mins"]}"
    end
  end

  defp format_day(day) do
    if (String.length(day) == 1) do
      "0#{day}"
    else
      day
    end
  end

  defp get_month("Jan"), do: "01"
  defp get_month("Feb"), do: "02"
  defp get_month("Mar"), do: "03"
  defp get_month("Apr"), do: "04"
  defp get_month("May"), do: "05"
  defp get_month("Jun"), do: "06"
  defp get_month("Jul"), do: "07"
  defp get_month("Aug"), do: "08"
  defp get_month("Sep"), do: "09"
  defp get_month("Oct"), do: "10"
  defp get_month("Nov"), do: "11"
  defp get_month("Dec"), do: "12"
end
