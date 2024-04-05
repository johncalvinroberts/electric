defmodule Electric.Postgres.Repo do
  use Ecto.Repo, otp_app: :electric, adapter: Ecto.Adapters.Postgres
end
