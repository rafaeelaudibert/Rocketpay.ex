defmodule Rocketpay do
  alias Rocketpay.User.Create, as: UserCreate
  defdelegate create_user(params), to: UserCreate, as: :call

  alias Rocketpay.Account.Deposit, as: Deposit
  defdelegate deposit(params), to: Deposit, as: :call

  alias Rocketpay.Account.Withdraw, as: Withdraw
  defdelegate withdraw(params), to: Withdraw, as: :call
end
