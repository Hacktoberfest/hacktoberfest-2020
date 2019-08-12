# Hacktoberfest

Hacktoberfest follows a schedule roughly like this:

- PRE STATE (teaser mode) begins
  - During this phase, the site consists of a PRE STATE (teaser mode) page, with a form for collecting user emails.
  - Project import begins
  - While we are in the PRE STATE, we prepare a database of curated Hacktoberfest projects. This way, when we switch to the -   - LIVE STATE, users will see a sampling of good issues.
  - Early registration begins
  - We are now in the LIVE STATE and the full site is now accessible.
  - Users can register for Hacktoberfest with their GitHub accounts.
  - Additionally, the site displays a curated sampling of GitHub issues labeled "hacktoberfest".
  - No participation or progress statistics are visible yet.
- Challenge begins
  - We then start tracking registered users' progress toward completing the Hacktoberfest challenge.
  - Users are now able to see their progress on the website, and to view global statistics about overall Hacktoberfest  participation.
  - Redemption begins
  - Once we and our fulfillment partner are ready, we begin sending redemption codes to users that have completed the Hacktoberfest challenge.
- Challenge ends
  - We switch to the POST STATE
  - The site stops permitting user registration.
  - All scheduled rake tasks related to registration, challenge completion, redemption, etc., stop running.
  - The site displays global stats on the home page.
  - PRE STATE (teaser mode) begins again
At some point, PRE STATE is turned back on and the site is retired until next year.

