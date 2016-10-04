defmodule ExFCMTest do
  use ExUnit.Case
  doctest ExFCM

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "Sends message" do
    alias ExFCM.Message

    {:ok , result } = Message.put_data(%{"sample" => "true"})
    |> Message.put_notification("Tomasz","Cichocinski")
    |> Message.target_topic("giveaways")
    |> Message.send

    IO.inspect Poison.decode!(result.body)
  end
end
