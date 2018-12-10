defmodule Scraper.Http do
  @moduledoc """
    Abstraction over HTTPoison
  """
  def get(url) do
    case HTTPoison.get(url, [], ssl: [{:versions, [:"tlsv1.2"]}]) do
      {:ok, %HTTPoison.Response{status_code: status, body: body}} -> {:ok, status, body}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end
end
