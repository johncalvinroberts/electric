defmodule ElectricTest.SatelliteHelpers do
  use Electric.Satellite.Protobuf

  import ExUnit.Assertions

  alias Satellite.TestWsClient, as: MockClient

  def assert_receive_migration(conn, version, table_name) do
    assert_receive {^conn, %SatRelation{table_name: ^table_name}}

    assert_receive {^conn,
                    %SatOpLog{
                      ops: [
                        %{op: {:begin, %SatOpBegin{is_migration: true, lsn: lsn_str}}},
                        %{op: {:migrate, %{version: ^version, table: %{name: ^table_name}}}},
                        %{op: {:commit, _}}
                      ]
                    }}

    assert {lsn, ""} = Integer.parse(lsn_str)
    assert lsn > 0
  end

  def with_connect(opts, fun), do: MockClient.with_connect(opts, fun)

  def migrate(conn, version, table \\ nil, sql) do
    results =
      :epgsql.squery(conn, """
      BEGIN;
      SELECT electric.migration_version('#{version}');
      #{sql};
      #{if table, do: "CALL electric.electrify('#{table}');"}
      COMMIT;
      """)

    Enum.each(results, fn result ->
      assert {:ok, _, _} = result
    end)

    :ok
  end
end
