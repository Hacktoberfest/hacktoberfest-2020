# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
module AirtablePlaceholderService
  module_function

  # rubocop:disable Metrics/MethodLength
  def call(table_name)
    case table_name
    when 'Meetups'
      [
        {
          'attributes' => {
            'title' => 'Hacktoberfest in Brasilia',
            'startDate' => '2020-10-16',
            'timeZone' => 'America/Sao_Paulo',
            'location' => {
              'city' => 'Brasilia',
              'country' => 'Brazil'
            }
          },
          'links' => {
            'register' => 'http://organize.mlh.io/participants/events/3921-hacktoberfest-in-brasilia/register',
            'view' => 'http://organize.mlh.io/participants/events/3921-hacktoberfest-in-brasilia'
          }
        },
        {
          'attributes' => {
            'title' => 'Hacktoberfest 2020 Official Kick-Off Celebration',
            'startDate' => '2020-10-01',
            'timeZone' => 'Asia/Calcutta',
            'location' => {
              'city' => 'APAC',
              'country' => 'India'
            }
          },
          'links' => {
            'register' => 'https://organize.mlh.io/participants/events/4019-hacktoberfest-2020-official-kick-off-celebration/register',
            'view' => 'https://organize.mlh.io/participants/events/4019-hacktoberfest-2020-official-kick-off-celebration'
          }
        },
        {
          'attributes' => {
            'title' => 'Hacktoberfest Tuesdays: Europe',
            'startDate' => '2020-10-27',
            'timeZone' => 'Europe/London',
            'location' => {
              'city' => 'London',
              'country' => 'United Kingdom'
            }
          },
          'links' => {
            'register' => 'https://organize.mlh.io/participants/events/4101-hacktoberfest-tuesdays-europe/register',
            'view' => 'https://organize.mlh.io/participants/events/4101-hacktoberfest-tuesdays-europe'
          }
        },
        {
          'attributes' => {
            'title' => 'Hacktoberfest Tuesdays: Americas',
            'startDate' => '2020-10-06',
            'timeZone' => 'America/New_York',
            'location' => {
              'city' => 'New York',
              'country' => 'United States'
            }
          },
          'links' => {
            'register' => 'https://organize.mlh.io/participants/events/4079-hacktoberfest-tuesdays-east-coast-and-more/register',
            'view' => 'https://organize.mlh.io/participants/events/4079-hacktoberfest-tuesdays-east-coast-and-more'
          }
        }
      ]
    when 'Event List'
      [
        {
          'Event Named' => 'Hacktoberfest 2020 Official Kick-Off Celebration',
          'Event City' => 'APAC',
          'Event Country' => 'India',
          'Date' => '2020-10-01',
          'Link' => 'https://organize.mlh.io/participants/events/4019-hacktoberfest-2020-official-kick-off-celebration'
        },
        {
          'Event Named' => 'Hacktoberfest Tuesdays: Americas',
          'Event City' => 'New York',
          'Event Country' => 'United States',
          'Date' => '2020-10-06',
          'Link' => 'https://organize.mlh.io/participants/events/4079-hacktoberfest-tuesdays-east-coast-and-more'
        },
        {
          'Event Named' => 'Hacktoberfest Tuesdays: Asia',
          'Event City' => 'Singapore',
          'Event Country' => 'Singapore',
          'Date' => '2020-10-13',
          'Link' => 'https://organize.mlh.io/participants/events/4099-hacktoberfest-tuesdays-asia'
        },
        {
          'Event Named' => 'Hacktoberfest Tuesdays: Europe',
          'Event City' => 'London',
          'Event Country' => 'United Kingdom',
          'Date' => '2020-10-27',
          'Link' => 'https://organize.mlh.io/participants/events/4101-hacktoberfest-tuesdays-europe'
        }
      ]
    when 'FAQs'
      # rubocop:disable Metrics/LineLength
      [{
        'Question' => 'Do I get a prize for participating? ',
        'Answer' => 'Aside from the knowledge you’ll gain (and the fun you’ll have), you’ll also receive a limited edition Hacktoberfest T-shirt for submitting 4 valid pull requests.',
        'Category' => 'General',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'How is DigitalOcean helping the environment? ',
        'Answer' => "To limit our carbon impact, we are paying for carbon offsets. And to further help the environment, we're offering the option to plant a tree rather than receive a shirt.\n \nFun fact: Hacktoberfest shirts flew 336 million miles internationally last year. In total, it adds up to a fully loaded 747 flying 676 miles.",
        'Category' => 'General',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'My pull request was labeled as invalid by a maintainer, why doesn’t it count?',
        'Answer' => 'If a repository maintainer decides a pull request you made was spammy or an unhelpful contribution to the project, they can add an **invalid** or **spam** label to your PR. This lets us know they do not think your pull request is a quality contribution, so it will not count toward Hacktoberfest.',
        'Category' => 'General',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'Will I have to pay anything/custom tax/duty for the T-shirt?',
        'Answer' => 'We write down a low enough dollar value on the mailed packages that we don’t expect any issues with customs tax, but we cannot guarantee that – you might have to pay a small fee depending on your country’s import policies. DigitalOcean and Kotis Design will not issue a refund for shipping/duty fees.',
        'Category' => 'Shipping',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'Who can organize a Hacktoberfest-themed meetup?',
        'Answer' => 'Anyone can, as long as you celebrate open source during the event and follow the Hacktoberfest Events Code of Conduct: [do.co/hacktoberconduct](https://do.co/hacktoberconduct).',
        'Category' => 'Events',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'Why is my pull request in a maturing state on my profile?',
        'Answer' => 'In an effort to reduce spam and help maintainers, we’ve introduced a two week review period for all pull requests. Once you have submitted an eligible pull request (ready for review, not draft), the fourteen-day review window begins. This period gives maintainers time to identify and label any spammy pull requests as **invalid**. If your pull request is not marked invalid during that window, it will contribute toward the four you need to complete the Hacktoberfest challenge. If during this period your pull request is labeled as **invalid**, you will need to submit another eligible pull request (or resolve the issue with the current pull request), at which point the review period will start again.',
        'Category' => 'General',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'As a maintainer, how should I handle spam pull requests?',
        'Answer' => 'We dislike seeing spam pull requests just as much as you, so please give them an **invalid** or **spam** label and close them. Pull requests that contain a label with the word **invalid** or **spam** won’t be counted toward Hacktoberfest.',
        'Category' => 'General',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'What T-shirt size should I order?',
        'Answer' => 'You can reference the size charts for the T-shirts on the ordering page. Both size charts include measurements in inches, and instructions for how to measure yourself.',
        'Category' => 'Shipping',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'When will my T-shirt be shipped? (Intl)',
        'Answer' => 'You will receive an email once your T-shirt is shipped. Due to COVID-19 delivery delays, it can take up to 6-8  weeks after shipment for international orders to be delivered.',
        'Category' => 'Shipping',
        'Site Stage' => ['Main '],
        'Internal Notes' => 'Check timing given COVID'
      }, {
        'Question' => 'I didn’t receive my Hacktoberfest 2019 T-shirt/swag.',
        'Answer' => 'We are no longer printing 2019 T-shirts. If you did not receive your T-shirt, this means we tried to deliver multiple times unsuccessfully. We are working hard on improving the shipping process this year so that everyone receives their T-shirts. Thank you for your understanding.',
        'Category' => 'Shipping',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'Tracking for my order is not active, is my tracking number correct?',
        'Answer' => 'You may receive a tracking email 2-3 days before tracking becomes active on DHL’s website. Try again in a few days.',
        'Category' => 'Shipping',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'How do I get started? ',
        'Answer' => 'First, register at [hacktoberfest.digitalocean.com](https://hacktoberfest.digitalocean.com/). Then, submit at least four pull requests to any public GitHub repository that is classified with the hacktoberfest topic or has a **hacktoberfest-accepted** label on it. You can look for [open issues labeled **Hacktoberfest**](https://github.com/search?l=&o=desc&q=label%3Ahacktoberfest+state%3Aopen&s=updated&type=Issues) for inspiration. Quality contributions are encouraged! Are you maintaining a repo? Create issues or classify existing issues on your GitHub projects with **hacktoberfest** to help let new contributors know what to work on. Tag any spam or irrelevant pull requests with the **invalid** label to disqualify them.',
        'Category' => 'General',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'What is open source? ',
        'Answer' => 'Open source refers to source code that is publicly accessible and allows anyone to inspect, modify or learn from it. Open source projects encourage collaboration and the freedom to use the software for any purpose you wish.',
        'Category' => 'General',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'When will my T-shirt be shipped? (US)',
        'Answer' => 'You will receive an email once your T-shirt is shipped. Due to COVID-19 delivery delays, it can take up to 6-8 weeks after shipment for orders within the U.S. to be delivered.',
        'Category' => 'Shipping',
        'Site Stage' => ['Main '],
        'Internal Notes' => 'Check timing given COVID'
      }, {
        'Question' => 'Do I get a prize for participating? ',
        'Answer' => 'Aside from the knowledge you’ll gain (and the fun you’ll have), you’ll also receive a limited edition Hacktoberfest T-shirt for submitting 4 valid pull requests. ',
        'Category' => 'General',
        'Site Stage' => ['Teaser']
      }, {
        'Question' => 'What is a pull request? ',
        'Answer' => 'Pull requests are proposed code changes you can submit to a branch in a repository on GitHub. Once submitted, a project maintainer will review  and discuss the changes before they become final. ',
        'Category' => 'General',
        'Site Stage' => ['Teaser']
      }, {
        'Question' => 'Do pull requests made on my own repositories count?',
        'Answer' => 'Yes, but we strongly encourage you to make quality contributions to other repositories.',
        'Category' => 'Rules',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'Do multiple pull requests to the same repository count?',
        'Answer' => 'Yes, each pull request will count separately.',
        'Category' => 'Rules',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'What do I do if I want to contribute to a project but it doesn’t have the hacktoberfest topic? ',
        'Answer' => 'You can still contribute to any public GitHub repository and have it count towards your progress provided that your pull request is labeled with **hacktoberfest-accepted.**',
        'Category' => 'General',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'Customs is asking me for an invoice, where do I find one of those?',
        'Answer' => 'We can provide you with a commercial invoice that you can pass on to customs or the shipping company. Please email [Hacktoberfest@KotisDesign.com](mailto:Hacktoberfest@KotisDesign.com) and make sure you’ve listed your order number in your request so we can generate an appropriate invoice for you.',
        'Category' => 'Shipping',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'How can I host a Hacktoberfest meetup?',
        'Answer' => 'See the Hacktoberfest Event Organizer Kit: [hacktoberfest.digitalocean.com/eventkit](https://hacktoberfest.digitalocean.com/eventkit/).',
        'Category' => 'Events',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'If I made 4 pull requests before October 3rd, 2020 and they were merged, will they count towards my goal? ',
        'Answer' => 'All pull requests made before October 3 at 12:00 UTC, 2020, will count before the rules were changed. Please keep in mind that the review window has been updated to 14 days. ',
        'Category' => 'General',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'How do I return or exchange an item?',
        'Answer' => 'If you believe your order was shipped incorrectly, contact us with the order number from the email subject line, plus an explanation of the incorrect item you received. Otherwise, if it’s still within 30 days of the original purchase, follow the instructions at [kotisdesign.com/returns](https://kotisdesign.com/returns/). You will be responsible for shipping the item back to us.',
        'Category' => 'Shipping',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'How do I track my progress?',
        'Answer' => 'Log in with your GitHub account at [hacktoberfest.digitalocean.com](https://hacktoberfest.digitalocean.com/) to check your progress and stats.',
        'Category' => 'General',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'What are the rules?',
        'Answer' => 'To win a reward, you must sign up on the Hacktoberfest site and make four pull requests on any repositories classified with the hacktoberfest topic on GitHub by October 31.  Additionally, any pull request with the **hacktoberfest-accepted** label, submitted to any public GitHub repository, with or without the hacktoberfest topic, will be considered valid for Hacktoberfest.Pull requests must then be merged or accepted by the maintainer of the project before November 1. ',
        'Category' => 'Rules',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'I completed four pull requests. When will I receive my T-shirt?',
        'Answer' => 'T-shirts (or the option to plant a tree) will be awarded on a first-come, first-serve basis to the first 70,000 participants who successfully complete the Hacktoberfest challenge. We’ll start sending out emails with more details on redeeming T-shirts throughout the month, so stay tuned.',
        'Category' => 'General',
        'Site Stage' => ['Main '],
        'Internal Notes' => 'Duplicated content: We will start sending out emails with more details on redeeming T-shirts throughout the month. Stay tuned! If you don\'t receive one by the first 2-3 days of November, please let us know.'
      }, {
        'Question' => 'My draft pull requests don’t seem to be counting toward Hacktoberfest. What’s going on?',
        'Answer' => 'For Hacktoberfest, pull requests on GitHub will not be counted until they are marked as **ready for review**: those marked as **draft** will not be counted. Please make sure to mark any draft pull requests as ready for review so that project maintainers can merge them.',
        'Category' => 'General',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'Do pull requests have to be accepted/merged?',
        'Answer' => 'Your pull requests will count toward your participation if they are in a repository with the hacktoberfest topic and once they have been merged, approved by a maintainer or labeled as **hacktoberfest-accepted**. Additionally, any pull request with the **hacktoberfest-accepted** label, submitted to any public GitHub repository, with or without the hacktoberfest topic, will be considered valid for Hacktoberfest.',
        'Category' => 'Rules',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'Why organize a Hacktoberfest-themed meetup?',
        'Answer' => 'Why not!? Meetups help increase awareness of open source in your community, all while meeting maintainers, contributors, and community members. You gain the opportunity to learn about the open source ecosystem, from how to start an open source project to marketing your project, sustaining growth, and troubleshooting and maintenance.',
        'Category' => 'Events',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'How do I get started?',
        'Answer' => 'Enter your email above to receive updates on this year’s program. ',
        'Category' => 'General',
        'Site Stage' => ['Teaser']
      }, {
        'Question' => 'I’d like some credits for my Hacktoberfest meetup attendees. Can you give me some?',
        'Answer' => "Feel free to share the following link with your attendees along with this wording: “New to DigitalOcean? Receive USD $100 in infrastructure credit at https://do.co/hacktoberfest_eventpromo.”\n\nNote that the free credit only applies to users who are new to DigitalOcean, and requires a valid credit card.",
        'Category' => 'Events',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'Do I have to create an Major League Hacking account to create a Hacktoberfest meetup? ',
        'Answer' => 'Yes. This year we\'ve partnered with Major League Hacking (MLH) to offer an easier way to create and run online meetups. Once you have created an MLH account, you can create multiple events and manage them all on the event platform. Review the Event Organizer Kit for more details: [hacktoberfest.digitalocean.com/eventkit](https://hacktoberfest.digitalocean.com/eventkit/).',
        'Category' => 'Events',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'Can you help me promote my Hacktoberfest meetup?',
        'Answer' => 'Yes. After you create your event on Major League Hacking, our events team will review the listing. Once approved, the event will be promoted on [hacktoberfest.digitalocean.com](https://hacktoberfest.digitalocean.com/). Check out the Event Organizer Kit for more details: [hacktoberfest.digitalocean.com/eventkit](https://hacktoberfest.digitalocean.com/eventkit).',
        'Category' => 'Events',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'Can I update my email address, delivery address, and/or the size of my T-shirt?',
        'Answer' => "Yes, as long as your item has not shipped yet we can absolutely adjust this. Please email [Hacktoberfest@KotisDesign.com](mailto:Hacktoberfest@KotisDesign.com) as soon as possible and make sure to include your order number as well as how we should edit your order (including the new shipping address, preferred size, or the correct email address). Unfortunately, we are unable to change this information once your items have departed from our facilities.\n\n",
        'Category' => 'Shipping',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'How do I get started? ',
        'Answer' => 'First, register at [hacktoberfest.digitalocean.com](https://hacktoberfest.digitalocean.com/). Then, submit at least four pull requests to any public GitHub repository that is classified with the hacktoberfest topic. You can look for [open issues labeled **Hacktoberfest**](https://github.com/search?l=&o=desc&q=label%3Ahacktoberfest+state%3Aopen&s=updated&type=Issues) for inspiration. Quality contributions are encouraged! Are you maintaining a repo? Create issues or classify existing ones with **Hacktoberfest** on your GitHub projects to help new contributors know what to work on. Tag any spam or irrelevant pull requests with the **invalid** label to disqualify them.',
        'Category' => 'General',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'How can I exclude my repository from Hacktoberfest? ',
        'Answer' => 'We’ve changed the program to only count pull requests that are made to repositories with a hacktoberfest topic or labeled with **hacktoberfest-accepted**. Due to this change, it’s no longer necessary for maintainers to opt out of Hacktoberfest.',
        'Category' => 'General',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'Did my T-shirt order go through?',
        'Answer' => "If you did not receive an order confirmation email within an hour of placing your order, we can look up your order using the email address you used. Please check your spam or junk folders first and if it’s not there, send us an email to [Hacktoberfest@DigitalOcean.com](mailto:Hacktoberfest@KotisDesign.com) to confirm your T-shirt order.\n\n",
        'Category' => 'Shipping',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'I signed up for Hacktoberfest mid-October. Will pull requests that I created earlier in October count?',
        'Answer' => 'Yes, all pull requests created between Oct 1 and Oct 31 will count, regardless of when you register for Hacktoberfest. Pull requests created before Oct 1 but merged or marked as ready for review after do not count.',
        'Category' => 'Rules',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'How do I get stickers?',
        'Answer' => 'Stickers are included with your T-shirt, once you complete 4 pull requests.',
        'Category' => 'General',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'How can I keep my meetup engaging? ',
        'Answer' => "Virtual meetups can be challenging to facilitate, but they can still be fun! Using networking tools like Icebreaker ([icebreaker.video](https://icebreaker.video/)) and asking fun opener questions (two truths and a lie) can loosen up the crowd and get attendees ready to share their open source knowledge. \n \nAnother great way to engage your audience is to invite guest speakers to your meetup. You can check out our Speaker Directory for inspiration.",
        'Category' => 'Events',
        'Site Stage' => ['Pre Launch '],
        'Internal Notes' => 'Link to speaker directory'
      }, {
        'Question' => 'What happens if I make a pull request before the maintainer adds a hacktoberfest topic to the repository? ',
        'Answer' => "Your pull request will undergo a review period in which the repository will be checked for the Hacktoberfest topic or has a **hacktoberfest-accepted** label on it. We will continue to check this pull request and repository until November 1 for the hacktoberfest topic. If the topic is added to the repository, the pull request will become valid.\n\n\n",
        'Category' => 'General',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'As a maintainer, how do I encourage contributions to my repos?',
        'Answer' => 'First, classify your repository with the hacktoberfest topic. This will alert participants that your repo is participating in Hacktoberfest. You can also create issues for anything you’d like contributors to help with, making sure to give them a **hacktoberfest-accepted** label so they’re easier to discover. You can also share issues or repositories on Twitter, using [#Hacktoberfest](https://twitter.com/hashtag/hacktoberfest). We’ll try to retweet as many as we can for contributors to see!',
        'Category' => 'General',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'Can I host an in-person meetup? ',
        'Answer' => 'We encourage all Hacktoberfest meetups this year to be online. Review the Event Organizer Kit for more information: [hacktoberfest.digitalocean.com/eventkit](https://hacktoberfest.digitalocean.com/eventkit/).',
        'Category' => 'Events',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'Do issues/commits count?',
        'Answer' => 'No, only pull requests count.',
        'Category' => 'Rules',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'My event hasn\'t been approved yet. How long til it goes live? ',
        'Answer' => 'Once you have submitted an event, our events team will review your listing within 2-3 days. If any changes need to be made, you will be alerted and the review process will start over.',
        'Category' => 'Events',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'Will I have to pay anything to receive my T-shirt/stickers?',
        'Answer' => 'T-shirts are free of charge for participants, including shipping costs.',
        'Category' => 'Shipping',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'I’d like to speak/demo at a Hacktoberfest meetup. Can you give me free infrastructure credit?',
        'Answer' => 'Great! Please tell us more about your demo at [www.digitalocean.com/droplets-for-demos](https://www.digitalocean.com/droplets-for-demos/) and we\'ll get back to you soon!',
        'Category' => 'Events',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'What countries do you ship to?',
        'Answer' => 'We are able to ship to all countries with the exception of the following: Cuba, Iran, Libya, North Korea, Sierra Leone, Somalia, Sudan, Syria, and Yemen.',
        'Category' => 'Shipping',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'Will Hacktoberfest t-shirts be given out at meetups?',
        'Answer' => 'No. A Hacktoberfest T-shirt will be mailed — after the end of Hacktoberfest — to participants who make four pull requests on GitHub between October 1 and October 31.',
        'Category' => 'Events',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'What is considered a valid pull request? ',
        'Answer' => 'Review our [quality standards](https://hacktoberfest.digitalocean.com/details#quality) and [spam reduction tips](https://hacktoberfest.digitalocean.com/details#spam) on the [Resources page](https://hacktoberfest.digitalocean.com/details) for more information.',
        'Category' => 'General',
        'Site Stage' => ['Pre Launch '],
        'Internal Notes' => 'Link to resources page. '
      }, {
        'Question' => 'What happens if I complete fewer than four pull requests by the end of the month?',
        'Answer' => 'Unfortunately, you will have to submit at least four pull requests to receive a prize. ',
        'Category' => 'General',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'What is open source? ',
        'Answer' => 'Open source refers to source code that is publicly accessible and allows anyone to inspect, modify or learn from it. Open source projects encourage collaboration and the freedom to use the software for any purpose you wish.',
        'Category' => 'General',
        'Site Stage' => ['Teaser']
      }, {
        'Question' => 'My international order is delayed. What can I do?',
        'Answer' => 'We recommend contacting DHL in your country for help with clearing the package: [www.dhl.com/global-en/home/our-divisions/ecommerce/customer-service.html](https://www.dhl.com/global-en/home/our-divisions/ecommerce/customer-service.html).',
        'Category' => 'Shipping',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'What is Hacktoberfest?',
        'Answer' => "Hacktoberfest is a monthlong global celebration of open source software run by DigitalOcean, with a strong focus on encouraging contributions to open source projects. \n\n- Hacktoberfest is open to everyone in our global community!\n- Four quality pull requests must be submitted to public GitHub repositories.\n- You can sign up anytime between October 1 and October 31.",
        'Category' => 'General',
        'Site Stage' => ['Teaser']
      }, {
        'Question' => 'Can I make pull requests to issues/repositories that are not listed on the homepage?',
        'Answer' => 'Yes! Any public GitHub repository is good for Hacktoberfest.',
        'Category' => 'Rules',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'Can I receive a shirt and plant a tree? ',
        'Answer' => "When completing four pull requests, you will have the option to choose either a Hacktoberfest shirt in white or blue, OR the option to donate a tree. You will not have the option to choose both swag options. \n\nHowever, if you want to plant a tree on your own, you can do so here: [tree-nation.com/profile/digitalocean](https://tree-nation.com/profile/digitalocean).",
        'Category' => 'General',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'Do contributions made outside of GitHub count?',
        'Answer' => 'No, pull requests must be made on the GitHub platform.',
        'Category' => 'Rules',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'Do issues have to be tagged #Hacktoberfest to count?',
        'Answer' => 'No, any pull request made on a **participating** repository counts, whether it’s attached to a [**hacktoberfest** issue](https://github.com/search?l=&o=desc&q=label%3Ahacktoberfest+state%3Aopen&s=updated&type=Issues) or not.',
        'Category' => 'Rules',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'My PR was labeled as invalid, but it isn’t. What should I do?',
        'Answer' => 'If a maintainer labels your pull request as **invalid** or **spam**, but you don’t believe this is correct, please begin a conversation with the maintainer within the PR and explain your position.',
        'Category' => 'General',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'Why isn’t my pull request counted? ',
        'Answer' => 'If the maintainer has marked your pull request as invalid, or you have contributed to a repository that isn’t classified with a Hacktoberfest topic, your pull request will not count toward the challenge. Your pull requests will only count toward your participation if they are in a repository with the **hacktoberfest** topic and once they have been merged, approved by a maintainer or labeled as **hacktoberfest-accepted**. Additionally, any pull request with the **hacktoberfest-accepted** label, submitted to any public GitHub repository, with or without the **hacktoberfest** topic, will be considered valid for Hacktoberfest.',
        'Category' => 'General',
        'Site Stage' => ['Main ']
      }, {
        'Question' => 'What is Hacktoberfest?',
        'Answer' => "Hacktoberfest is a monthlong celebration of open source software run by DigitalOcean.\n\nHacktoberfest is open to everyone in our global community!\nFour quality pull requests must be submitted to public GitHub repositories.\nYou can sign up anytime between October 1 and October 31.",
        'Category' => 'General',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'What is a pull request? ',
        'Answer' => 'Pull requests are proposed code changes you can submit to a branch in a repository on GitHub. Once submitted, a project maintainer will review and discuss the changes before they become final.',
        'Category' => 'General',
        'Site Stage' => ['Pre Launch ']
      }, {
        'Question' => 'My pull request is marked as being on an excluded repository. What does this mean?',
        'Answer' => 'Unfortunately, your pull request was made on a repository that doesn’t align with [the core values of Hacktoberfest](https://hacktoberfest.digitalocean.com/details#values). We’ve decided that pull requests made to this repository will not count toward completing the challenge.',
        'Category' => 'General',
        'Site Stage' => ['Main ']
      }]
      # rubocop:enable Metrics/LineLength
    when 'Themed Repos'
      [
        {
          'Repo Name' => 'electricitymap-contrib',
          'Repo URL' => 'https://github.com/tmrowco/electricitymap-contrib',
          'Repo Language' => 'Python',
          'Description' => 'A real-time visualisation of the CO2 emissions of
            electricity consumption'
        },
        {
          'Repo Name' => 'tmrowapp-contrib',
          'Repo URL' => 'https://github.com/tmrowco/tmrowapp-contrib',
          'Repo Language' => 'JavaScript',
          'Description' => 'Tomorrow automatically calculates the climate
            impact of your daily choices by connecting to apps and services you
            already use.'
        },
        {
          'Repo Name' => 'community-toolbox',
          'Repo URL' => 'https://github.com/publiclab/community-toolbox',
          'Repo Language' => 'JavaScript',
          'Description' => 'Tools to understand and welcome people into a
            contributor community'
        },
        {
          'Repo Name' => 'polarmap.js',
          'Repo URL' => 'https://github.com/GeoSensorWebLab/polarmap.js',
          'Repo Language' => 'JavaScript',
          'Description' => 'Custom Leaflet layer for re-projecting maps and map
            features'
        },
        {
          'Repo Name' => 'climate',
          'Repo URL' => 'https://github.com/apache/climate',
          'Repo Language' => 'Jupyter Notebook',
          'Description' => 'Mirror of Apache Open Climate Workbench'
        },
        {
          'Repo Name' => 'awesome-open-climate-science',
          'Repo URL' => 'https://github.com/pangeo-data/awesome-open-climate-science',
          'Repo Language' => '',
          'Description' => 'Awesome Open Atmospheric, Ocean, and Climate
            Science'
        },
        {
          'Repo Name' => 'contributor_covenant',
          'Repo URL' => 'https://github.com/Ecohackerfarm/contributor_covenant',
          'Repo Language' => 'CSS',
          'Description' => 'Pledge your respect and appreciation for
            contributors of all kinds to your open source project.'
        },
        {
          'Repo Name' => 'RebelsManager',
          'Repo URL' => 'https://github.com/extinctionrebellion/',
          'Repo Language' => 'Ruby',
          'Description' => 'Extinction Rebellion is an international movement
            that uses non-violent civil disobedience in an attempt to halt mass
            extinction and minimise the risk of social collapse. The Rebels
            Manager is a CRM app for coordinators.'
        },
        {
          'Repo Name' => 'pangeo',
          'Repo URL' => 'https://github.com/pangeo-data/pangeo',
          'Repo Language' => 'Jupyter Notebook',
          'Description' => 'Pangeo website + discussion of general issues
            related to the project.'
        }
      ]
    else
      []
    end
  end
  # rubocop:enable Metrics/MethodLength
end
# rubocop:enable Metrics/ModuleLength
