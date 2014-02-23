# == Schema Information
#
# Table name: sequences
#
#  id         :integer          not null, primary key
#  sign_id    :integer
#  name       :character varyin
#  created_at :timestamp withou not null
#  updated_at :timestamp withou not null
#
# Indexes
#
#  index_sequences_on_sign_id  (sign_id)
#

require 'rails_helper'

RSpec.describe Sequence, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
