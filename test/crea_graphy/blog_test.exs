defmodule CreaGraphy.BlogTest do
  use CreaGraphy.DataCase
  import CreaGraphy.AccountsFixtures
  alias CreaGraphy.Blog

  describe "articles" do
    alias CreaGraphy.Blog.Article

    @valid_attrs %{body: "some body", tags: [], title: "some title"}
    @update_attrs %{body: "some updated body", tags: [], title: "some updated title"}
    @invalid_attrs %{body: nil, tags: nil, title: nil}

    def article_fixture(attrs \\ %{}) do
      user = user_fixture()

      {:ok, article} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Enum.into(%{user_id: user.id})
        |> Blog.create_article()

      article
    end

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Blog.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Blog.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      user = user_fixture()

      assert {:ok, %Article{} = article} =
               Blog.create_article(Map.merge(@valid_attrs, %{user_id: user.id}))

      assert article.body == "some body"
      assert article.tags == []
      assert article.title == "some title"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      assert {:ok, %Article{} = article} = Blog.update_article(article, @update_attrs)
      assert article.body == "some updated body"
      assert article.tags == []
      assert article.title == "some updated title"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_article(article, @invalid_attrs)
      assert article == Blog.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Blog.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Blog.change_article(article)
    end
  end
end
