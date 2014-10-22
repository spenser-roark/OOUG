class SpineCardExist < ActiveRecord::Base
	self.pluralize_table_names = false
	belongs_to :console_general

	SpineCardExist.joins(:console_general)
end
