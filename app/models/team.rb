# == Schema Information
#
# Table name: teams
#
#  id         :integer         not null, primary key
#  name       :string
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Team < ActiveRecord::Base
    has_many :users
    has_many :tasks
    has_one :dragon
    def self.search(search)
      where("name LIKE ?","%#{search}%")
    end
    validates :name, :presence => true
end
