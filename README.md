# Hacktoberfest

## Features
* Static pages
* Airtable backed events and FAQs
* Issue discovery by language
* Log in with GitHub
* Multi-step registration
* Pull request timeline
* Challenge completion validation
* Prize distribution

## Components
There are three major components that are entirely separate from one another:

1. Issue discovery - Fetches issues from GitHub with the label `hacktoberfest` and persists them in the database to be featured on the homepage based on a randomized quality filter.

2. Content pages - Primarily static pages that are supplemented with dynamic data from Airtable.

3. Participant management - Allows users to register to participate in Hacktoberfest, tracks user progress, and distributes prizes based on availability. The majority of the business logic is implemented with a state machine, validating that various conditions are met before a user may be transitioned to a new state and with certain actions being triggered on successful state transitions.


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Ensure your os is the latest MacOS

- Have brew installed (Run the following command in a mac os terminal to install)

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Installing

clone the repo

```
git clone https://github.com/raise-dev/hacktoberfest
```

In your local repository, run script/setup, which will install all necessary dependencies for you

```
script/setup
```

### Running the project

There are two commands you will need for running the project.

First, spin up the rails server locally

```
script/server
```

If you will be running any background jobs through sidekiq, run the following command which will spin up both redis and sidekiq

```
script/console
```

## ENV Variables

### Github Access Token

You will need to set your github authorizaiton token as an environment variable in order to have many aspects of the site work properly. For example, the homepage attempts pulling in github projects using that very token.

To find your token: Start off by going to your [GitHub Settings page](https://github.com/settings/profile):

![GitHub Settings](/images/settings.jpeg)

In the sidebar, click [Developer settings](https://github.com/settings/apps):

![Developer Settings](/images/developer-settings.png)

In this sidebar, click [Personal access tokens](https://github.com/settings/tokens):

![Personal access tokens](/images/personal-access-tokens-menu.png)

Now, if you don't already have a token to use, click [Generate new token](https://github.com/settings/tokens/new):

![Generating personal access token](/images/personal-access-tokens-page.png)

Scroll all the way to the bottom and hit Generate token. You don't need to check off any of the boxes.

![Generating personal access token](/images/generate-token-page.png)

On the next page, copy the token given (blanked out in the screenshot):

![personal access token generated](/images/generated-token.png)

Finally, paste it into your .env under `GITHUB_ACCESS_TOKEN`.

### Github Client ID & Github Client Secret

Hacktoberfest uses `GITHUB_CLIENT_ID` & `GITHUB_CLIENT_SECRET` variables to configure OmniAuth.

This allows users to be authorized for Hacktoberfest via Github.

For this, you will have to create a Github OAuth App (https://developer.github.com/apps/building-oauth-apps)

### Start Date & End Date

Hacktoberfest is officially active from October 1st - November 1st
So your ENV variables for these should be as follows:
```
 START_DATE="2019-10-01 00:00:00 UTC"
 END_DATE="2019-11-01 00:00:00 UTC"
```

### Airtable API Key & Airtable App ID

Hacktoberfest uses Airtable as a CMS to hold useful data such as:
  - Events
  - FAQ
  - Spam Repositories

For your convenience we have created two options:

##### Create an Airtable Database:

We created a read-only copy of what the Airtable database should look like.

With this you can create your own schema by following this format:
(https://airtable.com/shrqM142bVC1Gj2t8)

After you’ve created and configured the schema of an Airtable base from the graphical interface,

your Airtable base will provide its own API to create, read, update, and destroy records.

You should update these variables accordingly in your `.env`

##### Use Placeholder Airtable Service

If configuring your own Airtable schema does not sound like your cup of tea - don't fret.

We have created placeholder service objects that will render test data if your Airtable keys are not set.

This service will be used as default.

You can find this service in `app/services/airtable_placehoder_service.rb`

## Contributing
Hacktoberfest is open source and we welcome contributions. See [CONTRIBUTING.md](/CONTRIBUTING.md) for more info.

## Code of Conduct
This project uses the Contributor Covenant Code of Conduct. See [CODE_OF_CONDUCT.md](/CODE_OF_CONDUCT.md) for more info.

## License
Licensed under the [MIT License](http://en.wikipedia.org/wiki/MIT_License).
The full license text is available in [LICENSE.md](/LICENSE.md).

## Built With

* [Rails] (https://github.com/rails/rails) - The server framework used
* [bundler](https://github.com/bundler/bundler) - Dependency Management
The app used to run the annual [Hacktoberfest](https://hacktoberfest.digitalocean.com) open source challenge.
