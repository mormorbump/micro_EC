class User < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    # password系のバリデーション、password, password_cinfirmationなどの属性の定義などをこのメソッドで定義。
    has_secure_password
    after_destroy :ensure_an_admin_remains
    attr_accessor :old_password
    validates :old_password, presence: true, on: :update

    # 今の実装だと、ユーザがデータベースに一人もいなくなったら誰もログインできなくなってしまう。
    # これを防ぐために、ユーザテーブルにレコードが一つもなくなったら直前のtransactionをロールバックする、という実装を行う。
    # これを行っても自分を削除するのを防ぐだけでは、AがBを、BがAを同時に削除、というのが防げないため
    private
        def ensure_an_admin_remains
            # わざとエラーを示す例外を使うことでrollback
            if User.count.zero?
                raise "最後のユーザーは削除できません。"
            end
        end
end
