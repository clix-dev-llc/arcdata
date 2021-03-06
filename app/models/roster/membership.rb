class Roster::Membership < ActiveRecord::Base
  self.abstract_class = true

  belongs_to :person

  def self.for_region region 
    joins{person}.where{(person.region_id == region)}
  end

  def self.not_persistent
    where{(persistent == nil) | (persistent == false)}
  end

  def self.destroy_all_for_region(region)
    self.for_region(region).not_persistent.delete_all
  end
end