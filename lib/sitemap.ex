defmodule Sitemap do
  alias Sitemap.UseXml
  alias Sitemap.Parser

  @moduledoc """
  Documentation for `Sitemap`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Sitemap.hello()
      :world

  """
  #enter the url to a sitemap .xml
  def get_urls(url) do
    url
    |> UseXml.get_xml()
    |> Parser.get_urls_from_sitemap()
  end

end
