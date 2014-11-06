require 'spec_helper'
require_relative '../../lib/business_logic/snapshot_delta.rb'

describe SnapshotDelta do
  context '#delta_from' do

    it 'when previous is empty returns everything' do
      previous_checklist_ids_hash = {}
      allow(subject).to receive(:checklist_ids_hash).and_return({1 => true, 3 => true})

      result = subject.delta_from(previous_checklist_ids_hash)
      expect(result).to eq({1 => true, 3 => true})
    end

    it 'subtracts previous' do
      previous_checklist_ids_hash = {1 => true}
      allow(subject).to receive(:checklist_ids_hash).and_return({1 => true, 3 => true})

      result = subject.delta_from(previous_checklist_ids_hash)
      expect(result).to eq({3 => true})
    end

    it 'missing elements in current show up as negatives' do
      previous_checklist_ids_hash = {1 => true, 2 => true}
      allow(subject).to receive(:checklist_ids_hash).and_return({1 => true, 3 => true})

      result = subject.delta_from(previous_checklist_ids_hash)
      expect(result).to eq({-2 => true, 3 => true})
    end
  end
end
