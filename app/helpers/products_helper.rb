#encoding: utf-8
module ProductsHelper

  def order_select_tag
    select_tag(
      :hoge,
      options_for_select([
          ['登録が新しい順', 'created_at desc'],
          ['登録が古い順', 'created_at'],
          ['アーティスト名の昇順', 'artist'],
          ['アーティスト名の降順', 'artist desc']
        ],@sort_order_selected || 'created_at desc'),
      id: "sort-order"
    )

  end
end
