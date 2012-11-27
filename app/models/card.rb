class Card < ActiveRecord::Base
  has_many :races
  belongs_to :meet
  has_many :comments
  attr_accessible :completed, :completed_date, :description, :meet_id, :name, :open, :status
end
