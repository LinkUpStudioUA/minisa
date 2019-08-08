class CreateServiceRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :service_requests do |t|
      t.belongs_to :service
      t.belongs_to :buyer
      t.text :text
      t.text :video_data
      t.string :status, default: 'unsubmitted'

      t.timestamps
    end
  end
end
