defmodule RocketpayWeb.WelcomeController do
  use RocketpayWeb, :controller

  alias Rocketpay.Numbers

  # GET "/:filename"
  def index(conn, %{"filename" => filename}) do
    filename
    |> Numbers.sum_from_file()
    |> handle_response(conn)
  end

  defp handle_response({:ok, result}, conn) do
    conn
      |> put_status(:ok)
      |> json(%{message: "Welcome to RocketPay API. Here is the result: #{result}"})
      |> IO.inspect()
  end

  defp handle_response({:error, reason}, conn) do
    conn
      |> put_status(:bad_request)
      |> json(%{reason: reason})
  end
end
