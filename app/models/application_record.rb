class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def country
    Carmen::Country.coded(country_code)
  end
end
