# POPMENU TEST

This is a simple Rails API as part of popmenu test

## Tech and Versions
- Ruby 3.3.4
- Rails 7.2.1
- Sqlite 3
- Docker 27

## Testing
I decided to use rspec as test framework because I'm more familiar with it and I also think it's a bit easear to read the specs (probably because I have more experience with haha)

## Project Setup
**OBS: You'll need to have installed on your machine `Ruby 3.3.4` and `SQlite3`**

### Steps:
1. Clone this repo to your machine
2. Inside the project folder execute `bin/setup` into your terminal

### Running the Convertion Tool:
You will need to copy the path of where is your file located on your computer and than just run the following command on your terminal:

*obs: replace the **<< file_path >>** with your file_path*

> rails 'data:import_restaurants_data[<< file_path >>]'

## Thinking out loud
Here I'll explain why I decided to do one thing or other when doing some progress on the test

- Decided to use the `active_model_serializers` to serializer the models to be rendered as json on responses because in the benchmarks it seems to be faster and I think it's more easy to read the code than look for the jbuilder files (personal opnion here)

- To return `menu_items` data of specific `menu` I had few options but I decided to create a new controller which will force the usage of the `menu_id` param and all the `menu_items` data will be scoped by `menu`. The other option would be use a single controller and add few `if` statements to check if `menu_id` param is present and use that to do the query. To mantain the code cleaner I decided to create the new controller and it's also better for maintainability.

- With the introduction of the relationship between `restaurant` and `menu` I had few things to consider:
  - If this project was in production my migration shouldn't force the `restaurant_id`, since it would break the migration when run on a DB that already has data on it. And on this same thought it would be required to create a task which would migrate all `menus` without `restaurant`, and later on run a new migration to make the `restaurant_id` required.
    - So since it's only in dev mode I decided to keep it more simple, otherwise I would have to create at least two new files that wouldn't be necessary in dev mode.
  - Since the restaurant must exist to create menus it break existent `MenusController`, so I had to adjust a little bit to make it work, but will create a new controller to be scoped by restaurant as I did for `menu_items` in next commit.

- The uniqueness name validation for `menu_item` could be scoped by `restaurant_id` but it would add more complexity right now, I'll focus on get the basics requirements working and later on I can may get back here and try to improve things.

- I decided to use the `has_and_belongs_to_many` association to make the relationship between `menus` and `menu_items` for few reasons:
  - It's simplier, and later on if we need to have more control or to do something with the join table we can easialy change the code to use a new model and make the usage of the `has_many through`.
  - I always try to start with the simplier solutions first and if needed I can refactor for something more robust when needed.

- I decided to create the `import` model and using the `active_storage` to store the files sent through `/api/imports` endpoint so this way we can process them in better way later.

- I decided to use the `actor` gem to create the services classes which will be responsible to convert the JSON file into the active_record objects that we need.
  - Using this pattern we can easily split our logic in multiple services and will be more easy to maintain and add more functionality as we need.

- Ok, this is interesting, when working on the `ImportMenuItemsService` I took a good look about how the `menu_items` data can be passed through the JSON file, and realized that I'll need to do some refactoring in the `MenuItem` model/table and here is my thoughs on the refactoring I need to make:
  - A `menu_item` should `belongs_to` a `restaurant`
  - I need to create a new model to make the many to many relationship between menus and menu_items, this way I can move the `price` column to this new model, so a `menu_item` will be able to have different prices (this will be like a `menu_item_variant` which each variant will have it's own different properties while being maped to the same `menu_item`)

- Introduced the builders folder, so I realize that having a class to build the data the way we want using the active_model validators can be good, so deicided to implement this builder, honestly I'm not so super happy with the way the code is but it's working for now haha.

- I have removed the create/update/destroy actions from the `menus/menu_items_controller` few commits earlier, planning to get back to there later.

- I'm not liking to much the approach of being interating through the arrays and doing to much queries, I think I'll refactor the code to use something like `insert_all` to create data in db and use more the `where` clause to retrieve data, this way we can have faster queries. But will take a better look later on, will focus on have everything in place for now.

- Introducing the `ImportDataJob`, so I realized that when we upload the JSON data through the endpoint will be a lot better to process it async, so I'm calling the `ImportDataJob.perform_later` in the `after_commit` callback in the `import` model, so this way everytime an `import` model/record gets created successfully this job will be enqueed to be processed async, and will convert all the data in a good way.
