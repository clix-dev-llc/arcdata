class Incidents::CasIncident < ApplicationRecord
  has_one :incident, class_name: 'Incidents::Incident', primary_key: 'cas_incident_number', foreign_key: 'cas_event_number'
  belongs_to :chapter, class_name: 'Roster::Chapter'
  has_many :cases, class_name: 'Incidents::CasCase', inverse_of: :cas_incident
  alias :cas_cases :cases

  #validates :incident_id, :cas_incident_number, :dr_number, uniqueness: {allow_blank: true, allow_nil: true}

  def self.for_chapter chapter
    where(chapter: chapter)
  end

  def self.to_link_for_chapter chapter
    for_chapter(chapter)
      .left_outer_joins(:incident)
      .where(ignore_incident: false, incident: { id: nil })
      .order(incident_date: :desc)
  end

  def self.open_cases
    left_outer_joins(:cases).where(
      where('cases_open > ?', 0).or(
        where('last_date_with_open_cases >= ?', 7.days.ago)
      )
    )
    .where('cases.case_last_updated > ?', 2.months.ago)
    .uniq
  end

  def self.[] incident_number
    find_by cas_incident_number: incident_number
  end

  def is_dr
    dr_number != cas_incident_number
  end

  def to_param
    cas_incident_number
  end

  # For Debug Purposes
  def create_incident_from_cas!(chapter=nil)
    Incidents::CasPromoter.promote!(self, chapter)
  end

end
