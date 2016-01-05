class CreatePapeis < ActiveRecord::Migration
  def change
    create_table :papeis do |t|
      t.string :nome
      t.string :chave
      t.string :descricao
      t.integer :reference_id
      t.timestamps
    end
  end
end
