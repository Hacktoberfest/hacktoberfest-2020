# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
module AirtablePlaceholderService
  module_function

  # rubocop:disable Metrics/MethodLength
  def call(table_name)
    case table_name
    when 'Meetups'
      {
        'data' =>
        [
          {
            'attributes' => {
              'title' => 'Hacktoberfest in Brasilia',
              'startDate' => '2020-10-16',
              'location' => {
                'city' => 'Brasilia',
                'country' => 'Brazil'
              }
            },
            'links' => {
              'register' => 'http://organize.mlh.io/participants/events/3921-hacktoberfest-in-brasilia/register'
            }
          },
          {
            'attributes' => {
              'title' => 'Hacktoberfest @IPN',
              'startDate' => '2020-10-01',
              'location' => {
                'city' => 'Mexico City',
                'country' => 'Mexico'
              }
            },
            'links' => {
              'register' => 'http://organize.mlh.io/participants/events/3924-hacktoberfest-ipn/register'
            }
          }
        ]
      }
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
      [
        { 'Question' =>
            "My draft pull requests don't seem
            to be counting toward Hacktoberfest.
            What’s going on?",
          'Answer' =>
            "For Hacktoberfest, pull requests on GitHub
            will not be counted until they are marked as **ready for review**:
            those marked as **draft** will not be counted.
            Please make sure to relabel any draft
            PRs as ready for review so that project
            maintainers can merge them.",
          'Category' => 'General' },
        { 'Question' =>
           'Why is my pull request in a maturing state on my profile?',
          'Answer' =>
            "In an effort to reduce spam and help maintainers,
            we’ve introduced a one-week review period for all pull requests.
            Once you have submitted four eligible PRs
            (ready-to-review, not drafts), the fourteen-day
            review window begins. This period gives maintainers time to
            identify and label any spammy PRs as **invalid**. If your PRs are
            not marked invalid during that window,
            they will allow you to complete the Hacktoberfest challenge.
            If during this period any of your PRs are labeled
            as **invalid**, you will return to the pending
            state until you have four
            eligible PRs, at which point the review period will start again.",
          'Category' => 'General' },
        { 'Question' => 'How can I host a Hacktoberfest event?',
          'Answer' =>
            "See the Hacktoberfest Event Organizer Kit:
            [hacktoberfest.digitalocean.com/eventkit]
            (https://hacktoberfest.digitalocean.com/eventkit)",
          'Category' => 'Events' },
        { 'Question' => 'How do I return or exchange an item?',
          'Answer' =>
            "Please email [Hacktoberfest@DigitalOcean.com]
            (mailto:hacktoberfest@digitalocean.com)
            within two days of placing your order.
            Please include your order number and the
            T-shirt size you’d like and we’ll get that updated for you.",
          'Category' => 'Shipping' },
        { 'Question' => 'Do multiple PRs to the same repo count?',
          'Answer' => 'Yes, each pull request will count separately.',
          'Category' => 'Rules' },
        { 'Question' => 'Can you help me promote my Hacktoberfest event?',
          'Answer' =>
            "Tell us about your event:
            [hacktoberfest.digitalocean.com/eventkit#form]
            (https://hacktoberfest.digitalocean.com/eventkit#form)
            and we’ll add it to [hacktoberfest.digitalocean.com]
            (https://hacktoberfest.digitalocean.com/)!",
          'Category' => 'Events' },
        { 'Question' => 'Do PRs have to be accepted/merged?',
          'Answer' =>
            "Yes, in order for a pull request to count,
             it must be approved or merged.
             The repository must also have the Hacktoberfest tag.",
          'Category' => 'Rules' }
      ]
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
