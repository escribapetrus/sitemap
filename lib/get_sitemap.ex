defmodule Sitemap.GetSitemap do
  import SweetXml

  def get_sitemap(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        "Not found"
      {:error, %HTTPoison.Error{reason: reason}} ->
        reason
    end
  end

  def get_urls_from_sitemap(xml) do
    xml
    |> stream_tags(:loc)
    |> Stream.map(fn {:loc, xml} -> xml |> xpath(~x"./text()") end)
    |> Enum.to_list()
    |> Enum.map(fn x -> to_string(x) end)
    |> Enum.map(fn x -> String.replace(x, "\n", "") end)
    |> Enum.map(fn x -> String.trim(x) end)
  end

end
