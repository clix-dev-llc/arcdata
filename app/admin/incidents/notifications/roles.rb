ActiveAdmin.register Incidents::Notifications::Role, as: 'Notification Role' do
  batch_action :destroy, false
  batch_action :edit, false

  menu parent: 'Incidents'

  filter :region
  filter :name
  filter :events

  index do 
    id_column
    column :region_id
    column :name
    column(:members) { |r|
      safe_join(r.positions.map(&:name) + r.shifts.map(&:name), tag(:br))
    }
    column(:counties) { |r|
      safe_join(r.role_scopes.includes{response_territory}.map{|rs| rs.response_territory ? "Response Territory: #{rs.response_territory.name}" : "County: #{rs.value}" }, tag(:br))
    }
    actions
  end

  form do |f|
    f.inputs
    f.inputs do
      f.has_many :triggers, allow_destroy: true do |rf|
        rf.input :event, collection: Incidents::Notifications::Event.for_region(f.object.region)
        rf.input :template, as: :assignable_select_admin
        rf.input :use_sms
      end
      f.has_many :role_scopes, allow_destroy: true do |sf|
        sf.input :level, as: :assignable_select_admin
        sf.input :value
        sf.input :response_territory, collection: Incidents::ResponseTerritory.for_region(f.object.region)
      end
    end
    f.inputs do
      f.input :positions, as: :check_boxes, collection: (f.object.region.try(:positions) || [])
      f.input :shifts, as: :check_boxes, collection: Scheduler::Shift.for_region(f.object.region)
    end
    f.actions
  end

  show do |role|
    default_main_content
    columns do
      column do
        panel "Bindings" do
          table_for role.role_scopes do
            column("Scope") { |s| s.humanized_level }
            column :value
          end
          table_for role.positions do
            column("Position") { |p| p.name }
          end
          table_for role.shifts do
            column("Shift") { |s| s.name }
            column("County") { |s| s.county.name }
            column("Shift Time") { |shift| safe_join(shift.shift_times.map(&:name), tag(:br)) }
          end
        end
      end
      column do
        panel "Triggers" do
          table_for role.triggers.joins{event}.order{event.ordinal} do
            column :event
            column(:template) { |t| t.humanized_template }
            column :use_sms
          end
        end
      end
    end
    columns do
      column do
        panel "Current Position Members" do
          table_for role.position_members do
            column :full_name
            column :email
            column :sms do |person|
              person.sms_addresses.first
            end
          end
        end
      end
      column do
        panel "Current Shift Members" do
          table_for role.shift_member_assignments do
            column('Shift') { |ass| ass.shift.name }
            column('Person') { |ass| ass.person.full_name }
            column('Email') { |ass| ass.person.email }
            column('SMS') { |ass| ass.person.sms_addresses.first }
          end
        end
      end
    end
  end

  controller do

    def collection
      @col ||= super.includes{[positions,shifts.shift_times, shifts.county]}
    end

    def resource_params
      [params.fetch(resource_request_name, {}).permit(:name, :region_id, position_ids: [], shift_ids: [], triggers_attributes: [:id, :event_id, :template, :use_sms, :_destroy], role_scopes_attributes: [:id, :_destroy, :level, :value, :response_territory_id])]
    end

    after_build :set_region
    def set_region resource
      resource.region = current_region
    end
  end
end
