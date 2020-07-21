defmodule Sitemap.UseXml do
  import XmlBuilder, only: [element: 2, document: 2, generate: 1]

  def get_xml(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        "Not found"
      {:error, %HTTPoison.Error{reason: reason}} ->
        reason
    end
  end

  def gen_xml(dataset) do
    sitemap =
      dataset
      |> Enum.map(fn x -> element(:loc, [element(:url, x)]) end)
      # |> Enum.map(fn x -> element(:url, x) end)
    document(:urlset, sitemap) |> generate()
  end

  def save_tofile(data,filename) do
    {:ok, file} = File.open("sitemap_#{filename}.xml", [:write])
    IO.binwrite(file, data)
    File.close(file)
  end

end
