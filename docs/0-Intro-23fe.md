# CHIP 10.5: Agile Iterations

Welcome to CHIP 10.5!

The goal of this assignment is to experience a small-scale version of real agile software development as it is typically practiced in industry. In particular:

* You will work in small teams of 3-4 (rather than alone or just in pairs).

* Your team will work on an existing codebase (rather than creating a new app from scratch).

* You will use the same tools to track tasks/issues, do automated testing at checkin (continuous integration), measure code coverage and quality, and deploy to the cloud as most professional software engineering teams do.

* The unit of work will be the user story; the unit of measuring project time will be the iteration; your team's planning will involve delivering one or more stories by the end of each iteration.

In this multi-part assignment you will do some prep work followed by two iterations.

**In Iteration 0 (prep work)** you will get the existing app running in each developer's environment and set up the infrastructure for team development (repos, deployment, CI, and so on). The existing codebase is a nontrivial full-stack app called ActionMaps that lets users learn more about their elected and appointed government representatives, learn about political events in their local area, and aggregate, share and view news items in their local area.

**In Iteration 1,** all teams will add the same basic subset of features to the app, using the agile/XP workflow based on user stories, BDD/TDD, and lo-fi mockups. You will continue to improve test coverage and code quality in a 'legacy' code base.

**In Iteration 2,** each team will select a set of additional features to implement.

**NOTE.** It is very hard for us to prove that you followed BDD/TDD and the agile/XP workflow in developing the app. However, if you try to code the way you always have, we guarantee two bad things will happen. First, you will run into trouble when you try to coordinate the results of teamwork by merging code. Second, you will completely miss the experience of how software is developed in real agile teams, which is largely the point of the class, and you won't be in a great position during interviews to talk about your views on agile. In working on this assignment, _the process is as important as the end product._

## The App and the Project

A major difference between this project and earlier CHIPS is that there will be very little hand-holding. We’ll start you off with some legacy code, which will be a basic Rails app with a few models already implemented. The app uses an external API (Google Civic Information), JavaScript code to render the maps, and an asset pipeline (Webpacker) that manages all the front-end files.

Another important part: testing! Throughout this whole project, you’ll be expected to add tests where you see fit, leveraging both BDD with Cucumber and Capybara, as well as TDD with RSpec. When it comes to stubbing external APIs (a big portion of this project), we’ll give you some extra tips on how to do so.

Navigate to the next page to get started with Iteration 0 and setup!
