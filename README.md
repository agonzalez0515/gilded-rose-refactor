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

* 9/5/19 - Second iteration

    I watched the Sandi Metz refactoring video to get an idea on how else to keep refactoring. I knew I had too much repetition with the `increase_item_quality` method, but I could not figure out how to abstract it. After watching her video, I realized I was thinking more in terms of functionality, and not in objects. I then refactored each specific object to be a subclass of Item, each one being responsible for updating its own values. This way the object can be used anywhere else, and the methods to update itself are not tied to the Gilded Rose class. This still violates the Open/Closed principle because in order to add a new special item, the code needs to be modified. My next step is to refactor so that it implements this principle.

* 9/19/19 - Third iteration
    I created constants for each of the item names. This reduces the chance of a spelling mistake and concentrates all the strings in one spot, making it clearer where to add/change items. 
    
    I wasn't happy with the case statement because it required the method to be modified if a a new item was added or one was removed. Instead I created a hash called Special Items to hold all of the items that require special modification, and used a symbol to reference the class needed for each item. When a new item needs to be sold, only this hash needs to be extended.

    I also ended up creating a class for the Sulfuras item even though it doesn't do anything. This way if the client decides they want it to do something in the future, we don't have to modify the gilded rose methods, we can change the update method for the Sulfuras class. It also made sense to me that it should be its own object to follow the convention I set for special items. It is still a special item, it just doesn't do anything yet. Instead of inheriting the parent's `update` method which does nothing, I overrode it with a `return`. In case the `Item` `update` method changes in the future, I don't want Sulfurus to inherit it accidentally. It also feels more explicit to me. 