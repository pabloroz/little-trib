class Guests < Cuba
  define do
    on root do
      res.write view("home", title: "My Site Home")
    end
  end
end