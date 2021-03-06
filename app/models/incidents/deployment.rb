class Incidents::Deployment < ActiveRecord::Base
  belongs_to :person, class_name: 'Roster::Person'
  belongs_to :disaster, class_name: 'Incidents::Disaster'

  validates_presence_of :person, :disaster

  scope :for_region, ->(regions) { joins{person}.where{person.region_id.in regions}}
  scope :seen_since, ->(date) { where{date_last_seen >= date} }

  def self.for_person person
    where{person_id == person}
  end

  def gap= gap
    super gap
    (self.group, self.activity, self.position, self.qual) = gap.split '/'
  end
end
