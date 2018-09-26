class AddQuestionToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :question, :string
  end
end
