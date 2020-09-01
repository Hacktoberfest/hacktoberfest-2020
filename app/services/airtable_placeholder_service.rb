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
    when 'FAQ'
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
            (ready-to-review, not drafts), the seven-day review window begins.
            This period gives maintainers time to
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
            "No, they will still count unless they are spam,
            irrelevant, or labeled as
            **invalid**.",
          'Category' => 'Rules' }
      ]
    else
      []
    end
  end
end
