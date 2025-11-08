## Iteration 1: General Instructions

The project will be completed in 2 iterations, following the Agile/XP methodology. Iteration 0 was the setup; the remaining 2 iterations are for doing the actual code and tests!

Both iterations will follow the same general structure:

1. Have a detailed _pre-iteration planning meeting_ to discuss the work with the team and break it up into stories

2. Create an Issue corresponding to each story and assign developer(s)

3. Developer(s) use BDD and TDD to create tests and code for the story, doing Pull Requests when the feature is believed complete; others review the PRs and eventually decide to Merge and then close the Issue.

4. App is constantly pushed to Heroku to make sure everything still works in production

5. At end of iteration, the team as a whole submits a _retro_ (retrospective survey), and each developer submits a confidential _peer evaluation survey_ and _self-assessment survey_. The grading of the code and tests is based on your deployed Heroku app and the contents of the team repo.

The rest of this guide details each of the above steps; the next guide lays out the feature tasks for Iteration 1. **Please read this guide and the following page completely before going on.**

## Pre-iteration Planning

For each iteration we'll give you high-level descriptions of what to do. You should think of the project spec as notes from a customer who knows _what_ feature they want but not _how_ to implement it. You should make lo-fi mockups if needed in order to create user stories from the spec.

Your team should have an iteration planning meeting (IPM) to discuss the stories. **A key goal of this meeting is to break down the stories into smaller ones until each story is something that can be finished by one person or a pair of people within about 1 day's work.**  In a full XP workflow, the IPM would include assigning points to stories; in our simplified version we're essentially recommending you make all the stories 1-point stories.

A good rule of thumb is that if a developer or pair can generally describe in plain language what would have to be done to implement a story (e.g. "I need to add a route, a controller action, a view, and a few lines of logic in the model"), it's more likely to be a 1-point story.  If you're not sure what needs to be done, you may need to get more specific, or break the story down into smaller chunks until each chunk is concrete enough that you can describe the tasks needed at a high but specific level.

**The planning step is extremely important.** If you can't get to specifics at the time you're assigning a 1-point story, chances are you won't be able to get to specifics when you sit down to code either.  This "translation" step has to happen at some point, so why not do it when the whole team is available to discuss and help?

You will report on how this meeting went using the checklist assignment found on Gradescope (and linked in the next page of this guide).

## Create Issues for the stories

Each 1-point story should be entered as a GitHub Issue. Label each issue with "iter1" or "iter2" depending on which project iteration it is for.

When a developer or pair claims an issue to work on:

1. Add the label "started" to the issue, so others know the story is in progress

2. [Assign the issue](https://docs.github.com/en/issues/tracking-your-work-with-issues/assigning-issues-and-pull-requests-to-other-github-users) so everyone knows who is working on what.

3. Use branch-per-feature (book section 10.2) to manage your work: [create a branch that is linked to the corresponding issue](https://docs.github.com/en/issues/tracking-your-work-with-issues/creating-a-branch-for-an-issue) and do your work there.

4. Either create a new Cucumber feature file, or if appropriate, add a scenario in an existing file, for the issue you're working on. You should write out all scenarios for that user story as we have done in class. Also write draft step definitions for all of the new steps that you are using, even if they are just placeholders for now. If you’re updating an existing feature, you can just edit the feature file(s) for that feature.

5. Use BDD to develop the feature, as in CHIPS 7.7.

6. When committing, specify the commit type (from [this list](https://github.com/commitizen/conventional-commit-types/blob/master/index.json)) at the beginning of the commit message with "[]". For example, a commit message will look like "[feat] A new feature that....(description here)".

7. Create a Pull Request to the master branch when a feature is finished. You can use rebase to resolve conflicts on your branch. **Remember** that a finished story means _both tests and code_: a commit or PR should never cause net test coverage to decrease. Comments & discussion as part of the PR form an integral part of keeping everyone on the team apprised of what's happening.

### Setting Up a GitHub Project Board

GitHub has a feature called "Project Boards", which work a lot like Pivotal Tracker and similar kanban style tools.

1. Navigate to your repo on GitHub and find the link which says "Projects".
2. Click the **dropdown** in the big green button, choosing "New Project". **Do not** click "Link a Project" directly (this will take ownership over the template!)
3. You should make a project from a _template_, in the column on the left. This includes all the automation to move stories to the right state as you open and close PRs. Select "[TEMPLATE] 10.5 Backlog Template" as the template to use.
4. Give your project board an appropriate name, like "Team <XX> CHIPS 10.5 Project"

## Standups

**In every offering of this course we have taught,** the major student feedback on lessons learned from the group project was "I wish our team had communicated more frequently and more regularly."

Our recommended workflow: every day (or as close to every day as possible), meet with your teammates as a group in a simple video call for just a few minutes. The meeting can follow this simple script, where each developer takes turns answering the questions:

* What have you worked on/finished since our last standup?
* What are you planning to work on today?
* Have you encountered any problems that others on the team could help with, or learned anything interesting that others might benefit from?

You don't need to submit evidence of this meeting, but we _promise_ your dev process will be _much smoother_ if you actually take advantage of team knowledge with frequent-but-short meetings rather than trying to meet once for a long time during the iteration.

## End of Each Iteration: Deliverables

1. `Retrospective survey` (1 per team): Comparing your planned iteration work with the stories actually Finished or Delivered, what could your team have done better?


2. `Peer evaluation survey` (each developer submits): We will ask you to evaluate the overall contributions of each team member during the iteration—exceeds expectations, meets expectations, somewhat/barely meet expectations, or fall short of expectations. (Consider a variety of factors: did this person communicate with rest of team effectively?  Did they try to do their share of the work? Were they prepared to work on the project, that is, did they seem to have command of the material covered in the homework?) These surveys are confidential to instructors only. We use this information to help with project grading, so please be honest and fair!

3. `Code and tests`

    * Your TAs will evaluate your project by interacting with the features for Delivered stories (on the deployed Heroku app) and inspect code, tests, etc. for Finished stories. The goal is to be able to _Deliver_ all the stories you planned, but the goal is not to punish your team for failing to do so but rather to help your team understand what could have gone better so that next iteration will go more smoothly.
    * Your code coverage is 50% or higher (for app/ folder). For Iteration 1 you will need 45% coverage and by Iteration 2 you should have 50% or higher code coverage.

Your TAs may apply grade adjustments based on the quality of your stories, interaction within team, GitHub Pull Requests, and so on. Remember, that the goal is a healthy development process and team communication.

**Next, continue with Iteration 1 specs and deliverables.**
