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
    |> UseXml.get_xml()
    |> Urls.get_urls_from_sitemap()
  end

  def save_sitemap_file(dataset, filename) do
    dataset
    |> Enum.filter(fn x -> String.match?(x, ~r/#{filename}/) end)
    |> Enum.sort
    |> Enum.uniq
    |> UseXml.gen_xml
    |> UseXml.save_tofile(filename)
  end

  def get_etc(dataset) do
    dataset
    |> Enum.filter(fn x -> !String.match?(x, ~r/atendimento/) end)
    |> Enum.filter(fn x -> !String.match?(x, ~r/cobertura-e-roaming/) end)
    |> Enum.filter(fn x -> !String.match?(x, ~r/diversao/) end)
    |> Enum.filter(fn x -> !String.match?(x, ~r/internet/) end)
    |> Enum.filter(fn x -> !String.match?(x, ~r/perguntas-frequentes/) end)
    |> Enum.filter(fn x -> !String.match?(x, ~r/planos/) end)
    |> Enum.filter(fn x -> !String.match?(x, ~r/recarga/) end)
    |> Enum.filter(fn x -> !String.match?(x, ~r/servicos-tim/) end)
  end

  def gen_sitemap(section_string) do
    urls_old = "https://www.tim.com.br/Portal_Conteudo/_staticfiles/sitemap_#{section_string}.xml" |> get_urls_from_sitemap()
    urls_new = Sitemap.ImportDocument.get_dataset_from_file("urls_novas.txt") |> Enum.filter(fn x -> String.match?(x, ~r/#{section_string}/) end)
    urls = urls_new ++ urls_old |> Enum.uniq
    urls |> save_sitemap_file(section_string)
  end

  def sections do
    ["atendimento", "cobertura-e-roaming", "diversao", "internet", "perguntas-frequentes", "planos", "recarga", "servicos-tim"]
  end

end
