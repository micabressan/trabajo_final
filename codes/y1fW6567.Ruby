class Subscription < ApplicationRecord

  belongs_to :user
  belongs_to :plan
  belongs_to :product
  has_many :events

  before_validation :generate_uuid, :on => :create
  validates :product_id, :uniqueness => { scope: :user_id}
  validates :plan_id, :uniqueness => { scope: :user_id}
  validate :check_product
  validates :uuid, presence: true

  def check_product
    if self.product != self.plan.product
      errors.add(:product_id, "Does not match")
    end
  end
end

irb(main):063:0> Subscription.count
   (0.5ms)  SELECT COUNT(*) FROM "subscriptions" WHERE "subscriptions"."deleted_at" IS NULL
=> 0

irb(main):064:0> thing = @user.subscriptions.create(product: @product, plan: @plan)
   (0.2ms)  BEGIN
  SQL (0.7ms)  INSERT INTO "subscriptions" ("created_at", "updated_at", "user_id", "plan_id", "product_id", "uuid") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id"  [["created_at", "2017-12-14 12:12:26.672766"], ["updated_at", "2017-12-14 12:12:26.672766"], ["user_id", 4], ["plan_id", 42], ["product_id", 45], ["uuid", "b5185717-9af1-4215-874e-314a0125d27e"]]
  Subscription Exists (0.6ms)  SELECT  1 AS one FROM "subscriptions" WHERE "subscriptions"."product_id" = $1 AND ("subscriptions"."id" != $2) AND "subscriptions"."user_id" = $3 LIMIT $4  [["product_id", 45], ["id", 13], ["user_id", 4], ["LIMIT", 1]]
  Subscription Exists (0.6ms)  SELECT  1 AS one FROM "subscriptions" WHERE "subscriptions"."plan_id" = $1 AND ("subscriptions"."id" != $2) AND "subscriptions"."user_id" = $3 LIMIT $4  [["plan_id", 42], ["id", 13], ["user_id", 4], ["LIMIT", 1]]
   (1.8ms)  COMMIT
=> #<Subscription id: 13, created_at: "2017-12-14 12:12:26", updated_at: "2017-12-14 12:12:26", user_id: 4, plan_id: 42, product_id: 45, uuid: "b5185717-9af1-4215-874e-314a0125d27e", deleted_at: nil>

irb(main):065:0> Subscription.count
   (0.5ms)  SELECT COUNT(*) FROM "subscriptions" WHERE "subscriptions"."deleted_at" IS NULL
=> 1

irb(main):066:0> thing2 = @user.subscriptions.create(product: @product, plan: @plan)
   (0.3ms)  BEGIN
  SQL (0.5ms)  INSERT INTO "subscriptions" ("created_at", "updated_at", "user_id", "plan_id", "product_id", "uuid") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id"  [["created_at", "2017-12-14 12:12:45.320184"], ["updated_at", "2017-12-14 12:12:45.320184"], ["user_id", 4], ["plan_id", 42], ["product_id", 45], ["uuid", "73f34884-f913-415e-88f9-a25a158bcb3c"]]
  Subscription Exists (0.4ms)  SELECT  1 AS one FROM "subscriptions" WHERE "subscriptions"."product_id" = $1 AND ("subscriptions"."id" != $2) AND "subscriptions"."user_id" = $3 LIMIT $4  [["product_id", 45], ["id", 14], ["user_id", 4], ["LIMIT", 1]]
  Subscription Exists (0.4ms)  SELECT  1 AS one FROM "subscriptions" WHERE "subscriptions"."plan_id" = $1 AND ("subscriptions"."id" != $2) AND "subscriptions"."user_id" = $3 LIMIT $4  [["plan_id", 42], ["id", 14], ["user_id", 4], ["LIMIT", 1]]
   (1.7ms)  COMMIT
=> #<Subscription id: 14, created_at: "2017-12-14 12:12:45", updated_at: "2017-12-14 12:12:45", user_id: 4, plan_id: 42, product_id: 45, uuid: "73f34884-f913-415e-88f9-a25a158bcb3c", deleted_at: nil>

irb(main):067:0> Subscription.count
   (0.7ms)  SELECT COUNT(*) FROM "subscriptions" WHERE "subscriptions"."deleted_at" IS NULL
=> 2

irb(main):068:0> thing2.valid?
  Subscription Exists (0.7ms)  SELECT  1 AS one FROM "subscriptions" WHERE "subscriptions"."product_id" = $1 AND ("subscriptions"."id" != $2) AND "subscriptions"."user_id" = $3 LIMIT $4  [["product_id", 45], ["id", 14], ["user_id", 4], ["LIMIT", 1]]
  Subscription Exists (0.4ms)  SELECT  1 AS one FROM "subscriptions" WHERE "subscriptions"."plan_id" = $1 AND ("subscriptions"."id" != $2) AND "subscriptions"."user_id" = $3 LIMIT $4  [["plan_id", 42], ["id", 14], ["user_id", 4], ["LIMIT", 1]]
=> false

irb(main):069:0> thing3 = @user.subscriptions.new(product: @product, plan: @plan)
=> #<Subscription id: nil, created_at: nil, updated_at: nil, user_id: 4, plan_id: 42, product_id: 45, uuid: nil, deleted_at: nil>

irb(main):070:0> thing3.save
   (0.3ms)  BEGIN
  SQL (0.7ms)  INSERT INTO "subscriptions" ("created_at", "updated_at", "user_id", "plan_id", "product_id", "uuid") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id"  [["created_at", "2017-12-14 12:13:21.861111"], ["updated_at", "2017-12-14 12:13:21.861111"], ["user_id", 4], ["plan_id", 42], ["product_id", 45], ["uuid", "b68ab881-6c2f-4eb2-80b6-b7f330fcf0e2"]]
  Subscription Exists (0.7ms)  SELECT  1 AS one FROM "subscriptions" WHERE "subscriptions"."product_id" = $1 AND ("subscriptions"."id" != $2) AND "subscriptions"."user_id" = $3 LIMIT $4  [["product_id", 45], ["id", 15], ["user_id", 4], ["LIMIT", 1]]
  Subscription Exists (0.6ms)  SELECT  1 AS one FROM "subscriptions" WHERE "subscriptions"."plan_id" = $1 AND ("subscriptions"."id" != $2) AND "subscriptions"."user_id" = $3 LIMIT $4  [["plan_id", 42], ["id", 15], ["user_id", 4], ["LIMIT", 1]]
   (0.3ms)  ROLLBACK
=> false