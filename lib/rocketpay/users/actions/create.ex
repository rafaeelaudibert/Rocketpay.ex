defmodule Rocketpay.User.Create do
  alias Ecto.Multi
  alias Rocketpay.{Account, Repo, User}

  @initial_balance "0.00"

  def call(params) do
    Multi.new()
      |> Multi.insert(:insert_user, User.changeset(params))
      |> Multi.run(
        :insert_account,
        fn repo, %{insert_user: user} -> insert_account(repo, user) end
      )
      |> run_transaction()
  end

  defp insert_account(repo, user) do
    user.id
      |> account_changeset()
      |> repo.insert()
  end


  defp account_changeset(user_id) do
    params = %{
      balance: @initial_balance,
      user_id: user_id
    }

    Account.changeset(params)
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{insert_user: user}} -> {:ok, Repo.preload(user, :account)}
    end
  end
end
