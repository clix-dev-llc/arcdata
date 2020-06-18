class Scheduler::FlexSchedulesController < Scheduler::BaseController
  inherit_resources
  respond_to :html, :json
  helper EditableHelper
  load_and_authorize_resource
  include Searchable

  actions :index, :show, :update

  has_scope :for_shift_territory, as: :shift_territory, default: Proc.new {|controller| controller.current_user.primary_shift_territory_id}
  has_scope :available, type: :array do |controller, scope, val|
    if val
      val.each do |period|
        scope = scope.where("available_#{period}" => true)
      end
    end
    scope
  end
  has_scope :with_availability, type: :boolean, default: true

  private
    # Use callbacks to share common setup or constraints between actions.
    def resource
      @flex_schedule ||= Scheduler::FlexSchedule.where(id: params[:id]).first_or_create!
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      shifts = Scheduler::FlexSchedule.available_columns
      [params.require(:scheduler_flex_schedule).permit(*shifts)]
    end

    def collection
      @collection ||= apply_scopes(super).uniq.preload{[person.positions, person.shift_territories, person.home_phone_carrier, person.work_phone_carrier, person.alternate_phone_carrier, person.cell_phone_carrier, person.sms_phone_carrier]}
    end
end
