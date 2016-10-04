defmodule ExFCM.Message do

  require Logger

  defstruct to: "", notification: nil, data: nil

  @url Application.get_env(:exfcm, :fcm_url, "")
  @server_key Application.get_env(:exfcm, :server_key, "")

  defmodule Notification do
    defstruct title: nil, body: nil
  end

  def put_notification(message \\ %__MODULE__{}, title, data) do
    notification = %Notification{ title: title, body: data}
    %__MODULE__{message | notification: notification}
  end

  def put_data(message \\ %__MODULE__{}, data) do
    %__MODULE__{message | data: data}
  end

  def target_device(message, device) do
    %{ message | to: device }
  end

  def target_topic(message \\ %__MODULE__{}, topic) do
    %{message | to: "/topics/#{topic}"}
  end

  def send(message) do
    as_json = Poison.encode!(message)
    Logger.debug as_json
    HTTPoison.post(@url,
      as_json,
      [{ "Authorization", "key=" <> @server_key},
       {"Content-Type", "application/json"}])
  end

end
