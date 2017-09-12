defmodule GardenTogetherWeb.Router do
  use GardenTogetherWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug GardenTogetherWeb.CurrentUser
  end

  scope "/", GardenTogetherWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/home", PageController, :home

    get "/register", RegistrationController, :new # name of this file is not significant only templates match on name
    post "/register", RegistrationController, :create

    delete "/logout", SessionController, :delete
    get "/login", SessionController, :new
    post "/login", SessionController, :create

    resources "/gardens", GardenController
  end

  # Other scopes may use custom stacks.
  # scope "/api", GardenTogetherWeb do
  #   pipe_through :api
  # end
end
