class Product < ApplicationRecord
    has_many :line_items, dependent: :destroy
    has_many :orders, through: :line_items

    validates :title, :description, :image_url, presence: true
    # 数値についての検証。0.01以上か確認。
    # なぜ0と比較しないのかと言うと、0.001と言う数字を入れてみると、検証はパスするが有効桁数2以上は丸められてしまい、結局0で保存されてしまうから。
    validates :price, numericality: {greater_than_or_equal_to: 0.01}
    validates :title, uniqueness: true
    validates :image_url, allow_blank: true, format: {
        with: %r{\.(gif|jpg|png)$}i,
        multiline: true,
        message: 'はGIF, JPG, PNG画像のURLでなければなりません。'
    }
    before_destroy :ensure_not_referenced_by_any_line_item

    private
        # カートの数が増えた場合、各商品が、自分自身を参照する多数の品目(lineItem)をもつ可能性があるため
        # 検証コードを使って、品目から参照されている商品が削除されないようにする。

        # この商品を参照している品目がないことを確認する。
        def ensure_not_referenced_by_any_line_item
            if line_items.empty?
                return true
            else
                errors.add(:base, '品目が存在')
                return false
            end
        end
end
