require 'spec_helper'

describe ApplicationHelper do

  describe '#flash_class' do
    it{expect(helper.flash_class(:notice)).to eq('alert-info')}
    it{expect(helper.flash_class(:success)).to eq('alert-success')}
    it{expect(helper.flash_class(:error)).to eq('alert-danger')}
    it{expect(helper.flash_class(:alert)).to eq('alert-warning')}
    it 'should raise an exception if level is unknown' do
      expect{helper.flash_class(:poop)}.to raise_error
    end

  end
end
