# Hacktoberfest

The app used to run the annual [Hacktoberfest](https://hacktoberfest.digitalocean.com) open source challenge.

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

## Contributing
Hacktoberfest is open source and we welcome contributions. See [CONTRIBUTING.md](/CONTRIBUTING.md) for more info.

## Code of Conduct
This project uses the Contributor Covenant Code of Conduct. See [CODE_OF_CONDUCT.md](/CODE_OF_CONDUCT.md) for more info.

## License
Licensed under the [MIT License](http://en.wikipedia.org/wiki/MIT_License).
The full license text is available in [LICENSE.md](/LICENSE.md).
