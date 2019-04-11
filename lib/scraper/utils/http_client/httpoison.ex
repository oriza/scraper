defmodule Scraper.Utils.HTTPClient.HTTPoison do
  @moduledoc """
    Abstraction over HTTPoison
  """

  @behaviour Scraper.Utils.HTTPClient

  @impl Scraper.Utils.HTTPClient
  def get(url) do
    case HTTPoison.get(url, [], ssl: [{:versions, [:"tlsv1.2"]}]) do
      {:ok, %HTTPoison.Response{body: body}} ->
        decoded_body = decode(body)

        {:ok, decoded_body}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp decode(raw) when is_binary(raw) do
    Enum.reduce(String.codepoints(raw), fn(w, result) ->
      cond do
        String.valid?(w) ->
          result <> w
        true ->
          << parsed :: 8>> = w
          result <> << parsed :: utf8 >>
      end
    end)
  end

  defp decode(_), do: nil
end
