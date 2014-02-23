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

class Sequence < ActiveRecord::Base
  belongs_to :sign
  has_many :instructions, :dependent => :destroy

  validates :name, presence: true
end
