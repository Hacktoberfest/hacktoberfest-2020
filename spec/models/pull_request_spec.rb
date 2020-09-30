# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PullRequest, type: :model do
  describe '#labelled_invalid?' do
    context 'Pull request has a label for "invalid"' do
      let(:pr) { pr_helper(INVALID_LABEL_PR) }

      it 'is considered labelled invalid' do
        expect(pr.labelled_invalid?).to eq(true)
      end

      context 'Pull request is merged' do
        let(:pr) { pr_helper(INVALID_LABEL_PR.merge('merged' => true)) }

        it 'is not considered labelled invalid' do
          expect(pr.labelled_invalid?).to eq(false)
        end
      end
    end

    context 'Pull request has a label for "❌ Invalid"' do
      let(:pr) { pr_helper(INVALID_EMOJI_LABEL_PR) }

      it 'is considered labelled invalid' do
        expect(pr.labelled_invalid?).to eq(true)
      end

      context 'Pull request is merged' do
        let(:pr) { pr_helper(INVALID_EMOJI_LABEL_PR.merge('merged' => true)) }

        it 'is not considered labelled invalid' do
          expect(pr.labelled_invalid?).to eq(false)
        end
      end
    end

    context 'Pull request has a label for "Spam"' do
      let(:pr) { pr_helper(SPAM_LABEL_PR) }

      it 'is considered labelled invalid' do
        expect(pr.labelled_invalid?).to eq(true)
      end

      context 'Pull request is merged' do
        let(:pr) { pr_helper(SPAM_LABEL_PR.merge('merged' => true)) }

        it 'is not considered labelled invalid' do
          expect(pr.labelled_invalid?).to eq(false)
        end
      end
    end

    context 'Pull request has a label for "This is a spam PR"' do
      let(:pr) { pr_helper(LONG_SPAM_LABEL_PR) }

      it 'is considered labelled invalid' do
        expect(pr.labelled_invalid?).to eq(true)
      end

      context 'Pull request is merged' do
        let(:pr) { pr_helper(LONG_SPAM_LABEL_PR.merge('merged' => true)) }

        it 'is not considered labelled invalid' do
          expect(pr.labelled_invalid?).to eq(false)
        end
      end
    end

    context 'Pull request has no labels' do
      let(:pr) { pr_helper(ELIGIBLE_PR) }

      it 'is not considered labelled invalid' do
        expect(pr.labelled_invalid?).to eq(false)
      end
    end
  end

  describe '#spam_repo' do
    # TODO: need to stub SpamRepositoryService
    # PR is in spam repo initially
    # PR is waiting, then becomes in spam repo
    # PR is eligible, then becomes in spam repo
  end

  describe '#invalid_label' do
    context 'Pull request is labelled invalid initially' do
      let(:pr) { pr_helper(INVALID_LABEL_PR) }

      it 'is put it in the invalid_label state' do
        expect(pr.state).to eq('invalid_label')
      end
    end

    context 'Pull request is waiting' do
      let(:pr) { pr_helper(IMMATURE_PR) }

      it 'is in the waiting state initially' do
        expect(pr.state).to eq('waiting')
      end

      context 'Pull request becomes labelled invalid' do
        before do
          stub_helper(pr, INVALID_LABEL_PR, 'id' => pr.github_id)
          pr.check_state
        end

        it 'is put it in the invalid_label state' do
          expect(pr.state).to eq('invalid_label')
        end

        context 'Seven days pass from pull request creation' do
          before do
            travel_to pr.waiting_since + 7.days
            pr.check_state
          end

          it 'remains in the invalid_label state' do
            expect(pr.state).to eq('invalid_label')
          end

          after { travel_back }
        end
      end
    end

    context 'Pull request is eligible' do
      let(:pr) { pr_helper(ELIGIBLE_PR) }

      it 'is in the eligible state initially' do
        expect(pr.state).to eq('eligible')
      end

      context 'Pull request becomes labelled invalid' do
        before do
          stub_helper(pr, INVALID_LABEL_PR, 'id' => pr.github_id)
          pr.check_state
        end

        it 'remains in the eligible state' do
          expect(pr.state).to eq('eligible')
        end
      end
    end
  end

  describe '#waiting' do
    context 'Pull request is valid and created less than seven days ago' do
      let(:pr) { pr_helper(IMMATURE_PR) }

      it 'is put it in the waiting state' do
        expect(pr.state).to eq('waiting')
      end

      it 'has the waiting_since date set to the created date' do
        expect(pr.waiting_since).to eq(pr.created_at)
      end
    end

    context 'Pull request is in an invalid repo initially' do
      # TODO: need to stub SpamRepositoryService
    end

    context 'Pull request is labelled invalid initially' do
      let(:pr) { pr_helper(INVALID_LABEL_PR) }

      it 'is in the invalid_label state initially' do
        expect(pr.state).to eq('invalid_label')
      end

      it 'has no set waiting_since' do
        expect(pr.waiting_since).to be_nil
      end

      context 'Pull request has invalid label removed' do
        before do
          freeze_time

          stub_helper(pr, IMMATURE_PR, 'id' => pr.github_id)
          pr.check_state
        end

        it 'is put it in the waiting state' do
          expect(pr.state).to eq('waiting')
        end

        it 'has the waiting_since date set to now' do
          expect(pr.waiting_since).to eq(Time.zone.now)
          expect(pr.waiting_since).to_not eq(pr.created_at)
        end

        after { travel_back }
      end
    end

    context 'Pull request is labelled invalid initially' do
      let(:pr) { pr_helper(INVALID_LABEL_PR) }

      it 'is in the invalid_label state initially' do
        expect(pr.state).to eq('invalid_label')
      end

      it 'has no set waiting_since' do
        expect(pr.waiting_since).to be_nil
      end

      context 'Pull request is merged' do
        before do
          freeze_time

          stub_helper(pr, IMMATURE_INVALID_MERGED_PR, 'id' => pr.github_id)
          pr.check_state
        end

        it 'is put it in the waiting state' do
          expect(pr.state).to eq('waiting')
        end

        it 'has the waiting_since date set to now' do
          expect(pr.waiting_since).to eq(Time.zone.now)
          expect(pr.waiting_since).to_not eq(pr.created_at)
        end

        after { travel_back }
      end
    end
  end

  describe '#eligible' do
    context 'Pull request is valid and created over seven days ago' do
      let(:pr) { pr_helper(ELIGIBLE_PR) }

      it 'is put it in the eligible state' do
        expect(pr.state).to eq('eligible')
      end
    end

    context 'Pull request is valid and created less than seven days ago' do
      let(:pr) { pr_helper(IMMATURE_PR) }

      it 'is put it in the waiting state' do
        expect(pr.state).to eq('waiting')
      end

      it 'has the waiting_since date set to the created date' do
        expect(pr.waiting_since).to eq(pr.created_at)
      end

      context 'Seven days pass from pull request creation' do
        before do
          travel_to pr.waiting_since + 7.days
          pr.check_state
        end

        it 'is put it in the eligible state' do
          expect(pr.state).to eq('eligible')
        end

        after { travel_back }
      end
    end
  end

  def pr_helper(hash)
    PullRequest.delete_all
    PullRequest.from_github_pull_request(github_pull_request(hash))
  end

  def stub_helper(target, hash, merge = {})
    allow(target).to receive(:github_pull_request)
      .and_return(github_pull_request(hash.merge(merge)))
  end
end
