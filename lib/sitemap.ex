defmodule Sitemap do
  alias Sitemap.UseXml
  alias Sitemap.Urls

  @moduledoc """
  Documentation for `Sitemap`.
  """

  # para obter as urls de cada seção, filtrar com Enum.filter(dataset, fn x -> String.match?(x, ~r/nomedasecao/) end)

  @doc """
  Hello world.

  ## Examples

      iex> Sitemap.hello()
      :world

  """
  #enter the url to a sitemap .xml
  def get_urls_from_sitemap(url) do
    url
    |> UseXml.get_xml
    |> Urls.get_urls_from_sitemap
  end

  def save_sitemap_file(dataset, filename) do
    dataset
    |> Enum.filter(fn x -> String.match?(x, ~r/#{filename}/) end)
    |> Enum.sort
    |> Enum.uniq
    |> UseXml.gen_xml
    |> UseXml.save_tofile(filename)
  end


end
