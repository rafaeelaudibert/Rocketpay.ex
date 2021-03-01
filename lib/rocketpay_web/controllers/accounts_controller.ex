defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller

  alias Rocketpay.Account

  action_fallback RocketpayWeb.FallbackController

  # POST "/accounts/:id/deposit"
  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.deposit(params) do
      conn
      |> put_status(:created)
      |> render("deposit.json", account: account)
    end
  end

  # POST "/accounts/:id/withdraw"
  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.withdraw(params) do
      conn
      |> put_status(:created)
      |> render("withdraw.json", account: account)
    end
  end
end
