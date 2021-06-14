defmodule CreaGraphy.ChatTest do
  use CreaGraphy.DataCase

  alias CreaGraphy.Chat
  import CreaGraphy.AccountsFixtures

  describe "messages" do
    alias CreaGraphy.Chat.Message

    @valid_attrs %{body: "some body"}
    @update_attrs %{body: "some updated body"}
    @invalid_attrs %{body: nil}

    def message_fixture(attrs \\ %{}) do
      user = user_fixture()

      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Enum.into(%{user_id: user.id})
        |> Chat.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Chat.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Chat.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      user = user_fixture()

      assert {:ok, %Message{} = message} =
               Chat.create_message(Map.merge(@valid_attrs, %{user_id: user.id}))

      assert message.body == "some body"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, %Message{} = message} = Chat.update_message(message, @update_attrs)
      assert message.body == "some updated body"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_message(message, @invalid_attrs)
      assert message == Chat.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Chat.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Chat.change_message(message)
    end
  end
end
