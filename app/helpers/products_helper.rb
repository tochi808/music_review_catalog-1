#encoding: utf-8
module ProductsHelper

  def order_select_tag
    select_tag(
      :sort_order,
      options_for_select([
          ['登録が新しい順'   , 'created_at desc'],
          ['登録が古い順'     , 'created_at'],
          ['アーティスト名の昇順', 'artists.name'],
          ['アーティスト名の降順', 'artists.name desc'],
          ['ジャンルの昇順'    , 'genre'],
          ['ジャンルの降順'    , 'genre desc']
        ],@sort_order_selected || Product.DEFAULT_ORDER),
      id: "sort-order"
    )

  end


  def product_review_list

    content_tag :ul, :class => 'product-review-list' do
      @product.reviews.map do |review|
        concat content_tag :li, link_to(truncate(review.body), product_review_path(@product, review))
      end 
    end

  end
end
