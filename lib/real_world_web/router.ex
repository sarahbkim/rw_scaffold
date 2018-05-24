defmodule RealWorldWeb.Router do
  use RealWorldWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug(:accepts, ["json"])

    plug(
      Guardian.Plug.Pipeline,
      error_handler: RealWorldWeb.SessionController,
      module: RealWorldWeb.Guardian
    )

    plug(Guardian.Plug.VerifyHeader, realm: "Token")
    plug(Guardian.Plug.LoadResource, allow_blank: true)
  end

  scope "/", RealWorldWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", RealWorldWeb do
    pipe_through(:api)

    get("/user", UserController, :current_user)
    put("/user", UserController, :update)
    post("/users", UserController, :create)
    post("/users/login", SessionController, :create)
  end
end
