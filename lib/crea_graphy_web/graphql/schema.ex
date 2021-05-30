defmodule CreaGraphyWeb.Graphql.Schema do
  @moduledoc false
  use Absinthe.Schema
  import_types(Absinthe.Type.Custom)
  import_types(Absinthe.Plug.Types)
  import_types(CreaGraphyWeb.Graphql.Types.Accounts)

  query do
    import_fields(:accounts_queries)
  end

  # mutation do
  # import_fields(:_NAME_mutations)
  # end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Accounts, CreaGraphy.Accounts.datasource())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
