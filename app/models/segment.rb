# == Schema Information
#
# Table name: segments
#
#  id        :integer          not null, primary key
#  length    :integer
#  number    :integer
#  color     :character varyin
#  letter_id :integer
#
# Indexes
#
#  index_segments_on_letter_id  (letter_id)
#

class Segment < ActiveRecord::Base
  attr_accessor :led_string, :on

  serialize :color, ColorSerializer

  belongs_to :letter

  after_initialize :init

  def init
    self.length  ||= 1
    self.led_string ||= LedString
  end

  def color=(color)
    super
    led_string.set_color color, range
  end

  def on?
    on == true
  end

  def on!
    self.on = true
    self
  end

  def off!
    self.on = false
    self
  end

  def off?
    not on
  end

  def start
    idx = led_string.segments.index(self)
    (0..idx-1).collect{|i| led_string.segments[i].length }.sum
  end

  def end
    range.end
  end

  def range
    s = start
    (s..s+length-1)
  end


end
