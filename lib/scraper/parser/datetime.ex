defmodule Scraper.Parser.Datetime do
  @dates [
    "ma 19:41",
    "2019-01-14",
    "2019. 01. 11.",
    "2019.01.14 18:21",
    "2019.01.14. 18:51",
    "január 14. | 14:00",
    "2019. 01. 14. 20:00",
    "2019. jan. 13., 13:12",
    "2019. január 14. 19:07",
    "2019. január. 14. 20:00",
    "/ 2018.08.03., péntek 13:00 /",
    "2019. január 14. hétfő 12:20",
    "2019. január 14. hétfő, 16:47",
    "2019. január 14., hétfő 17:45",
    "újságíró . 2019. 01. 14. 20:17",
    "2019. január 14. 20:15 - szerző: Mészáros Márton",
    "2018. április 10., kedd 10:43, frissítve: kedd 11:55"
  ]

  @time ~r/(\d{2}):(\d{2})/
  @today ~r/ma/
  @datetime_pattern ~r/(?:.*(?<year>\d{4}))?.*?(?<month>\d{2}|jan|feb|már|ápr|máj|jún|júl|aug|sze|okt|nov|dec).*?(?<day>\d{1,2})(?:(?:.*(?<time>(\d{2}):(\d{2})))|)/

  def get_dates(), do: @dates

  def parse(datetime) do
    datetime
    |> parse_today()
    |> parse_datetime()
    |> to_datetime()
  end

  defp format_today(datetime) do
    %{year: year, month: month, day: day} = DateTime.utc_now()

    time =
      @time
      |> Regex.run(datetime)
      |> List.first()

    %{
      "year" => date_item_to_string(year),
      "month" => date_item_to_string(month),
      "day" => date_item_to_string(day),
      "time" => time
    }
  end

  defp format_datetime(datetime) do
    formatted_month = get_month(datetime["month"])
    Map.put(datetime, "month", formatted_month)
  end

  defp parse_today(datetime) do
    if Regex.match?(@today, datetime) do
      today = format_today(datetime)
      {today, datetime}
    else
      {nil, datetime}
    end
  end

  defp parse_datetime({nil, datetime}) do
    @datetime_pattern
    |> Regex.named_captures(datetime)
    |> format_datetime()
  end

  defp parse_datetime({time, _}), do: time

  defp to_datetime(%{"year" => year, "month" => month, "day" => day, "time" => time}) do
    year = get_year(year)
    time = get_time(time)

    "#{year}-#{month}-#{day}T#{time}+01:00"
    |> Timex.parse("{ISO:Extended}")
  end

  defp get_time(time) do
    if String.trim(time) == "" do
      "00:00"
    else
      time
    end
  end

  defp get_year(year) do
    if String.trim(year) == "" do
      Timex.now("Europe/Budapest").year
    else
      year
    end
  end

  defp get_month("jan"), do: "01"
  defp get_month("feb"), do: "02"
  defp get_month("már"), do: "03"
  defp get_month("ápr"), do: "04"
  defp get_month("máj"), do: "05"
  defp get_month("jún"), do: "06"
  defp get_month("júl"), do: "07"
  defp get_month("aug"), do: "08"
  defp get_month("sze"), do: "09"
  defp get_month("okt"), do: "10"
  defp get_month("nov"), do: "11"
  defp get_month("dec"), do: "12"
  defp get_month(month), do: month

  defp date_item_to_string(1), do: "01"
  defp date_item_to_string(2), do: "02"
  defp date_item_to_string(3), do: "03"
  defp date_item_to_string(4), do: "04"
  defp date_item_to_string(5), do: "05"
  defp date_item_to_string(6), do: "06"
  defp date_item_to_string(7), do: "07"
  defp date_item_to_string(8), do: "08"
  defp date_item_to_string(9), do: "09"
  defp date_item_to_string(num), do: Integer.to_string(num)
end
