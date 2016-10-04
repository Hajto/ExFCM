defmodule ExFCM.Message do

  @moduledoc """
  This module is used to manage and send Messages.

  To send a notification you have to provide a target using `target_device` (for a single device or group of devices) or using a `target_topic`.

  ## Examples

  ```

  {:ok , result } = Message.put_data(%{"sample" => "true"})
  |> Message.put_notification("Title","Description")
  |> Message.target_topic("sample_giveaways")
  |> Message.send

  ```

  """

  require Logger

  defstruct to: "", notification: nil, data: nil

  @url Application.get_env(:exfcm, :fcm_url, "")
  @server_key Application.get_env(:exfcm, :server_key, "")

  defmodule Notification do
    defstruct title: nil, body: nil
  end

  @doc """
  Puts a Notification inside message. It will be displayed in tray when app is in background.
  """

  def put_notification(message \\ %__MODULE__{}, title, data) do
    notification = %Notification{ title: title, body: data}
    %__MODULE__{message | notification: notification}
  end

  @doc """
  Puts a data fieldd into sending json, if it's present the `onMessageReceived` callback will be called on client.
  """

  def put_data(message \\ %__MODULE__{}, data) do
    %__MODULE__{message | data: data}
  end


  @doc """
  Sets target of notification. It should be either legal DeviceID obtained through a proper callback on client side and sent or a registered device group id.
  """
  def target_device(message \\ %__MODULE__{}, device) do
    %{ message | to: device }
  end

  @doc """
  Sets target of notification. It should be only the name of the topic without "/topics/name".

  Topic has to match ``` [a-zA-Z0-9-_.~%]+  ``` regex.
  """

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
