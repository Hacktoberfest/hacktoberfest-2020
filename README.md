# Hacktoberfest

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

To find your token: Start off by going to your [GitHub Settings page] (https://github.com/settings/profile)

![GitHub Settings] (/images/settings.jpeg)

In the sidebar, click [Developer settings] (https://github.com/settings/apps)

![Developer Settings] (/images/developer-settings.png)

In this sidebar, click [Personal access tokens] (https://github.com/settings/tokens)

![Personal access tokens] (/images/personal-access-tokens-menu.png)

Now, if you don't already have a token to use, click [Generate new token] (https://github.com/settings/tokens/new)

![Generating personal access token] (/images/personal-access-tokens-page)

Scroll all the way to the bottom and hit Generate token. You don't need to check off any of the boxes 

![Generating personal access token] (/images/generate-token-page) 

On the next page, copy the token given (blanked out in the screenshot) a

![personal access token generated] (/images/generated-token) 

Finally, paste it into your .env under `GITHUB_ACCESS_TOKEN`


## Built With

* [Rails] (https://github.com/rails/rails) - The server framework used
* [bundler](https://github.com/bundler/bundler) - Dependency Management
