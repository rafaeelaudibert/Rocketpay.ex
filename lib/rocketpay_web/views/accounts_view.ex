defmodule RocketpayWeb.AccountsView do
  def render("deposit.json", data), do: render(data, "Deposit completed")
  def render("withdraw.json", data), do: render(data, "Withdraw completed")

  def render(%{account: account}, message) do
    %{
      message: message,
      account: %{
        id: account.id,
        balance: account.balance
      }
    }
  end
end
