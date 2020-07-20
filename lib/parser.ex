defmodule Sitemap.Parser do

  import SweetXml



  #enter and xml file containing urls as <loc>http://example.com</loc> and the program will make a list of urls
  def get_urls_from_sitemap(xml) do
    xml
    |> stream_tags(:loc)
    |> Stream.map(fn {:loc, xml} -> xml |> xpath(~x"./text()") end)
    |> Enum.to_list()
    |> Enum.map(fn x -> to_string(x) end)
    |> Enum.map(fn x -> String.replace(x, "\n", "") end)
    |> Enum.map(fn x -> String.trim(x) end)
  end

  def filter_by_status(urls) do
    Enum.filter(urls, fn x -> validate_url_status(x) end)
  end

  #function checks whether url request status is 200 or not, returning true or false
  defp validate_url_status(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200}} -> true
      _ -> false
    end
  end
end