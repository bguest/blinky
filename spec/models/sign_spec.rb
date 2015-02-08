# == Schema Information
#
# Table name: signs
#
#  id               :integer          not null, primary key
#  phrase           :text
#  letter_order     :text
#  created_at       :datetime
#  updated_at       :datetime
#  effects          :integer
#  color            :string(255)
#  background_color :string(255)
#  fade_time        :float
#
# Indexes
#
#  index_signs_on_effects  (effects)
#

require 'spec_helper'

describe Sign do

  let(:sign){Sign.new}

  describe 'relations and properties' do
    it{ should serialize(:color).as ColorSerializer }
    it{ should serialize(:background_color).as ColorSerializer}
    it{ should serialize(:letter_order).as Array}
    it{ should have_many(:letters)}
  end

  it 'should be able to have letters' do
    letter = Letter.new
    sign.letters << letter
    expect(sign.letters.first).to eq(letter)
  end

  it 'should have color attribute' do
    sign.color = Color::RGB::Red
    expect(sign.color).to eq(Color::RGB::Red)
  end

  describe '#add_letters' do
    let(:l1){Letter.new}
    let(:l2){Letter.new}

    before {sign.add_letters(l1,l2)}
    it{expect(l1.number).to eq(0)}
    it{expect(l2.number).to eq(1)}
    it{expect(sign.letters.size).to eq(2)}

    it "should have the correct letter order" do
      expect(sign.letter_order).to eq([0,1])
    end
  end

  describe '#fade_time' do
    it 'should default to 72 seconds' do
      expect(sign.fade_time).to eq(72)
    end
  end

  describe '#init' do

    describe 'sets defaults' do
      it 'should have default background color' do
        expect(Sign.new.background_color).to eq(Color::RGB::Black)
      end

      it 'should have default color' do
        expect(Sign.new.color).to eq(Color::RGB::White)
      end
    end

    context 'when adding letters directly' do
      let(:l1){Letter.new}
      let(:l2){Letter.new}
      before do
        @sign = Sign.new(letters:[l1,l2])
      end
      it{expect(l1.number).to eq(0)}
      it{expect(l2.number).to eq(1)}
      it{expect(@sign.letter_order).to eq([0,1])}
    end
  end

  describe '#letter_order' do

    it 'should not overwrite existing order' do
      s = Sign.new(letter_order:[1,2])
      expect(s.letter_order).to eq([1,2])
    end

    it 'should be able to store letter order' do
      l = Sign.new
      l.letter_order = [1,2,4,5]
      expect(l.letter_order).to eq([1,2,4,5])
    end
  end

  describe '#ordered_segments' do
    context 'should return segments in order specified by segment_order' do
      let(:ordered){Sign.new(letter_order:[2,5,4,1,3]).ordered_letters}
      it{expect(ordered[0].number).to eq(2)}
      it{expect(ordered[2].number).to eq(4)}
      it{expect(ordered[4].number).to eq(3)}
    end
  end

  describe '#phrase' do
    it 'should store phrase' do
      sign.phrase = 'Hello there Guy'
      expect(sign.phrase).to eq('HELLO THERE GUY')
    end
  end

  describe '#remove_letters' do
    %i(l1 l2 l3 l4).each do |ll|
      let(ll){Letter.new}
    end

    before do
      sign.add_letters(l1,l2,l3,l4)
      sign.set_letter_order(3,1,2,0)
      sign.remove_letters(l1,l3)
    end

    it{expect(l2.number).to eq(1)}
    it{expect(l4.number).to eq(3)}
    it{expect(sign.letters.size).to eq(2)}

    it "should have the correct letter order" do
      expect(sign.letter_order).to eq([3,1])
    end

  end

  describe '#set_letter_order' do

    context 'when letters are added' do
      let(:sign) do
        s = Sign.new(letter_order:[1,4])
        s.set_letter_order(1,2,3,4)
        s
      end
      it 'should have the right number of letters' do
        expect(sign.letters.size).to eq(4)
      end
      (1..4).to_a.each do |n|
        it{expect(sign.letter_number(n).number).to eq(n)}
      end
    end

    context 'when letters are subtracted' do
      let(:sign) do
        s = Sign.new(letter_order:[1,2,3,4])
        s.set_letter_order [1,4]
        s
      end
      it 'should have the right number of letters' do
        expect(sign.letters.size).to eq(2)
      end
      [1,4].each do |n|
        it{expect(sign.letter_number(n).number).to eq(n)}
      end
      [2,3].each{|n| it{ expect(sign.letter_number(n)).to be_nil}}
    end
  end

  describe '#tempo' do
    it 'should default to 60' do
      expect(Sign.new.tempo).to eq(60)
    end
  end

  describe '#push' do
    it 'should save and push to LedString' do
      sign = Sign.new(phrase:'Hi Mom', letter_order:[0,1,2,3])
      LedString.new.add_sign(sign)
      Effects::Manager.expects(:run).with(sign)
      sign.expects(:save).returns true
      expect(sign.push).to eq(true)
    end
  end

end
