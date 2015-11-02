atom_feed do |feed|
  feed.title "Who bought #{@product.title}"

  feed.updated @latest_order.try(:updated_at)

  @product.orders.each do |order|
    feed.entry(order) do |entry|
      entry.title "Order #{order.id}"
      entry.summary type: 'html' do |html|
        html.p "Shipped to #{order.address}"
        html.table do
          html.tr do
            html.th 'Product'
            html.th 'Quantity'
            html.th 'Total Price'
          end
          order.line_items.each do |item|
            html.tr do
              html.td item.product.title
              html.td item.quantity
              html.td number_to_currency item.total_price
            end
          end
          html.tr do
            html.th 'total', colspan: 2
            html.th number_to_currency \
            order.line_items.map(&:total_price).sum
          end
        end
        html.p "Paid by #{order.pay_type}"
      end
      entry.author do |author|
        author.name order.name
        author.email order.email
      end
    end
  end
end
