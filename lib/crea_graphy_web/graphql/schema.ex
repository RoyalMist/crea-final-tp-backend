defmodule CreaGraphyWeb.Graphql.Schema do
  @moduledoc false
  use Absinthe.Schema
  import_types(Absinthe.Type.Custom)
  import_types(Absinthe.Plug.Types)
  import_types(CreaGraphyWeb.Graphql.Types.Accounts)
  import_types(CreaGraphyWeb.Graphql.Types.Blog)

  query do
    import_fields(:accounts_queries)
    import_fields(:blog_queries)
  end

  mutation do
    import_fields(:accounts_mutations)
    import_fields(:blog_mutations)
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Accounts, CreaGraphy.Accounts.datasource())
      |> Dataloader.add_source(Blog, CreaGraphy.Blog.datasource())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
