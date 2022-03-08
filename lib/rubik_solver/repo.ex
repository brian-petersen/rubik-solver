defmodule RubikSolver.Repo do
  use Ecto.Repo,
    otp_app: :rubik_solver,
    adapter: Ecto.Adapters.Postgres
end
