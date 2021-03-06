defmodule CreaGraphyWeb.Router do
  use CreaGraphyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CreaGraphyWeb.Graphql.Plugs.GetUser
  end

  scope "/" do
    pipe_through :api

    forward "/doc", Absinthe.Plug.GraphiQL,
      interface: :playground,
      socket: CreaGraphyWeb.UserSocket

    forward "/", Absinthe.Plug
  end
end
