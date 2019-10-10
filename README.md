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

### Development

Coming soon

## Built With

* [Rails] (https://github.com/rails/rails) - The server framework used
* [bundler](https://github.com/bundler/bundler) - Dependency Management
