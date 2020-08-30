if Rails.env.development?
  ActiveSupport::Cache::Store.logger = Rails.logger
end

if Rails.env.production?

  ActionController::Instrumentation.send(:define_method, "process_action") do |arg|
    raw_payload = {
      :controller => self.class.name,
      :action     => self.action_name,
      :params     => request.filtered_parameters,
      :format    => request.format.try(:ref),
      :method     => request.method,
      :path       => (request.fullpath rescue "unknown"),

      :ip         => request.remote_ip,
      :stash      => request.session['flash'] && request.session['flash'][:log]
    }

    ActiveSupport::Notifications.instrument("start_processing.action_controller", raw_payload.dup)

    ActiveSupport::Notifications.instrument("process_action.action_controller", raw_payload) do |payload|
      result = super(arg)
      payload[:status] = response.status
      append_info_to_payload(payload)
      result
    end
  end

  ActiveSupport::Notifications.subscribe "process_action.action_controller" do |name, start, finish, id, payload|
    # borrows from
    # https://github.com/rails/rails/blob/3-2-stable/actionpack/lib/action_controller/log_subscriber.rb
    params  = payload[:params].except('controller', 'action', 'format', '_method', 'only_path')

    format  = payload[:format]
    format  = format.to_s.upcase if format.is_a?(Symbol)

    duration = (finish-start)*1000

    status = payload[:status]
    if status.nil? && payload[:exception].present?
      exception_class_name = payload[:exception].first
      status = ActionDispatch::ExceptionWrapper.status_code_for_exception(exception_class_name)
    end

    m = "[request] ip=%s method=%s path=%s status=%s status_name=%s action=%s\#%s format=%s time=%.1f view_time=%.1f db_time=%.1f params='%s'" % [
      payload[:ip], payload[:method], payload[:path],
      status, Rack::Utils::HTTP_STATUS_CODES[status],
      payload[:controller], payload[:action], format,
      duration || 0, payload[:view_runtime] || 0, payload[:db_runtime] || 0,
      params.inspect]

    Rails.logger.warn(m)
  end

  require "action_view/log_subscriber"

  module ActionView
    class LogSubscriber
      def render_partial(event)
        # Silencing
      end
      def render_collection(event)
        # Silencing
      end
    end
  end

end