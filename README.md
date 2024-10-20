# POPMENU TEST

This is a simple Rails API as part of popmenu test

## Tech and Versions
- Ruby 3.3.4
- Rails 7.2.1
- Sqlite 3
- Docker 27


## Testing
I decided to use rspec as test framework because I'm more familiar with it and I also think it's a bit easear to read the specs (probably because I have more experience with haha)

## Thinking out loud
Here I'll explain why I decided to do one thing or other when doing some progress on the test

- Decided to use the `active_model_serializers` to serializer the models to be rendered as json on responses because in the benchmarks it seems to be faster and I think it's more easy to read the code than look for the jbuilder files (personal opnion here)

- To return `menu_items` data of specific `menu` I had few options but I decided to create a new controller which will force the usage of the `menu_id` param and all the `menu_items` data will be scoped by `menu`. The other option would be use a single controller and add few `if` statements to check if `menu_id` param is present and use that to do the query. To mantain the code cleaner I decided to create the new controller and it's also better for maintainability.

