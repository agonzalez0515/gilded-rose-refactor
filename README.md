# Gilded Rose Refactor

Used Ruby starter from https://github.com/emilybache/GildedRose-Refactoring-Kata

To run locally:
1. Clone this repo.
2. Run `bundle install`
3. Run `bundle exec rspec spec/gilded_rose_spec.rb --format documentation` for tests
4. To view coverage report, open `index.html` file in `coverage` folder in a browser


## Changelog
* 9/3/19 - Add tests

    I reorganized the files to follow a more conventional structure. I added Rspec for my tests and used Rspec Guard to watch the files. I also added SimpleCov for coverage reports. 

* 9/4/19 - First refactoring iteration

    My main goal in the first iteration was to remove as much logic out of update_quantity as possible and remove a lot of the nesting. I decided to make as many singular responsibility methods as possible to handle the increasing and decreasing of values. I used a case statement to handle the flow based off the item name. 

* 9/5/19 - Second refactoring iteration

    I watched the Sandi Metz refactoring video to get an idea on how else to keep refactoring. I knew I had too much repetition with the `increase_item_quality` method, but I could not figure out how to abstract it. After watching her video, I realized I was thinking more in terms of functionality, and not in objects. I then refactored each specific object to be a subclass of Item, each one being responsible for updating its own values. This way the object can be used anywhere else, and the methods to update itself are not tied to the Gilded Rose class. This still violates the Open/Closed principle because in order to add a new special item, the code needs to be modified. My next step is to refactor so that it implements this principle.

