require 'spec_helper'

describe LettersController do

  describe '#index GET /letters(.:format)' do
    it 'should return all letters' do
      sign = Sign.new
      controller.stubs(:sign).returns(sign)
      sign.expects(:ordered_letters).with(any_parameters)
      get :index
    end
  end

  describe "#create POST /letters(.:format)" do

    let(:params){{:letter => {:segment_order => "[0,1,2,3,4,5,6,7,8,10,11,12,13,14,15]"}}}

    it 'should be able to create new letter' do
      post :create, params
      expect(Letter.last.segment_order).to eq([0,1,2,3,4,5,6,7,8,10,11,12,13,14,15])
    end

    it 'should flash error if cant save' do
      s = Sign.new
      s.stubs(:save).returns(false)
      controller.stubs(:sign).returns(s)
      post :create, params
      expect(flash[:error]).to eq('Letter could not be created')
    end

  end

  describe '#update #PATCH /letters/:id(.:format)' do
    before :each do
      @letter = Letter.create(segment_order:[5,4,3,2,1])
      @params = {id: @letter.id, letter: {segment_order: "[0,1,2,3,4,5]"}}
    end

    it 'should update segment order' do
      patch :update, @params
      expect(Letter.find(@letter.id).segment_order).to eq([0,1,2,3,4,5])
    end

    it 'should flash error if save is unsuccessful' do
      Letter.any_instance.stubs(:save).returns(false)
      patch :update, @params
      expect(flash[:error]).to eq("Error updating letter number #{@letter.id}")
    end

  end

  describe '#edit_letter GET /letters/:id/edit(.:format)' do
    before :each do
      @letter = Letter.new
      Letter.expects(:find).with('99').returns(@letter)
      get :edit, id:99
    end

    it 'should assign letter' do
      expect(assigns(:letter)).to eq(@letter)
    end

    it 'should assign segments' do
      expect(assigns(:segments)).to eq(@letter.segments.order(:number))
    end

    it 'should assign segment lengths' do
      expect(assigns(:segment_lengths)).to eq(@letter.segment_lengths)
    end
  end

  describe '#destroy DELETE /letters/:id(.:format)' do
    before :each do
      @letter = Letter.create
    end

    it 'should delete letter' do
      delete :destroy, id:@letter.id
      expect{ Letter.find(@letter.id) }.to raise_error ActiveRecord::RecordNotFound
    end

    it 'should flash error if cant save sign' do
      s = Sign.new
      s.stubs(:save).returns false
      controller.stubs(:sign).returns s
      delete :destroy, id:@letter.id
      expect(flash[:error]).to eq("Problem deleting letter #{@letter.id}")
    end
  end

  describe '#letters PUT /letters/reload(.:format)' do

    before :each do
      @sign = Sign.new
      controller.stubs(:sign).returns(@sign)
    end

    it 'should create a new LedString' do
      string = LedString.new
      LedString.expects(:new).returns(string)
      put :reload
    end

    it 'should attempt to add sign to led string' do
      LedString.expects(:add_sign).with(@sign)
      put :reload
    end

  end

  # segment_lengths_letter
  describe '#segment_lengths PUT /letters/:id/segment_lengths(.:format)' do
    before :each do
      @letter = Letter.new(id:'88', segment_order:[0,1,2])
      Letter.stubs(:find).with('88').returns(@letter)
      Segment.any_instance.stubs(:save).returns(true)
      params = {id: '88', segment_lengths: '[3,4,5]'}
      put :segment_lengths, params
    end

    it 'should redirect to letters index' do
      response.should redirect_to edit_letter_path('88')
    end

    it 'should update letter segment lengths' do
      expect(@letter.segment_number(0).length).to eq(3)
      expect(@letter.segment_number(1).length).to eq(4)
      expect(@letter.segment_number(2).length).to eq(5)
    end
  end


end
