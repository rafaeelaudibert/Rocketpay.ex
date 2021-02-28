defmodule Rocketpay.NumbersTest do
  use ExUnit.Case

  alias Rocketpay.Numbers

  describe "sum_fom_file/1" do
    test "when there is a file with the given name, returns the sum of the numbers" do
      response = Numbers.sum_from_file("numbers")

      expected_response = {:ok, 37}
      assert response == expected_response
    end

    test "when there is not a file with the given name, returns an error" do
      response = Numbers.sum_from_file("file_not_exists")

      expected_response = {:error, "Invalid file"}
      assert response == expected_response
    end
  end
end
