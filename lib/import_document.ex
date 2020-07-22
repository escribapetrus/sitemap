defmodule Sitemap.ImportDocument do
  import Sitemap.Urls, only: [clean_url: 1]

  def get_dataset_from_file(filename) do
    filename
    |> Path.expand
    |> File.stream!
    |> Enum.map(fn x -> clean_url(x) end)
    |> Enum.uniq
  end

end
