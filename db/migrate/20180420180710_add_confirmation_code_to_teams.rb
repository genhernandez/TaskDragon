class AddConfirmationCodeToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :confirmation_code, :string
  end
end
