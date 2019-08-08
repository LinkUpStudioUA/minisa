class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :promo_code, null: false
      t.float :discount_percentage, null: false
      t.datetime :expire_at

      t.timestamps
    end

    add_belongs_to :service_requests, :coupon
  end
end
