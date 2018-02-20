class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.references :lender, index: true, foreign_key: true
      t.references :borrower, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
