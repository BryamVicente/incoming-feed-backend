class CreateCategoryChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :category_choices do |t|
      t.string :name
      t.timestamps
    end
  end
end
