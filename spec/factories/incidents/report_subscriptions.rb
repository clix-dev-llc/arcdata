# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :report_subscription, :class => 'Incidents::ReportSubscription' do
    association :scope, factory: :incidents_scope
    person { |sub| sub.association :person, region: sub.scope.region }
    shift_territory nil
    report_type "report"
    frequency 'weekly'
  end
end
