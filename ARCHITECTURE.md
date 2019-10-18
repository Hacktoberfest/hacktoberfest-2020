# Hacktoberfest Architecture

## Data in Hacktoberfest

There are two main paradigms governing data flow from GitHub within the Hacktoberfest app. The two are opposites.

### Imports to the DB

For repositories and issues, we have `rake` tasks that hit the GitHub API and import objects into our DB. The app then is constantly reading from that DB to load repositories and issues where necessary.

### Fetches from the github API

For pull requests, we fetch from the GitHub API every time we need them. Pull requests are not stored in our DB. This allows us to always have up to date information for the most important objects in our app. For example, each time a user visits their profile page, we query the GitHub API for their pull requests, and categorize them based on their attributes.

## Github tokens

The GitHub API has a restrictive rate limit that can be overcome by making authenticated requests using OAuth access tokens even when requesting public data. In some cases, when tokens are revoked by users we need to fall back on an alternate valid token for the app to function.
