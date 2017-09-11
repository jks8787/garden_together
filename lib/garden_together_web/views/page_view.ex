defmodule GardenTogetherWeb.PageView do
  use GardenTogetherWeb, :view

  # this will always override any page template
  def render("home.html", _) do
    ~E"<h1>GardenTogether</h1><h2>a garden collaboration app</h2>" # ~E allows html to be rendered
  end
end
