class CreateServiceAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :service_answers do |t|
      t.belongs_to :service_request
      t.text :text
      t.text :video_data

      t.timestamps
    end
  end
end
