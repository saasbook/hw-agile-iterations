# Milestone 1: Implement a couple of new features

## App Overview

ActionMap's goal is to be an integrated, seamless, and shareable platform that makes it easier for voters to connect with their political community while at the same time enabling organizations, candidates, and elected leaders to reach new voters and community members. The idea behind the application is to allow the user to visualize the political environment within all levels of government while also providing a platform to contact and voice their opinions to the decision makers within politics. This happens through attending events in their community, and sharing news articles related to a particular candidate and sharing their opinion. By asking the user to provide a news article before giving the candidate a score on a particular issue, it adds a layer of reputability to the score. Users can discover candidates by clicking on a map location, or searching for their local address.

## Understanding the code base

To render the maps, this project uses a combination of JavaScript and [Topojson](https://github.com/topojson/topojson-specification), a compact alternative to [GeoJSON](https://tools.ietf.org/html/rfc7946). These file formats are both used to represent simple geographical features.

You will find prebuilt Topojson files in `assets/topojson`, but we need the JavaScript `d3.js` library to render the maps as SVG images. This library is fetched using `npm` from `npmjs.com`, the package manager for JavaScript code. In addition, we use the `jsbundling-rails` gem (which wraps the Webpack front-end build tool) to compile JavaScript its dependencies. You will find the compiled JavaScript that renders the browser in `app/assets/builds/`. Why do we 'compile' our JavaScript code? This helps us create modular files which are less likely to have dependency conflicts. Combining dependencies into fewer total files also helps us manage the total number of individual requests made to load a page, which improves performance.

We also use JQuery to listen and react to DOM events eg. when a form value changes. Open the `/events` path on your browser and assess how the `Filter By` form works. What JavaScript file handles the changes in the form?

## Intended User Experience

A user can search for candidates in one of two ways:

* **Entering their address into the search field** -OR-

* **Clicking on a state in the US Map**.
 * When a state is clicked, it will redirect the user to that state's map, on which the state's counties will be selectable. When a county is selected, the app _should_ populate the table below with that county's candidates.

Once on a particular place’s representatives list, a user can view any one representative's associated news articles, add their own, and score it.

## Iteration 1, Part 1: Representatives - Fix Legacy Code

The Representatives model is the first thing we’ll be working on as part of this app. It has some basic functionality.

Let’s take a look at what’s already there:

We have a `representative` resource with basic views, model, and controller. The model includes the representative name, Open Civic Data ID (OCD ID), office/title, and a has-many association to `news_items`.

We also provide RepresentativesController and SearchController. The SearchController handles calling the Geocodio API. Below is the schema for `representative` model.

| Column Name | Notes |
| ----------- | ----- |
| name | representative name |
| ocdid | a standard identifier used with GeoCodio, Google Civic APIs, etc. |
| title | e.g. 'represenative', 'senator', etc. |
| created_at | standard attributes |
| updated_at | standard attributes |

_OCDID_ is an ['Open Civic Division ID'](https://github.com/opencivicdata/ocd-division-ids). This id allows us to uniquely identify representatives even if they have similar names or positions.

**TASK 1.1**: Refactoring Legacy Code

* There is currently an issue with the way the `civic_api_to_representative_params` method in the `Representative` model is implemented.
 * Explore the code further to understand the functionality surrounding the method, and build and understanding as to what the error may be. **HINT:** What happens if the method is called for a given representative who _already exists_ in the database?
 * Write a characterization test to encapsulate your understanding, and modify the code to allow the test to pass. (Remember Red->Green->Refactor; your test should fail before you implement a fix).
 * Consider what unique ids are returned from the API that will help us with avoiding duplicate data?

After completing this step, you may want to purge and re-initialize your database (why?), both locally and on Heroku.

Here's a recommended set of actions, but you should make sure you understand what each line does before continuing.

What does `db:prepare` do? Consult the [Rails docs][db_prepare].
[db_prepare]: https://guides.rubyonrails.org/active_record_migrations.html#setting-up-the-database

```bash
bundle exec rails db:drop
bundle exec rails db:prepare
```

On Heroku, you may find it easier to simply replace your database instance. Heroku and Rails make it difficult to `drop` an active production database, and for good reason!

**Be sure to communicate with your team before making disruptive data changes on Heroku.**

```bash
heroku addons:destroy heroku-postgresql -a <YOUR_APP_NAME>
heroku addons:create heroku-postgresql -a <YOUR_APP_NAME>
heroku run rails db:prepare
```

## Iteration 1, Part 2: Representative's Profile Page

The current Representatives model only includes their name, OCD ID, and title. We want it to show a lot more, including contact address (as a single column), political party, and a photo, as well as a website. This info should be viewable on the representative's profile page, which you should create as the `views/representatives/show.html.erb` (or `.html.haml` if you prefer) view, which you will create. This information will come from the Geocodio API. See the Representatives controller and model for a basic implementation of getting some fields.

The profile page should be linked from `views/representatives/search.html.haml`, as well as anywhere the representative name appears in `views/news_items`, or via the the Counties page which you need to address in the next part.

Note that you'll need a migration to store the new Representative information.

At the end of this task, your Representative model should have the following columns:

| Column Name | Notes |
| ----------- | ----- |
| addrress | one line for their entire address |
| photo_url | a profile picture returned by Geocodio |
| website_url | their congressional website URL |
| phone_number | congressional office number, from Geocodio |
| party | e.g. 'democrat' or 'republican', but there are others. |

**TASK 1.2**: Create and add a profile page for a representative, as described above. You can use [Bootstrap v5.3][bootstrap53] for basic styling, but the _functionality_ is the most important thing. (This is already setup in the `app/assets/stylesheets` directory.)

[bootstrap53]: https://getbootstrap.com/docs/5.3/getting-started/introduction/

* **Testing**: Refer to ESaaS Chapter 8 Section 4 (Stubbing the Internet) to add RSpec tests and/or Cucumber scenarios that increase coverage for this portion of the app.

## Iteration 1, Part 3: The Counties Map

For this part, you should explore the interconnectivity between the various controllers, models, and views that allow the app to search the Geocodio API. Starting in `views/representatives/index.html.haml`, trace the search code all the way to `views/representatives/search.html.haml`. You may refer back to the previous page to see how the map works in JavaScript.

Understanding this will make the next task much easier.

The map is broken! You can click on a state, and it’ll show you a list of counties, but clicking on a county takes you to a search page. And then, there's no obvious way to get back to the previous state. We think the 'county' view should be a lot more useful.

- Clicking on a county should show you the map, which it does.
- [ ] When on the state page, clicking on a county should take you to the _county show route_ for that state, not the search page.
- [ ] Below the map, it should show the list of representatives for that county.
- [ ] Include a link when on a county page that links back to the state. e.g. when viewing 'Alameda County', there should be a link somewhere near the top of the map which takes you back to the 'California' map page. You can figure out how to make this look best.

This doesn’t require a lot of code changes, but does require you to use a mix of your basic JavaScript knowledge and creativity. You'll need to make some small fixes to the JavaScript, but more importantly, you'll need

Ensure you are also writing proper tests in Cucumber and Rspec for map actions. We've provided some scaffolded steps.

**TASK 1.3**: Make the Map Functional!

## Iteration 1, Part 4: Validating Accessibility

Web accessibility ensures all users, including those with disabilities, can effectively use your application. This includes users with visual, motor, hearing, or cognitive impairments who may rely on screen readers, keyboard navigation, or other assistive technologies. Of course, it's also a legal requirement and we'd really rather not be on the losing end of lawsuits.

### Testing with Axe

This project uses [axe-core](https://github.com/dequelabs/axe-core) for automated accessibility testing. The `be axe clean` step in Cucumber verifies that the current page meets WCAG 2.0 Level A and AA standards by checking for common accessibility issues like missing alt text, improper heading structure, and insufficient color contrast.

**TASK 1.4**: Add accessibility tests for at least two different routes:

The two routes must be different, i.e. testing both "CA" and "TX" would not really improve the robustness of our app.

1. Open `features/accessibility.feature` and add scenarios for **two** critical user paths. For example:

```cucumber
Scenario: State map page is accessible
  Given I am on the state map page for "CA"
  Then the page should be axe clean
```

You may pick any two routes you wish. In iteration 2, you'll need to add an additional 2 routes to this file. (These tests will also help contribute to your overall test coverage.)

When we run the step `Then the page should be axe clean`, we audit the HTML of whatever is currently in view in the browser. In this case, consider what happens if expand (or hide) the counties table on the state page. You might get different results!


2. Run the accessibility tests:
```bash
bundle exec cucumber -p a11y
```

3. Fix any violations reported by axe. Common issues include:
  - Missing form labels
  - Images without alt text
  - Insufficient color contrast
  - Missing page landmarks

### Additional Resources
- [axe DevTools Chrome Extension](https://chrome.google.com/webstore/detail/axe-devtools-web-accessib/lhdoppojpmngadmnindnejefpokejbdd) - Manual testing during development
- [WebAIM Guidelines](https://webaim.org/) - Comprehensive accessibility documentation

## Iteration 1, Part 5: Improving Coverage


**TASK 1.5**: Ensure test coverage exceed 50% across all files in the `app/` directory.
The started code should have come with around 20% test coverage. Depending on how much code you'd added, you should be well on your way to dramatically improving test coverage.

You can use `simplecov` locally to see your coverage. SimpleCov is already enabled in the project for RSpec and Cucumber tests, but you need to instruct SimpleCov to ignore the `lib/` folder, which contains library code that isn't your responsibility to cover.

In `features/support/env.rb` and `spec/rails_helper.rb`, change:

```ruby
SimpleCov.start 'rails'
```

to:

```ruby
SimpleCov.start 'rails' do
  add_filter 'lib'
end
```

Then run all your RSpec and Cucumber tests:

```
bundle exec rspec
bundle exec cucumber
bundle exec cucumber -p a11y
```

Finally, open `coverage/index.html` and look for the percentage next to "All Files".


## Iteration 1 Deliverables

Woo! You made it, hope you are enjoying the ride so far. Please check your course's webpage for information on your deliverables.

For each iteration you should have:

* Held a team planning meeting
* Completed the feature work via pull-requests and paired programming
* Held a team retrospective meeting
* Made a team (code) submission
* Made (individual) peer reviews
