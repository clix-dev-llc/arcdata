class RootController < ApplicationController
  skip_before_filter :require_valid_user!
  skip_before_filter :require_active_user!, only: [:health, :inactive]
  skip_before_filter :user_time_zone, only: :health

  newrelic_ignore only: :health

  def index

  end

  def health
    conns = ActiveRecord::Base.connection.select_value "SELECT count(*) FROM pg_stat_activity WHERE usename=user"

    render text: "200 Ok - #{conns} connections"

  rescue Exception => e
    str = <<-DESC
    #{e.to_s}
    #{e.backtrace.join "\n"}
    DESC
    render status: 500, text: str
    Raven.capture e
  end

  def inactive
    if request.format == :html
      render status: 403
    else
      head :forbidden
    end
  end

  private

  expose(:homepage_links) {
    links = HomepageLink.for_region(current_region).order{[group_ordinal.asc, ordinal.asc]}.includes{roles}.to_a
    scopes = current_user.scope_for_capability 'homepage_link'
    links.select{|l| l.role_ids.blank? || (l.roles.map(&:role_scope) & scopes).present? }.group_by(&:group)
  }
end
