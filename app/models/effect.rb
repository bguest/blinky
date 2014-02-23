# == Schema Information
#
# Table name: effects
#
#  id             :integer          not null, primary key
#  instruction_id :integer
#  type           :character varyin
#  number         :integer
#  data           :character varyin
#  created_at     :timestamp withou not null
#  updated_at     :timestamp withou not null
#
# Indexes
#
#  index_effects_on_instruction_id  (instruction_id)
#

class Effect < ActiveRecord::Base
  belongs_to :instruction
  serialize :data, Hash

  after_initialize :init

  def init
    self.data ||= {}
  end

  def fields
    []
  end
end
