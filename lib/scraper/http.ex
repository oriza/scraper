defmodule Scraper.Http do
  @moduledoc """
    Abstraction over HTTPoison
  """
  def get(url) do
    case HTTPoison.get(url, [], ssl: [{:versions, [:"tlsv1.2"]}]) do
      {:ok, %HTTPoison.Response{status_code: status, body: body}} ->
        decoded_body = decode(body)

        {:ok, status, decoded_body}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end

  defp decode(body) when is_binary(body) do
    if String.valid?(body) do
      body
    else
      Enum.join(for <<c::utf8 <- body>>, do: <<c::utf8>>)
    end
  end

  defp decode(_), do: nil
end
