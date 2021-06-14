defmodule CreaGraphyWeb.Graphql.Types.Chat do
  @moduledoc false
  use Absinthe.Schema.Notation
  alias CreaGraphyWeb.Graphql.Middlewares.Authenticate
  alias CreaGraphyWeb.Graphql.Resolvers
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :message do
    field(:body, non_null(:string))
    field(:user, :user, resolve: dataloader(Chat))
  end

  object :chat_queries do
    @desc "List all previously stored messages"
    field :messages_list, list_of(:message) do
      resolve(&Resolvers.Chat.list/2)
    end
  end

  object :chat_mutations do
    @desc "Post a message from the logged in user"
    field :messages_create, :message do
      arg(:body, non_null(:string))
      middleware(Authenticate)
      resolve(&Resolvers.Chat.create/2)
    end
  end

  object :chat_subscriptions do
    @desc "Suscribe to the chat room"
    field :messages_subscribe, :message do
      trigger(:messages_create,
        topic: fn _ ->
          "new_message"
        end
      )

      config(fn _, _ ->
        {:ok, topic: "new_message"}
      end)
    end
  end
end
