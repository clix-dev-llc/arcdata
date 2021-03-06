module Incidents::IncidentsListHelper
  def counties_for_menu(collection)
    collection.select{[county, state]}.where{county != nil}.order(:state, :county).uniq.map{|row| "#{row.county}, #{row.state}" }.to_a.uniq{|s| s.downcase}
  end

  def neighborhoods_for_menu(collection)
    collection.unscope(:order, :offset, :limit).order(:neighborhood).uniq.pluck :neighborhood
  end

  def num val
    number_with_delimiter val.try(:round), precision: 0
  end

  def assistance_totals(collection)
    collection.joins{cases}.select{
      [count(cases.id).as(:num_cases),
        sum(cases.total_amount).as(:total_assistance)
      ]
    }.group("incidents_cases.total_amount = 0.0").to_a
  end

  def total_miles_driven(collection)
    Incidents::ResponderAssignment.where{incident_id.in(collection.select{id})}.was_available.driving_distance
  end

  def average_response_time(collection)
    logs_start = Incidents::EventLog.where{(event.in(['dispatch_received', 'dispatch_note', 'dat_received', 'dispatch_relayed', 'responders_identified'])) & (incident_id == incidents_incidents.id)}.reorder{event_time}.select{event_time}.limit(1).to_sql
    logs_end = Incidents::EventLog.where{(event.in(['dat_on_scene'])) & (incident_id == incidents_incidents.id)}.reorder{event_time}.select{event_time}.limit(1).to_sql
    durations = collection.select(
      "extract(epoch from (#{logs_end}) - (#{logs_start})) AS duration"
    ).to_a.map(&:duration).select{|dur| dur && dur > 10.minutes && dur < 8.hours}

    if durations.present?
      mean = durations.sum / durations.size
      time_ago_in_words (Time.now-mean), include_seconds: false
    end
  end
end