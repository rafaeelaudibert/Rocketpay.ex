defmodule Rocketpay.Numbers do
  def sum_from_file(filename) do
     "#{filename}.csv"
      |> File.read()
      |> handle_file()
  end

  defp handle_file({:ok, file}) do
    sum = file
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()

    {:ok, sum}
  end

  defp handle_file({:error, _reason}), do: {:error, "Invalid file"}
end
