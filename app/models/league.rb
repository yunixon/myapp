class League < ActiveRecord::Base
  acts_as_taggable
  has_many :leagueusers
  has_many :users , :through => :leagueusers 
  has_many :trackleagues
  has_many :tracks , :through => :trackleagues
  has_many :meetleagues
  has_many :meets , :through => :trackleagues 
  has_many :rankings,  :dependent => :destroy
  belongs_to :site
  attr_accessible :active, :description, :name, :owner_id, :status, :tag_list, :membership
end
