defmodule UAInspector.ShortCodeMap.DesktopFamilies do
  @moduledoc false

  use UAInspector.Storage.Server

  require Logger

  alias UAInspector.Config
  alias UAInspector.Util.YAML

  @behaviour UAInspector.ShortCodeMap

  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def source do
    {"short_codes.desktop_families.yml",
     Config.database_url(:short_code_map, "DeviceDetector.php")}
  end

  def var_name, do: "desktopOsArray"
  def var_type, do: :list

  defp read_database do
    {local, _} = source()
    map = Path.join(Config.database_path(), local)

    map
    |> YAML.read_file()
    |> parse_yaml_entries(map)
  end

  defp parse_yaml_entries({:ok, entries}, _), do: entries

  defp parse_yaml_entries({:error, error}, map) do
    _ =
      unless Config.get(:startup_silent) do
        Logger.info("Failed to load short code map #{map}: #{inspect(error)}")
      end

    []
  end
end
