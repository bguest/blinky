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

require 'rails_helper'

RSpec.describe Effect, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
