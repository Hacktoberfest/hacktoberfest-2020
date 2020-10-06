# frozen_string_literal: true

require 'rails_helper'

RSpec::Matchers.define :string_excluding do |regex|
  match { |actual| (regex =~ actual).blank? }
end

RSpec.describe HacktoberfestProjectFetcher do
  describe '#fetch!' do
    it 'returns query results in the correct format' do
      repo_topic_name = 'hacktoberfest'
      repo_code_of_conduct_url = 'https://example.com/code_of_conduct'
      repo_database_id = 9876
      repo_description = 'some clear repo description'
      repo_forks = 1
      repo_language = 'Java'
      repo_name = 'repo'
      repo_name_with_owner = "owner/#{repo_name}"
      repo_stars = 2
      repo_url = "https://github.com/#{repo_name_with_owner}"
      repo_watchers = 3
      issue_database_id = 1111
      issue_number = 13
      issue_participants = 4
      issue_timeline_events = 5
      issue_title = 'Something is broken'
      issue_url = "#{repo_url}/issues/#{issue_number}"
      has_next_page = false
      json_response = <<~JSON_RESPONSE_BODY
        {
          "data": {
            "rateLimit": {
              "cost": 1,
              "limit": 5000,
              "remaining": 4999,
              "resetAt": "2017-09-20T15:45:52Z"
            },
            "search": {
              "issueCount": 1,
              "pageInfo": {
                "endCursor": "someCursor",
                "hasNextPage": #{has_next_page}
              },
              "edges": [
                {
                  "node": {
                    "bodyText": "issue body",
                    "databaseId": #{issue_database_id},
                    "number": #{issue_number},
                    "title": "#{issue_title}",
                    "url": "#{issue_url}",
                    "participants": {
                      "totalCount": #{issue_participants}
                    },
                    "timeline": {
                      "totalCount": #{issue_timeline_events}
                    },
                    "repository": {
                      "databaseId": #{repo_database_id},
                      "description": "#{repo_description}",
                      "name": "#{repo_name}",
                      "nameWithOwner": "#{repo_name_with_owner}",
                      "url": "#{repo_url}",
                      "primaryLanguage": {
                        "name": "#{repo_language}"
                      },
                      "stargazers": {
                        "totalCount": #{repo_stars}
                      },
                      "watchers": {
                        "totalCount": #{repo_watchers}
                      },
                      "forks": {
                        "totalCount": #{repo_forks}
                      },
                      "codeOfConduct": {
                        "url": "#{repo_code_of_conduct_url}"
                      },
                      "repositoryTopics": {
                        "edges": [
                          {
                            "node": {
                              "topic": {
                                "name": "#{repo_topic_name}"
                              }
                            }
                          }
                        ]
                      }
                    }
                  }
                }
              ]
            }
          }
        }
      JSON_RESPONSE_BODY
      response = double(:response, body: json_response)
      client = Hacktoberfest.client
      allow(client).to receive(:post).and_return(response)
      client = GithubGraphqlApiClient.new(access_token: '123', client: client)
      fetcher = HacktoberfestProjectFetcher.new(api_client: client)

      fetcher.fetch!

      expect(fetcher.projects).to eq [
        {
          issue_database_id: issue_database_id,
          issue_number: issue_number,
          issue_participants: issue_participants,
          issue_timeline_events: issue_timeline_events,
          issue_title: issue_title,
          issue_url: issue_url,
          repo_code_of_conduct_url: repo_code_of_conduct_url,
          repo_database_id: repo_database_id,
          repo_description: repo_description,
          repo_forks: repo_forks,
          repo_language: repo_language,
          repo_name: repo_name,
          repo_name_with_owner: repo_name_with_owner,
          repo_stars: repo_stars,
          repo_url: repo_url,
          repo_watchers: repo_watchers,
          repo_topics: { 'edges' => [
            { 'node' => { 'topic' => { 'name' => repo_topic_name } } }
          ] }
        }
      ]
    end

    context 'When there are multiple pages of results' do
      it 'paginates over the results and returns the aggregated result' do
        repo_topic_name = 'hacktoberfest'
        repo_code_of_conduct_url = 'https://example.com/code_of_conduct'
        repo_database_id = 9876
        repo_description = 'some repo description'
        repo_forks = 1
        repo_language = 'Java'
        repo_name = 'repo'
        repo_name_with_owner = "owner/#{repo_name}"
        repo_stars = 2
        repo_watchers = 3
        repo_url = "https://github.com/#{repo_name_with_owner}"
        issue_database_id1 = 1111
        issue_database_id2 = 2222
        issue_number = 13
        issue_participants = 4
        issue_timeline_events = 5
        issue_title = 'Something is broken'
        issue_url = "#{repo_url}/issues/#{issue_number}"
        has_next_page1 = true
        has_next_page2 = false
        end_cursor1 = 'someEndCursorToUse'
        end_cursor2 = 'someEndCursorToIgnore'
        first_json_response_body = <<~FIRST_JSON_RESPONSE_BODY
          {
            "data": {
              "rateLimit": {
                "cost": 1,
                "limit": 5000,
                "remaining": 4999,
                "resetAt": "2017-09-11T21:30:28Z"
              },
              "search": {
                "issueCount": 2,
                "pageInfo": {
                  "endCursor": "#{end_cursor1}",
                  "hasNextPage": #{has_next_page1}
                },
                "edges": [
                  {
                    "node": {
                      "bodyText": "issue body",
                      "databaseId": #{issue_database_id1},
                      "number": #{issue_number},
                      "title": "#{issue_title}",
                      "url": "#{issue_url}",
                      "participants": {
                        "totalCount": #{issue_participants}
                      },
                      "timeline": {
                        "totalCount": #{issue_timeline_events}
                      },
                      "repository": {
                        "databaseId": #{repo_database_id},
                        "description": "#{repo_description}",
                        "name": "#{repo_name}",
                        "nameWithOwner": "#{repo_name_with_owner}",
                        "url": "#{repo_url}",
                        "primaryLanguage": {
                          "name": "#{repo_language}"
                        },
                        "stargazers": {
                          "totalCount": #{repo_stars}
                        },
                        "watchers": {
                          "totalCount": #{repo_watchers}
                        },
                        "forks": {
                          "totalCount": #{repo_forks}
                        },
                        "codeOfConduct": {
                          "url": "#{repo_code_of_conduct_url}"
                        },
                        "repositoryTopics": {
                          "edges": [
                            {
                              "node": {
                                "topic": {
                                  "name": "#{repo_topic_name}"
                                }
                              }
                            }
                          ]
                        }
                      }
                    }
                  }
                ]
              }
            }
          }
        FIRST_JSON_RESPONSE_BODY
        second_json_response_body = <<~SECOND_JSON_RESPONSE_BODY
          {
            "data": {
              "rateLimit": {
                "cost": 1,
                "limit": 5000,
                "remaining": 4998,
                "resetAt": "2017-09-11T21:30:28Z"
              },
              "search": {
                "issueCount": 2,
                "pageInfo": {
                  "endCursor": "#{end_cursor2}",
                  "hasNextPage": #{has_next_page2}
                },
                "edges": [
                  {
                    "node": {
                      "bodyText": "issue body",
                      "databaseId": #{issue_database_id2},
                      "number": #{issue_number},
                      "title": "#{issue_title}",
                      "url": "#{issue_url}",
                      "participants": {
                        "totalCount": #{issue_participants}
                      },
                      "timeline": {
                        "totalCount": #{issue_timeline_events}
                      },
                      "repository": {
                        "databaseId": #{repo_database_id},
                        "description": "#{repo_description}",
                        "name": "#{repo_name}",
                        "nameWithOwner": "#{repo_name_with_owner}",
                        "url": "#{repo_url}",
                        "primaryLanguage": {
                          "name": "#{repo_language}"
                        },
                        "stargazers": {
                          "totalCount": #{repo_stars}
                        },
                        "watchers": {
                          "totalCount": #{repo_watchers}
                        },
                        "forks": {
                          "totalCount": #{repo_forks}
                        },
                        "codeOfConduct": {
                          "url": "#{repo_code_of_conduct_url}"
                        },
                        "repositoryTopics": {
                          "edges": [
                            {
                              "node": {
                                "topic": {
                                  "name": "#{repo_topic_name}"
                                }
                              }
                            }
                          ]
                        }
                      }
                    }
                  }
                ]
              }
            }
          }
        SECOND_JSON_RESPONSE_BODY
        first_response = double(:response, body: first_json_response_body)
        second_response = double(:response, body: second_json_response_body)
        client = Hacktoberfest.client
        allow(client).to receive(:post)
          .with(anything, string_excluding(/#{end_cursor1}/), anything)
          .and_return(first_response)
        allow(client).to receive(:post)
          .with(anything, /#{end_cursor1}/, anything)
          .and_return(second_response)
        api_client = GithubGraphqlApiClient.new(
          access_token: '123',
          client: client
        )
        fetcher = HacktoberfestProjectFetcher.new(api_client: api_client)

        fetcher.fetch!

        expect(fetcher.projects).to eq [
          {
            issue_database_id: issue_database_id1,
            issue_number: issue_number,
            issue_participants: issue_participants,
            issue_timeline_events: issue_timeline_events,
            issue_title: issue_title,
            issue_url: issue_url,
            repo_code_of_conduct_url: repo_code_of_conduct_url,
            repo_database_id: repo_database_id,
            repo_description: repo_description,
            repo_forks: repo_forks,
            repo_language: repo_language,
            repo_name: repo_name,
            repo_name_with_owner: repo_name_with_owner,
            repo_stars: repo_stars,
            repo_url: repo_url,
            repo_watchers: repo_watchers,
            repo_topics: { 'edges' => [
              { 'node' => { 'topic' => { 'name' => repo_topic_name } } }
            ] }
          },
          {
            issue_database_id: issue_database_id2,
            issue_number: issue_number,
            issue_participants: issue_participants,
            issue_timeline_events: issue_timeline_events,
            issue_title: issue_title,
            issue_url: issue_url,
            repo_code_of_conduct_url: repo_code_of_conduct_url,
            repo_database_id: repo_database_id,
            repo_description: repo_description,
            repo_forks: repo_forks,
            repo_language: repo_language,
            repo_name: repo_name,
            repo_name_with_owner: repo_name_with_owner,
            repo_stars: repo_stars,
            repo_url: repo_url,
            repo_watchers: repo_watchers,
            repo_topics: { 'edges' => [
              { 'node' => { 'topic' => { 'name' => repo_topic_name } } }
            ] }
          }
        ]
      end
    end

    context 'When data for the first request is blank' do
      it 'stops processing' do
        bad_response_data = {
          'data' => nil
        }
        api_client = double(:api_client)
        allow(api_client).to receive(:request).and_return(bad_response_data)
        fetcher = HacktoberfestProjectFetcher.new(api_client: api_client)

        expect { fetcher.fetch! }
          .to raise_error(HacktoberfestProjectFetcherError)

        expect(fetcher.projects.count).to eq 0
      end
    end

    context 'When data for a subsequent request is blank' do
      it 'stops processing after the blank request' do
        good_response_data = {
          'data' => {
            'rateLimit' => {
              'cost' => 1,
              'limit' => 5000,
              'remaining' => 4999,
              'resetAt' => '2017-09-11T21:30:28Z'
            },
            'search' => {
              'issueCount' => 1,
              'pageInfo' => {
                'endCursor' => 'someCursor',
                'hasNextPage' => true
              },
              'edges' => [
                {
                  'node' => {
                    'bodyText' => 'issue body',
                    'databaseId' => 123,
                    'number' => 1,
                    'title' => 'title',
                    'url' => 'https://github.com/owner/repo/issues/1',
                    'participants' => {
                      'totalCount' => 1
                    },
                    'timeline' => {
                      'totalCount' => 1
                    },
                    'repository' => {
                      'databaseId' => 987,
                      'description' => 'description',
                      'name' => 'repo',
                      'nameWithOwner' => 'owner/repo',
                      'url' => 'https://github.com/owner/repo',
                      'primaryLanguage' => {
                        'name' => 'Java'
                      },
                      'stargazers' => {
                        'totalCount' => 1
                      },
                      'watchers' => {
                        'totalCount' => 1
                      },
                      'forks' => {
                        'totalCount' => 1
                      },
                      'codeOfConduct' => {
                        'url' => 'https://example.com/code_of_conduct'
                      },
                      'repositoryTopics' => {
                        'edges' => [
                          {
                            'node' => {
                              'topic' => {
                                'name' => 'hacktoberfest'
                              }
                            }
                          }
                        ]
                      }
                    }
                  }
                }
              ]
            }
          }
        }
        bad_response_data = {
          'data' => nil
        }
        api_client = double(:api_client)
        allow(api_client).to receive(:request)
          .and_return(good_response_data, bad_response_data)
        fetcher = HacktoberfestProjectFetcher.new(api_client: api_client)

        expect { fetcher.fetch! }
          .to raise_error(HacktoberfestProjectFetcherError)

        expect(fetcher.projects.count).to eq 1
      end
    end

    context 'When errors are returned' do
      it 'raises an exception with the errors and the query' do
        query = 'some query that will return errors'
        allow(HacktoberfestProjectQueryComposer).to receive(:compose)
          .and_return(query)
        errors = [
          { 'message' => 'doh' },
          { 'message' => 'derp' }
        ]
        bad_response_data = {
          'data' => nil,
          'errors' => errors
        }
        api_client = double(:api_client)
        allow(api_client).to receive(:request).and_return(bad_response_data)
        expected_error_message = 'Invalid response received'
        error = HacktoberfestProjectFetcherError.new(
          expected_error_message,
          errors: errors,
          query: query
        )
        allow(HacktoberfestProjectFetcherError).to receive(:new)
          .and_return(error)

        fetcher = HacktoberfestProjectFetcher.new(api_client: api_client)

        expect { fetcher.fetch! }
          .to raise_error(HacktoberfestProjectFetcherError)
        expect(HacktoberfestProjectFetcherError).to have_received(:new)
          .with(
            expected_error_message,
            errors: errors,
            query: query
          )
      end
    end

    context 'When an issue is blank' do
      it 'skips the issue and continues' do
        response_data = {
          'data' => {
            'rateLimit' => {
              'cost' => 1,
              'limit' => 5000,
              'remaining' => 4999,
              'resetAt' => '2017-09-11T21:30:28Z'
            },
            'search' => {
              'issueCount' => 1,
              'pageInfo' => {
                'endCursor' => 'someCursor',
                'hasNextPage' => false
              },
              'edges' => [
                {
                  'node' => {
                    'bodyText' => 'issue body',
                    'databaseId' => 123,
                    'number' => 1,
                    'title' => 'title 1',
                    'url' => 'https://github.com/owner/repo/issues/1',
                    'participants' => {
                      'totalCount' => 1
                    },
                    'timeline' => {
                      'totalCount' => 1
                    },
                    'repository' => {
                      'databaseId' => 987,
                      'name' => 'repo',
                      'nameWithOwner' => 'owner/repo',
                      'description' => 'description',
                      'url' => 'https://github.com/owner/repo',
                      'primaryLanguage' => {
                        'name' => 'Java'
                      },
                      'stargazers' => {
                        'totalCount' => 1
                      },
                      'watchers' => {
                        'totalCount' => 1
                      },
                      'forks' => {
                        'totalCount' => 1
                      },
                      'codeOfConduct' => {
                        'url' => 'https://example.com/code_of_conduct'
                      },
                      'repositoryTopics' => {
                        'edges' => [
                          {
                            'node' => {
                              'topic' => {
                                'name' => 'hacktoberfest'
                              }
                            }
                          }
                        ]
                      }
                    }
                  }
                },
                {
                  'node' => nil
                },
                {
                  'node' => {
                    'bodyText' => 'issue body',
                    'databaseId' => 124,
                    'number' => 2,
                    'title' => 'title 2',
                    'url' => 'https://github.com/owner/repo/issues/2',
                    'participants' => {
                      'totalCount' => 1
                    },
                    'timeline' => {
                      'totalCount' => 1
                    },
                    'repository' => {
                      'databaseId' => 987,
                      'name' => 'repo',
                      'nameWithOwner' => 'owner/repo',
                      'description' => 'description',
                      'url' => 'https://github.com/owner/repo',
                      'primaryLanguage' => {
                        'name' => 'Java'
                      },
                      'stargazers' => {
                        'totalCount' => 1
                      },
                      'watchers' => {
                        'totalCount' => 1
                      },
                      'forks' => {
                        'totalCount' => 1
                      },
                      'codeOfConduct' => {
                        'url' => 'https://example.com/code_of_conduct'
                      },
                      'repositoryTopics' => {
                        'edges' => [
                          {
                            'node' => {
                              'topic' => {
                                'name' => 'hacktoberfest'
                              }
                            }
                          }
                        ]
                      }
                    }
                  }
                }
              ]
            }
          }
        }
        api_client = double(:api_client)
        allow(api_client).to receive(:request).and_return(response_data)
        fetcher = HacktoberfestProjectFetcher.new(api_client: api_client)

        fetcher.fetch!

        expect(fetcher.projects.count).to eq 2
      end
    end

    context 'When a repo language is blank' do
      it 'skips the issue and continues' do
        response_data = {
          'data' => {
            'rateLimit' => {
              'cost' => 1,
              'limit' => 5000,
              'remaining' => 4999,
              'resetAt' => '2017-09-11T21:30:28Z'
            },
            'search' => {
              'issueCount' => 1,
              'pageInfo' => {
                'endCursor' => 'someCursor',
                'hasNextPage' => false
              },
              'edges' => [
                {
                  'node' => {
                    'bodyText' => 'issue body',
                    'databaseId' => 123,
                    'title' => 'title',
                    'number' => 1,
                    'url' => 'https://github.com/owner/repoWithoutLanguage/issues/1',
                    'participants' => {
                      'totalCount' => 1
                    },
                    'timeline' => {
                      'totalCount' => 1
                    },
                    'repository' => {
                      'databaseId' => 321,
                      'name' => 'repoWithoutLanguage',
                      'nameWithOwner' => 'owner/repoWithoutLanguage',
                      'description' => 'description',
                      'url' => 'https://github.com/owner/repoWithoutLanguage',
                      'primaryLanguage' => nil,
                      'stargazers' => {
                        'totalCount' => 1
                      },
                      'watchers' => {
                        'totalCount' => 1
                      },
                      'forks' => {
                        'totalCount' => 1
                      },
                      'codeOfConduct' => {
                        'url' => 'https://example.com/code_of_conduct'
                      },
                      'repositoryTopics' => {
                        'edges' => [
                          {
                            'node' => {
                              'topic' => {
                                'name' => 'hacktoberfest'
                              }
                            }
                          }
                        ]
                      }
                    }
                  }
                },
                {
                  'node' => {
                    'bodyText' => 'issue body',
                    'databaseId' => 456,
                    'title' => 'title',
                    'number' => 4,
                    'url' => 'https://github.com/owner/javaRepo/issues/999',
                    'participants' => {
                      'totalCount' => 1
                    },
                    'timeline' => {
                      'totalCount' => 1
                    },
                    'repository' => {
                      'databaseId' => 654,
                      'name' => 'javaRepo',
                      'nameWithOwner' => 'owner/javaRepo',
                      'description' => 'description',
                      'url' => 'https://github.com/owner/javaRepo',
                      'primaryLanguage' => {
                        'name' => 'Java'
                      },
                      'stargazers' => {
                        'totalCount' => 1
                      },
                      'watchers' => {
                        'totalCount' => 1
                      },
                      'forks' => {
                        'totalCount' => 1
                      },
                      'codeOfConduct' => {
                        'url' => 'https://example.com/code_of_conduct'
                      },
                      'repositoryTopics' => {
                        'edges' => [
                          {
                            'node' => {
                              'topic' => {
                                'name' => 'hacktoberfest'
                              }
                            }
                          }
                        ]
                      }
                    }
                  }
                }
              ]
            }
          }
        }
        api_client = double(:api_client)
        allow(api_client).to receive(:request).and_return(response_data)
        fetcher = HacktoberfestProjectFetcher.new(api_client: api_client)

        fetcher.fetch!

        expect(fetcher.projects.count).to eq 1
      end
    end

    context 'When a repo description is blank' do
      it 'skips the issue and continues' do
        response_data = {
          'data' => {
            'rateLimit' => {
              'cost' => 1,
              'limit' => 5000,
              'remaining' => 4999,
              'resetAt' => '2017-09-11T21:30:28Z'
            },
            'search' => {
              'issueCount' => 1,
              'pageInfo' => {
                'endCursor' => 'someCursor',
                'hasNextPage' => false
              },
              'edges' => [
                {
                  'node' => {
                    'bodyText' => 'issue body',
                    'databaseId' => 123,
                    'title' => 'title',
                    'number' => 1,
                    'url' => 'https://github.com/owner/repoWithNilDescription/issues/1',
                    'participants' => {
                      'totalCount' => 1
                    },
                    'timeline' => {
                      'totalCount' => 1
                    },
                    'repository' => {
                      'databaseId' => 321,
                      'name' => 'repoWithNilDescription',
                      'nameWithOwner' => 'owner/repoWithNilDescription',
                      'description' => nil,
                      'url' => 'https://github.com/owner/repoWithNilDescription',
                      'primaryLanguage' => {
                        'name' => 'Ruby'
                      },
                      'stargazers' => {
                        'totalCount' => 1
                      },
                      'watchers' => {
                        'totalCount' => 1
                      },
                      'forks' => {
                        'totalCount' => 1
                      },
                      'codeOfConduct' => {
                        'url' => 'https://example.com/code_of_conduct'
                      },
                      'repositoryTopics' => {
                        'edges' => [
                          {
                            'node' => {
                              'topic' => {
                                'name' => 'hacktoberfest'
                              }
                            }
                          }
                        ]
                      }
                    }
                  }
                },
                {
                  'node' => {
                    'bodyText' => 'issue body',
                    'databaseId' => 124,
                    'title' => 'title',
                    'number' => 2,
                    'url' => 'https://github.com/owner/repoWithBlankDescription/issues/2',
                    'participants' => {
                      'totalCount' => 1
                    },
                    'timeline' => {
                      'totalCount' => 1
                    },
                    'repository' => {
                      'databaseId' => 322,
                      'name' => 'repoWithBlankDescription',
                      'nameWithOwner' => 'owner/repoWithBlankDescription',
                      'description' => '',
                      'url' => 'https://github.com/owner/repoWithBlankDescription',
                      'primaryLanguage' => {
                        'name' => 'Ruby'
                      },
                      'stargazers' => {
                        'totalCount' => 1
                      },
                      'watchers' => {
                        'totalCount' => 1
                      },
                      'forks' => {
                        'totalCount' => 1
                      },
                      'codeOfConduct' => {
                        'url' => 'https://example.com/code_of_conduct'
                      },
                      'repositoryTopics' => {
                        'edges' => [
                          {
                            'node' => {
                              'topic' => {
                                'name' => 'hacktoberfest'
                              }
                            }
                          }
                        ]
                      }
                    }
                  }
                },
                {
                  'node' => {
                    'bodyText' => 'issue body',
                    'databaseId' => 456,
                    'title' => 'title',
                    'number' => 4,
                    'url' => 'https://github.com/owner/javaRepo/issues/999',
                    'participants' => {
                      'totalCount' => 1
                    },
                    'timeline' => {
                      'totalCount' => 1
                    },
                    'repository' => {
                      'databaseId' => 654,
                      'name' => 'javaRepo',
                      'nameWithOwner' => 'owner/javaRepo',
                      'description' => 'description',
                      'url' => 'https://github.com/owner/javaRepo',
                      'primaryLanguage' => {
                        'name' => 'Java'
                      },
                      'stargazers' => {
                        'totalCount' => 1
                      },
                      'watchers' => {
                        'totalCount' => 1
                      },
                      'forks' => {
                        'totalCount' => 1
                      },
                      'codeOfConduct' => {
                        'url' => 'https://example.com/code_of_conduct'
                      },
                      'repositoryTopics' => {
                        'edges' => [
                          {
                            'node' => {
                              'topic' => {
                                'name' => 'hacktoberfest'
                              }
                            }
                          }
                        ]
                      }
                    }
                  }
                }
              ]
            }
          }
        }
        api_client = double(:api_client)
        allow(api_client).to receive(:request).and_return(response_data)
        fetcher = HacktoberfestProjectFetcher.new(api_client: api_client)

        fetcher.fetch!

        expect(fetcher.projects.count).to eq 1
      end
    end

    context 'When an issue body is blank' do
      it 'skips the issue and continues' do
        response_data = {
          'data' => {
            'rateLimit' => {
              'cost' => 1,
              'limit' => 5000,
              'remaining' => 4999,
              'resetAt' => '2017-09-11T21:30:28Z'
            },
            'search' => {
              'issueCount' => 1,
              'pageInfo' => {
                'endCursor' => 'someCursor',
                'hasNextPage' => false
              },
              'edges' => [
                {
                  'node' => {
                    'bodyText' => '',
                    'databaseId' => 123,
                    'title' => 'Issue without a body',
                    'number' => 1,
                    'url' => 'https://github.com/owner/repo/issues/1',
                    'repository' => {
                      'databaseId' => 321,
                      'name' => 'repo',
                      'nameWithOwner' => 'owner/repo',
                      'description' => 'description',
                      'url' => 'https://github.com/owner/repo',
                      'primaryLanguage' => 'Ruby'
                    }
                  }
                },
                {
                  'node' => {
                    'bodyText' => 'issue body',
                    'databaseId' => 456,
                    'title' => 'title',
                    'number' => 999,
                    'url' => 'https://github.com/owner/javaRepo/issues/999',
                    'participants' => {
                      'totalCount' => 1
                    },
                    'timeline' => {
                      'totalCount' => 1
                    },
                    'repository' => {
                      'databaseId' => 654,
                      'name' => 'javaRepo',
                      'nameWithOwner' => 'owner/javaRepo',
                      'description' => 'description',
                      'url' => 'https://github.com/owner/javaRepo',
                      'primaryLanguage' => {
                        'name' => 'Java'
                      },
                      'stargazers' => {
                        'totalCount' => 1
                      },
                      'watchers' => {
                        'totalCount' => 1
                      },
                      'forks' => {
                        'totalCount' => 1
                      },
                      'codeOfConduct' => {
                        'url' => 'https://example.com/code_of_conduct'
                      },
                      'repositoryTopics' => {
                        'edges' => [
                          {
                            'node' => {
                              'topic' => {
                                'name' => 'hacktoberfest'
                              }
                            }
                          }
                        ]
                      }
                    }
                  }
                }
              ]
            }
          }
        }
        api_client = double(:api_client)
        allow(api_client).to receive(:request).and_return(response_data)
        fetcher = HacktoberfestProjectFetcher.new(api_client: api_client)

        fetcher.fetch!

        expect(fetcher.projects.count).to eq 1
      end
    end
  end
end
