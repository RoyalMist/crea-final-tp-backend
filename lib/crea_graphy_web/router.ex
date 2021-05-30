defmodule CreaGraphyWeb.Router do
  use CreaGraphyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CreaGraphyWeb do
    pipe_through :api
  end
end
