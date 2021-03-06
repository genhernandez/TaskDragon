# == Schema Information
#
# Table name: dragons
#
#  id           :integer         not null, primary key
#  name         :string
#  picture_path :string
#  xp           :integer
#  level        :integer
#  team_id      :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class Dragon < ActiveRecord::Base
  belongs_to :team
  validates :name, :presence => true

  def level_up(current_user, points, image_urls)
    levels = [100, 300, 600, 1200, 2400, 4800]
    dragon = current_user.team.dragon
    xp = dragon.xp + points
    level = dragon.level
    if level > 0 && xp <= levels[level - 1] && points < 0
      level -= 1
    elsif level < levels.length && xp >= levels[level] && points > 0
      level += 1
    end 
    dragon.update_attributes!(:xp => xp)
    dragon.update_attributes!(:level => level)
    if level < image_urls.length
      case dragon.color
      when 'Green'
        picture_path = image_urls[level][0]
      when 'Blue'
        picture_path = image_urls[level][1]
      when 'Yellow'
        picture_path = image_urls[level][4]
      when 'Red'
        picture_path = image_urls[level][3]
      when 'Purple'
        picture_path = image_urls[level][2]
      end
      dragon.update_attributes!(:picture_path => picture_path)
    end
  end
end
