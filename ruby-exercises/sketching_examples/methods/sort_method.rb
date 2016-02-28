      def get_product_workflow
        queried_products = get_products(@status)
        products = build_products_collection(queried_products)
        products.sort! { |a,b| a.product_title.downcase <=> b.product_title.downcase}
        products
      end