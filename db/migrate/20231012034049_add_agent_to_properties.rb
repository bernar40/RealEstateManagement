class AddAgentToProperties < ActiveRecord::Migration[7.1]
  def change
    add_reference :properties, :agent, foreign_key: true
  end
end
