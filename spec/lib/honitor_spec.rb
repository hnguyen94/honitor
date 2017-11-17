require 'spec_helper'

describe Honitor do
  before do
    allow($stdout).to receive(:puts)
  end

  describe '#read_config' do
    it 'reads a yaml file and parses the content in user config' do
      cfg_file = YAML.load_file('config.yml')
      cfg = cfg_file['config']

      Honitor.read_config

      expect(described_class.instance_variable_get(:@user_config)).to eq(UserConfig.new(cfg))
    end
  end

  describe '#switch_log' do
    it 'redirects the STDOUT to log file if log config is true' do
      expect($stdout).to receive(:reopen)

      Honitor.switch_log(TEST_CONFIG.log)
    end
  end

  describe '#check_changes' do
    it 'checks for changes' do
      expect(Honitor).to receive(:loop).and_yield.twice
      expect(Honitor).to receive(:sleep).twice
      Honitor.instance_variable_set(:@user_config, TEST_CONFIG)

      Honitor.check_changes

      expect(Honitor.instance_variable_get(:@current_dom_objects)).to eq(['1', '2', '3', '4', '5', '6', '7', '8', '9'])
  
      reset_test_file_after do
        add_line_to_test_file

        Honitor.check_changes
      end

      expect(Honitor.instance_variable_get(:@current_dom_objects)).to eq(['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'])
    end
  end

  describe '#prepare_message' do
    context 'prepares a message, depending if there are new contents' do
      before(:each) do
        Honitor.instance_variable_set(:@user_config, TEST_CONFIG)
      end

      after(:each) do
        Honitor.prepare_message
      end

      it 'has no new contents' do
        items = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
        Honitor.instance_variable_set(:@current_dom_objects, items)
        Honitor.instance_variable_set(:@old_dom_objects, items)

        expect($stdout).to receive(:puts).with(HonitorHelpers::Log.show_time.to_s.green + " Found #{ items.count } items || " + 'No changes'.yellow)
        expect($stdout).to receive(:puts).with(items)
      end

      it 'has new contents' do
        old_items = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
        new_items = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']

        Honitor.instance_variable_set(:@no_changes, false)
        Honitor.instance_variable_set(:@old_dom_objects, old_items)
        Honitor.instance_variable_set(:@current_dom_objects, new_items)

        expect(PushoverApi).to receive(:send_push_notification)
        expect($stdout).to receive(:puts).with(HonitorHelpers::Log.show_time.to_s.green + " Found new #{(new_items - old_items).count} items || " + 'Sent message!'.blue)
        expect($stdout).to receive(:puts).with(new_items)
      end
    end
  end
end