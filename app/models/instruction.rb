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

class Instruction < ActiveRecord::Base

  belongs_to :sequence
  has_many :effects, :dependent => :destroy

  def phrase=(str)
    super str.upcase
  end

  # Fade Cycle Time for sign effects that invlove fadeing from one color to another
  #
  def fade_time
    super || 72
  end

  # Tempo of the display in beats/minute default is 60
  def tempo
    super || 60
  end

end
