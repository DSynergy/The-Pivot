
item_contents = ([{ name: "Chocolate Toast", description: "Dark chocolate on toast",
        price: 3.00, retired: true}, { name: "Cake Toast", description: "Lemon poppyseed cake on toast", price: 4.00},
        { name: "Brownie Toast", description: "Delicious dark chocolate brownie on toast", price: 4.00},
        { name: "Cinnamon Sugar Toast", description: "Toast sprinkled with raw cane sugar, fresh ground
        cinnamon, and a hint of sea salt", price: 2.50}, { name: "Avocado Toast", description: "Fresh
        California avacado sliced over toast", price: 5.00}, { name: "Egg Toast", description: "Choose
        from fried or scrambled eggs!", price: 4.00}, { name: "Dry Toast", description: "Nothing on it",
        price: 2.00}, { name: "Tuna Salad Toast", description: "With pickles,onions, and a hint of basil",
        price: 4.50}, { name: "Buttered Toast", description: "Creamy melted butter", price:
        5.00}, { name: "Mac and Cheese Toast", description: "Rich, three cheese mac and cheese, on toast",
        price: 4.50}, { name: "Salad Toast", description: "House salad on toast", price: 4.00}, { name:
        "Peanut Butter Toast", description: "Fresh ground peanut butter", price: 7.00}, { name:
        "Sausage Toast", description: "German style brat on toast", price: 6.00}, { name: "Jam Toast",
        description: "Strawberry, or blueberry", price: 5.50}, { name: "Chicken Toast", description: "Fried
        or grilled!", price: 8.00}, { name: "Eggplant Toast", description: "Roasted Eggplant on toast",
        price: 5.00}, { name: "Curry Toast", description: "Spicy and delicious", price: 8.00}, { name:
        "Steak Toast", description: "Flank Steak", price: 7.50}, { name: "Tofu Toast", description:
        "Marinated tofu", price: 4.00}, { name: "Salmon Toast", description: "Alaskan made!", price:
        8.00}, { name: "Cheese Toast", description: "melty sharp cheddar", price: 3.00}])

item_contents.each { |content| Item.create(content) }

category_contents = ([{ name: "Side dishes"}, { name: "Small plates" }, { name: "Desserts"}, { name: "Main Courses"},
              { name: "Specials" }])

category_contents.each { |content| Category.create(content) }

#ItemCategories

item_contents.each_with_index do |item, index|
  if index < 7
  Item.find_by(name: item[:name]).categories.push(Category.first)
  elsif index < 13
    Item.find_by(name: item[:name]).categories.push(Category.second).push(Category.fifth)
  else
    Item.find_by(name: item[:name]).categories.push(Category.third).push(Category.fourth)
  end
end

user_content = ([{ username: "Rachel Warbelow", email_address: "rachel@jumpstartlab.com", password: "password", display_name:nil,
        role: 0}, { username: "Jeff Casimir", email_address: "jeff@jumpstartlab.com", password: "password", display_name:
        "j3", role: 0}, { username: "Jorge Tellez", email_address: "jorge@jumpstartlab.com", password: "password",
        display_name: "novohispano", role: 0}, { username: "Josh Cheek", email_address: "josh@jumpstartlab.com", password:
        "password", display_name: "josh", role: 1}])

users = user_content.map { |content| User.create(content) }

users.first.orders.create(status:0, cart: {"1"=>3, "4"=>1, "9"=>2})

2.times do
  users[2].orders.create(status:1, cart: {"1"=>1, "10"=>1})
end

5.times do
  users[1].orders.create(status:1, cart: {"2"=>1})
end

users.last.orders.create(status:2, cart: {"15"=>3})
