class Incidents::CaseAssistanceItem < ActiveRecord::Base
  belongs_to :price_list_item, class_name: 'Incidents::PriceListItem'
  belongs_to :case, class_name: 'Incidents::Case'

  assignable_values_for :price_list_item do
    Incidents::PriceListItem.enabled.order{[item_class.asc, name.asc]} # will scope this to the region later
  end

  validates :quantity, numericality: {allow_blank: false}

  before_validation :calculate_total
  def calculate_total
    if price_list_item and quantity
      self.total_price = price_list_item.calculate_total(quantity)
    end
  end
end
