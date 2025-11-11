# Iteration 0—Getting Started: Team Setup

This part of the setup mostly involves actions that occur on either the team's shared repo or the team's Heroku deployment stack:

1. Set up credentials management for API keys used by the app
2. Verify CI is working and is able to access all needed secrets/credentials
3. Setup Issue Tracking on the team repo to keep track of who on the team is doing what

## Pre-Plan Your Team Work

Before you rush through the setup, there are some steps which can (or must) be done individually, and others which are best done by assigning one or two people on a team to take them on. Always cooridinate with your team so you know the status of your project.

## Credentials (and Secrets) Management

Credentials are things your app needs to run but need to be kept private, even if your app code is open source. A common example is an API key used to access an external service, or a passphrase necessary to establish a database connection. Collectively, these kinds of information are sometimes called "secrets". Secrets are tricky to manage for several reasons:

* You often want to safely store them/version them, but it has to be done in a way that keeps them safe from prying eyes, perhaps by encrypting them at rest

* The secrets need to be shared with all developers and (usually) the CI system and the production system, again while keeping them secret

Rails provides us two ways of managing our secrets.

### Encrypted Credientials (Option 1)

Some frameworks and web services (e.g. GitHub) provide support for managing certain types of secrets. Rails 5 provides a built-in mechanism, `config/credentials.yml.enc`. This file contains all the secrets needed by the app, but it is stored as an encrypted file; the decryption key is then managed as a single "master key" by adding it to GitHub (for CI) and to Heroku (for production).

**These steps should be done on one copy of the repo, then the results pushed and everyone else pull.**

Start by deleting the current `config/credentials.yml.enc`, if one exists, since we're about to replace it by generating a new "master key" and a new credentials file:

```shell
EDITOR=vim bundle exec rails credentials:edit

# If working locally and you have VSCode:
EDITOR='code --wait' bundle exec rails credentials:edit
```

(If you don't like `vim`, substitute your favorite editor, such as `nano`. Using `nano` on Codio can be tricky, because the Ctrl+O shortcut to save the file is captured by Codio; try Ctrl+X to close the editor and answering `Y` when prompted.) [Save the file and exit vim](https://www.google.com/search?q=how+to+save+and+exit+vim).

This creates a new encryption key stored in the file `master.key` and a new credentials file.

**Important idea:**
The master key file will not be versioned, but every "entity" that wants to run the app--each developer, the CI tests, Heroku--needs access to its contents. Thus, each developer should locally store _(but not version)_ a copy of this file, and we will store the file's contents as an environment variable in both GitHub and Heroku.

Later, we will add more credentials to `credentials.yml` for Google OAuth, Google Civic API and Github OAuth. For now, look at the value of `secret_key_base` in the file. You should be able to open a Rails console ( `bundle exec rails c`) and verify that the app can "see" this value:

 ```ruby
 Rails.application.credentials[:secret_key_base]
 ```

`Rails.application.credentials.dig` reads credentials from `config/credentials.yml.enc` by decrypting it with `config/master.key`. You could specify environment specific groups as follows in config/credentials.yml.enc:

```yaml
production:
    GOOGLE_CLIENT_ID: xxxx
    GOOGLE_CLIENT_SECRET: xxx

development:
    GOOGLE_CLIENT_ID: xxx
    GOOGLE_CLIENT_SECRET: xxx
```

Then use the following syntax to read keys for specific environment:

```ruby
Rails.application.credentials.dig(:production, :GOOGLE_CLIENT_ID)
Rails.application.credentials.dig(:development, :GOOGLE_CLIENT_ID)
```

(This step did not require you to change any files. It's simply an introduction of how to use credentials in Rails.)

---

### Managing `.env` files

An alternative to Rails' encrypted credentials is using `.env` files. When using foreman (which you're already using with bin/dev), environment variables are automatically loaded from `.env` files.

Create a .env file in your project root:

```
touch .env
```

Verify that `.env` is already in your `.gitignore` file.

```
grep '.env' .gitignore
```

Sample .env file:

```.env
# OAuth Credentials
GOOGLE_CLIENT_ID=your-google-client-id-here
GOOGLE_CLIENT_SECRET=your-google-client-secret-here
GITHUB_CLIENT_ID=your-github-client-id-here
GITHUB_CLIENT_SECRET=your-github-client-secret-here

# API Keys
GEOCODIO_API_KEY=your-api-key-here

# Rails Secret Key Base (optional, Rails generates one)
SECRET_KEY_BASE=your-very-long-secret-key-here
```

Access these in your Rails app:

```rb
ENV('GOOGLE_CLIENT_ID', 'default_value')
ENV('GOOGLE_CLIENT_SECRET', 'default_value')
```

`.env` files are very simple to use and edit. However, because they are not committed they require coorindation amongst your team and you deployment environment.

Your team should pick __only one__ approach to managing secrets in your application.

## Heroku

Now we need to setup the app on Heroku and ensure that our credentials are available there. Again, this should be done by one person on behalf of the team.

If you're not using our prebuilt Codio stack, you'll need to install the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli).

