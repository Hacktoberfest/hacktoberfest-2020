# frozen_string_literal: true

module AirtablePlaceholderService
  module_function

  def call(table_name)
    case table_name
    when 'Meetups'
      [
        {"Event Name"=>"Hacktoberfest@JKLU",
        "Event City"=>"Jaipur",
        "Event Country"=>"India",
        "Event Start Date"=>"2019-10-12",
        "Event URL"=>"https://csi.jklu.edu.in/calendar.php",
        "Event Organizer"=>"CSI Student Chapter JKLU",
        "Contact Email"=>"email@example.com",
        "Published?"=>true,
        "Contact Name"=>"Pravesh Bisaria",
        "Agreed to CoC?"=>true,
        "Event State"=>"Rajasthan",
        "Non-Public Event Note"=>"Open to JKLU Students",
        "Event Capacity"=>100,
        "Note"=>"No mention of HF",
        "Reviewed By"=>"Samantha",
        "Replied"=>"9/20 batch email",
        "Event Start Time"=>"00:00",
        "Event Start Date/Time"=>"2019-10-12T00:00:00.000Z",
        "Submitted Time"=>"2019-09-16T14:53:00.000Z"},
        {"Event Name"=>"Hacktoberfest@JKLU",
        "Event City"=>"Jaipur",
        "Event Country"=>"India",
        "Event Start Date"=>"2019-10-12",
        "Event URL"=>"https://csi.jklu.edu.in/calendar.php",
        "Event Organizer"=>"CSI Student Chapter JKLU",
        "Contact Email"=>"email@example.com",
        "Published?"=>true,
        "Contact Name"=>"Pravesh Bisaria",
        "Agreed to CoC?"=>true,
        "Event State"=>"Rajasthan",
        "Non-Public Event Note"=>"Open to JKLU Students",
        "Event Capacity"=>100,
        "Note"=>"No mention of HF",
        "Reviewed By"=>"Samantha",
        "Replied"=>"9/20 batch email",
        "Event Start Time"=>"00:00",
        "Event Start Date/Time"=>"2019-10-12T00:00:00.000Z",
        "Submitted Time"=>"2019-09-16T14:53:00.000Z",
        "Event Start Date/Time (Real)"=>"10/12/2019 00:00"},
        {"Event Name"=>"<ReactMeetup version={\"Hacktoberfest 2019\"} />",
        "Event City"=>"Düsseldorf",
        "Event Country"=>"Germany",
        "Event Start Date"=>"2019-10-13",
        "Event URL"=>"https://www.meetup.com/de-DE/ReactJS-Meetup-Dusseldorf/events/265147478/",
        "Event Organizer"=>"Thomas Frütel, Jonas Sprenger, Flo Becker",
        "Published?"=>true,
        "Contact Email"=>"email@example.com",
        "Contact Name"=>"Ravi",
        "Agreed to CoC?"=>true,
        "Public Event?"=>true,
        "Event Capacity"=>50,
        "Code Sent"=>"9/26",
        "Reviewed By"=>"Lorraine",
        "Event Start Time"=>"10:00",
        "Event Start Date/Time"=>"2019-10-13T10:00:00.000Z",
        "Submitted Time"=>"2019-09-25T14:16:43.000Z",
        "Event Start Date/Time (Real)"=>"10/13/2019 10:00"},
        {"Event Name"=>"Hacktoberfest Night",
        "Event City"=>"Paris",
        "Event Country"=>"France",
        "Event Start Date"=>"2019-10-15",
        "Event URL"=>"https://www.meetup.com/fr-FR/Paris-Open-Source-Talks/",
        "Event Organizer"=>"Paris Open Source Talks Meetup + Olivier Leplus + Maud Levy + Wassim Chegham",
        "Published?"=>true,
        "Contact Email"=>"email@example.com",
        "Contact Name"=>"Olivier Leplus",
        "Agreed to CoC?"=>true,
        "Public Event?"=>true,
        "Event Capacity"=>40,
        "Agreed to CoC?"=>true,
        "Public Event?"=>true,
        "Note"=>"no mention of HF",
        "Reviewed By"=>"Samantha",
        "Replied"=>"9/20 batch email",
        "Event Start Time"=>"00:00",
        "Event Start Date/Time"=>"2019-10-15T00:00:00.000Z",
        "Submitted Time"=>"2019-09-13T15:16:55.000Z",
        "Event Start Date/Time (Real)"=>"10/15/2019 00:00"},
        {"Event Name"=>"Hacktoberfest 2019 x Nodes Copenhagen",
        "Event City"=>"Copenhagen",
        "Event Country"=>"Denmark",
        "Event Start Date"=>"2019-10-21",
        "Event URL"=>"https://www.meetup.com/Nodes-Copenhagen/events/265336846/",
        "Event Organizer"=>"Nodes Copenhagen",
        "Published?"=>true,
        "Contact Email"=>"email@example.com",
        "Contact Name"=>"Narcis Zait",
        "Agreed to CoC?"=>true,
        "Public Event?"=>true,
        "Event Capacity"=>50,
        "Note"=>"duplicate. don't publish",
        "Reviewed By"=>"ST",
        "Replied"=>"batch email 10/5",
        "Submitted Time"=>"2019-10-02T19:28:05.000Z",
        "Event Start Date/Time (Real)"=>"10/21/2019 "}
      ]
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
            identify and label any spammy PRs as **invalid**. If your PRs are not
            marked invalid during that window,
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
    end
  end
end
