class Scheduler::Ability
  include CanCan::Ability
  include ::NewRelic::Agent::MethodTracer

  attr_reader :person

  def initialize(person)
    @person = person

    personal

    county_ids = person.scope_for_role('county_roster')
    county_roster(county_ids) if county_ids.present?

    admin_county_ids = person.scope_for_role('county_scheduler')
    if person.has_role 'region_scheduler'
        admin_county_ids.concat person.region.county_ids
    end
    admin_county_ids.uniq!
    scheduler admin_county_ids if admin_county_ids.present?

    region_dat_admin person.region_id if person.has_role 'region_dat_admin'

    dat_admin_counties = person.scope_for_role('county_dat_admin')
    county_dat_admin dat_admin_counties if dat_admin_counties.present? # is dat county admin

    read_only if ENV['READ_ONLY']
  end

  add_method_tracer :initialize

  def personal
    can [:read, :update], [Scheduler::NotificationSetting, Scheduler::FlexSchedule], {id: person.id}
    can [:read, :destroy, :create, :swap, :update], Scheduler::ShiftAssignment, person: {id: person.id}
    can :manage, Scheduler::ShiftSwap, assignment: {person: {region_id: person.region_id}}
    can :read, :on_call unless person.region.scheduler_restrict_on_call_contacts
  end

  def scheduler ids
    can :read, Roster::Person, county_memberships: {county_id: ids}
    can :manage, Scheduler::ShiftAssignment, {person: {county_memberships: {county_id: ids}}}
  end

  def county_roster ids
    can :index, [Scheduler::FlexSchedule], {person: {county_memberships: {county_id: ids}}}
    can :index, Roster::Person, {county_memberships: {county_id: ids}}
  end

  def region_dat_admin id
    can :read, Roster::Person, region_id: id
    can :manage, Scheduler::ShiftAssignment, {person: {region_id: id}}
    can :manage, Scheduler::DispatchConfig, id: id
    can [:read, :update], [Scheduler::NotificationSetting, Scheduler::FlexSchedule], person: {region_id: id}
    can [:read, :update, :update_shifts], Scheduler::Shift, county: {region_id: id}

    can :receive_admin_notifications, Scheduler::NotificationSetting, id: person.id
    can :read, :on_call
  end

  def county_dat_admin ids
    can :read, Roster::Person, county_memberships: {county_id: ids}
    can :manage, Scheduler::ShiftAssignment, {person: {county_memberships: {county_id: ids}}}
    can :manage, Scheduler::DispatchConfig, id: ids
    can [:read, :update], [Scheduler::NotificationSetting, Scheduler::FlexSchedule], person: {county_memberships: {county_id: ids}}
    can [:read, :update, :update_shifts], Scheduler::Shift, county_id: ids

    can :receive_admin_notifications, Scheduler::NotificationSetting, id: person.id
    can :read, :on_call
  end

  def read_only
    cannot [:update, :create, :destroy], :all
  end
end