1. The steps below should work even though you're reusing your team's Heroku app from earlier assignments. If you're having trouble, try force-pushing to the Heroku remote, deleting and re-adding your Postgres add-on manually, or, if all else fails, asking course staff to reset your Heroku application entirely.
2. Log in to Heroku CLI using `heroku login -i` using your API key as your password.
3. Run the following commands to connect your local repo to your heroku app, replacing `<xx>` with your team number:

```sh
heroku teams
heroku apps -t esaas # list the apps you have access to.
heroku apps:favorites:add -a fa25-team-<xx>
heroku git:remote -a fa25-team-<xx>
```

(If you've properly set the stack from an earlier assignment, you may not need to redo the last step.)

4. Heroku's stacks are called _buildpacks_, and since our app uses Node, we need to tell Heroku to use buildpacks containing both Node and Ruby:

```shell
heroku buildpacks:add heroku/nodejs
heroku buildpacks:add heroku/ruby
```

Confirm that you have both installed, and **make sure they are listed in the order mentioned above**:

```shell
heroku buildpacks
```

If the buildpacks are not in the right order (which may happen because a previous CHIP already added `heroku/ruby`), you can use `heroku buildpacks:remove` to remove a pack before adding it again.

5. Before you push to Heroku, make sure your changes get put on the main branch of your team's repo. Follow the `PR once you've finished your part (For future reference)` section on the previous page. Once your changes are merged into the main branch of your GitHub repo. Run the following commands to pull in the changes into your local/Codio main branch.

```
git checkout main
git pull origin main
```

6. You're now ready to push your . Note that `.gitignore` includes the master key file `config/master.key`, since that secret should **not** be checked in to version control. Instead we will make the secret available to Heroku in a separate manual step.

```shell
git push heroku main # you may need --force as well if this is the first push from your 10.5 repository
```

7. Next, setup the initial database on Heroku:

```shell
heroku run rails db:prepare
```

**NOTE:** If you have previously deployed a Rails app to this Heroku container, you will want to remove and recreate the debase.

```shell
# First, remove the current database
heroku addons:destroy heroku-postgresql

# Then add a new one
heroku addons:create heroku-postgresql
```

You should now be able to access your app using the _(appname)_`.herokuapp.com` that you set up in the previous step.


8. Run the following command to make `config/credentials.yml.enc` available on Heroku:

```shell
heroku config:set RAILS_MASTER_KEY="$(< config/master.key)"
```

This incantation echoes the contents of `config/master.key` in your local terminal and sets the Heroku environment variable `RAILS_MASTER_KEY` to that value.  (You could also do this by displaying the file contents in the terminal and using copy-paste to set the value of the variable in Heroku's "Application settings" for your app.) Rails can now use the value of that environment variable to decrypt the secrets file, but  the value cannot be "seen" outside the Rails app and is not stored in any file that ever makes its way to Heroku or GitHub. **Note the pattern here:** The file containing the API keys and other secrets is versioned, in encrypted form; the encryption/decryption _key_ is never saved anywhere as a file, but only made available as an environment variable. Later we will do the equivalent process to make the environment variable visible in GitHub for CI.

## Add GitHub, Google, and Geocodio API keys

Now you need to update the `credentials.yml.enc` using `EDITOR=vim bundle exec rails credentials:edit` because the app includes "login with your Google account" and "login with GitHub", both of which require API keys, and also uses the Google Civic Information API, which requires a different API key. (Again, only one person on the team should do this step, then they should check in the credentials file for everyone else to update from.)

1. Go to [console.developers.google.com](https://console.developers.google.com), create a new project, click on `Credentials`, then add new `OAuth 2.0 Client IDs` for a web application. Copy the `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` and add them to your `credentials.yml.enc`. Make sure to set your callback/redirect url on the Google Developer Console using your Heroku link, e.g. `https://your-heroku-1234.herokuapp.com/auth/google_oauth2/callback`.

2. Go to [github.com/settings](https://github.com/settings), then navigate to Developer Settings and click on `OAuth apps` and add a new `OAuth App`. Copy the `GITHUB_CLIENT_ID` and `GITHUB_CLIENT_SECRET` and add them to your `credentials.yml.enc`. As before, use your Heroku link for the callback URL, e.g. `https://your-heroku-1234.herokuapp.com/auth/github/callback`.

3. Get a [Geocodio][geocodi] API key. Create an account, then visit [the Geocodio API page][geocodio_api]. One person should create an API key and share it with the team.

Geocodio is a free service with a very easy JSON API for looking up representatives by a location. We've taken care of the main work of setting up the API, but you'll need to pass in a `GEOCODIO_API_KEY`. [Check out their documentation][geocodio_docs].

[geocodio]: https://dash.geocod.io
[geocodio_api]: https://dash.geocod.io/apikey
[geocodio_docs]: https://www.geocod.io/docs/#data-appends-fields

<!-- 3. Use this [guide to generate a Google Civic Info API key](https://developers.google.com/civic-information/docs/using_api).  Copy the key and add it as `GOOGLE_API_KEY`.  Your final `credentials.yml.enc` should include keys for `GITHUB_CLIENT_ID`, `GITHUB_CLIENT_SECRET`, `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET`, and `GOOGLE_API_KEY`, in addition to `secret_key_base` which is used by Rails itself to generate encrypted cookies.

4. Go to [the Civic Information API activation link](https://console.developers.google.com/apis/api/civicinfo.googleapis.com/overview?) to activate the Google Civic Information API for use with this project. -->

5. Commit and push your changes to GitHub and Heroku. At this point, you should be able to go to your Heroku app, and make sure that the app boots up GitHub or Google. You should also be able to go to the Representatives page and search for a location.

## CI: GitHub Actions

GitHub Actions are scripts that can be run each time code is pushed to GitHub. These scripts run in a virtual machine container, so they can install more or less whatever they need each time they are run. We will use GitHub Actions to run all of our app's tests on each code push.

Each step of an action can either be coded manually, or can reference an external already-published action, like a subroutine. The provided file `.github/workflows/specs.yml` contains a combination of these: it installs JavaScript, Node, Ruby and Rails; runs Bundler to install gems; and then runs all linters and all tests associated with the app. Note that each time a workflow runs, it is basically like starting with a "blank" machine image, though caching is used intelligently by particular action steps to avoid needless repeated work on each run.

The presence of this file in the repo is enough to trigger the workflows on each push. But, like Heroku, Rails will eventually need to access and decrypt `credentials.yml.enc`, so just like Heroku, we need to make the decryption key available to GitHub.  GitHub provides a mechanism called GitHub Secrets that allows setting environment variables visible to workflows; a key to this mechanism is that even if a repo is public, its secrets are always private.

So in your repo settings, add a GitHub app secret for `RAILS_MASTER_KEY` (you may find [this guide](https://docs.github.com/en/actions/security-guides/encrypted-secrets) useful) and set the value to the contents of your local `config/master.key`.  This will cause the value of the secret to be "visible" to GitHub Actions workflows as the environment variable `RAILS_MASTER_KEY`.

**CAUTION:**
If using copy-paste to copy the long contents of the key file, be careful not to accidentally include any extra spaces or newlines when pasting to GitHub.

You will then need to modify the `specs.yml` workflow to [reference the value of the `RAILS_MASTER_KEY` variable](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions) so that the CI workflow can successfully decrypt the credentials file and use the values therein.

### Test the GitHub Action

The GitHub workflow `specs.yml` will trigger automatically on each push, but you can also test it manually: navigate to your repo, click Actions, in the main repository navigation, click the workflow you want to run in the left sidebar (`specs.yml`), and then click Run Workflow.

You can add a GitHub Workflow badge to your repo's README to indicate whether the most recent CI run passed or failed, and what the code coverage is. To add the "workflow passing" badge, you can add the following code to put a dynamically generated badge file into your `README.md`:

<pre>
![](https://github.com/<OWNER>/<REPOSITORY>/actions/workflows/<WORKFLOW_FILE>/badge.svg)
</pre>

## Tracking Tasks Using GitHub Projects

An issue is something that needs to be done to the codebase: bug fix, new feature, documentation fix, and so on. A key feature of issues is how they connect to development: you can [link any issue to one or more branches](https://docs.github.com/en/issues/tracking-your-work-with-issues/creating-a-branch-for-an-issue), which makes branch-per-feature development (textbook section 10.2) easy to do, and you can [link an issue to a pull request](https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue), so that successfully merging the PR (section 10.3) closes out the issue.

When you divide up work in the regular iterations, each story will be an Issue, and the person(s) assigned to that Issue will be the ones responsible for the code and tests of that story.

To keep track of your issues while you work on your project, GitHub Projects provides a dashboard with different stages for your issues (New, Todo, In Progress, In Review, Done).

### Add a GitHub project to your repo

1. Open your repo in GitHub
2. In “Projects”, click on “New project” (not “Link a Project”) and, when asked for a template in the left column, select “\[TEMPLATE\] 10.5 Backlog Template”

### Understand your GitHub project

Now that you successfully added a project to your repository, you can start creating issues!

- New/Ice Box: all unprioritized issues
- Todo: prioritized issues (you’re going to do the work)
- In Progress: issues in progress
- In Review: issues pending review from your teammates (make sure you make a PR\!)
- Done: issues you finished working on

# Deliverables

There is **no direct deliverable** for iteration 0. You will need to complete this iteration (and potentially refer back to it) before starting iteration 1, however. Your course staff may verify that you've completed these steps before grading iteration 1.
