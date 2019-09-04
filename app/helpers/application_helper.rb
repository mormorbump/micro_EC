module ApplicationHelper
    # 条件, 属性のセット(省略可能), コードブロックを受け取れるメソッド。
    def hidden_div_if(condition, attributes = {}, &block)
        # cinditionを満たしてなかったらスタイル何も当たらないdivがでてくる。
        if condition
            attributes["style"] = "display: none"
        end
        content_tag("div", attributes, &block)
    end
end
