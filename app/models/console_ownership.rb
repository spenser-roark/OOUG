class ConsoleOwnership < ActiveRecord::Base
self.pluralize_table_names = false

belongs_to :consoles
belongs_to :user

ConsoleOwnership.joins(:consoles, :user)

end
