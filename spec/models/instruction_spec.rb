# == Schema Information
#
# Table name: instructions
#
#  id          :integer          not null, primary key
#  sequence_id :integer
#  number      :integer
#  phrase      :text
#  duration    :double precision
#  created_at  :timestamp withou
#  updated_at  :timestamp withou
#
# Indexes
#
#  index_instructions_on_sequence_id  (sequence_id)
#

require 'spec_helper'

describe Instruction do

  let(:instruction){Instruction.new}

  describe 'relations and properties' do
    it{ should serialize(:color).as ColorSerializer }
    it{ should serialize(:background_color).as ColorSerializer}
  end

  it 'should have color attribute' do
    instruction.color = Color::RGB::Red
    instruction.color.should == Color::RGB::Red
  end

  describe '#fade_time' do
    it 'should default to 72 seconds' do
      instruction.fade_time.should == 72
    end
  end

  describe '#init' do

    describe 'sets defaults' do
      it 'should have default background color' do
        instruction.background_color.should == Color::RGB::Black
      end

      it 'should have default color' do
        instruction.color.should == Color::RGB::White
      end
    end
  end

  describe '#phrase' do
    it 'should store phrase' do
      instruction.phrase = 'Hello there Guy'
      instruction.phrase.should == 'HELLO THERE GUY'
    end
  end

  describe '#tempo' do
    it 'should default to 60' do
      instruction.tempo.should == 60
    end
  end
end
