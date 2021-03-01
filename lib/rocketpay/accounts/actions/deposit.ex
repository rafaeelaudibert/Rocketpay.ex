defmodule Rocketpay.Account.Deposit do
  alias Ecto.Multi
  alias Rocketpay.{Account, Repo}

  def call(%{"id" => account_id, "value" => value}) do
    Multi.new()
      |> Multi.run(:account, fn repo, _changes -> get_account(repo, account_id) end)
      |> Multi.run(
        :update_balance,
        fn repo, %{account: account} -> update_balance(repo, account, value) end
      )
      |> run_transaction()
  end

  defp get_account(repo, account_id) do
    case repo.get(Account, account_id) do
      nil -> {:error, "Account not found"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, account, value) do
    account
      |> sum_values(value)
      |> update_account(account, repo)
  end

  defp sum_values(%Account{balance: balance}, value) do
    {:ok, zero} = Decimal.cast(0)

    case Decimal.cast(value) do
      {:ok, casted_value} -> if Decimal.compare(casted_value, zero) == :lt,
        do: {:error, "Deposit value is negative"},
        else: Decimal.add(balance, casted_value)
      :error -> {:error, "Invalid deposit value"}
    end
  end

  defp update_account({:error, _reason}=error, _account, _repo), do: error
  defp update_account(balance, account, repo) do
    params = %{balance: balance}

    params
      |> Account.changeset(account)
      |> repo.update()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{update_balance: account}} -> {:ok, account}
    end
  end
end
