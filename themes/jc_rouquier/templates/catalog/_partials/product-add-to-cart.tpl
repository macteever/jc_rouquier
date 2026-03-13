{if !$configuration.is_catalog}
  <div class="product-add-to-cart js-product-add-to-cart">
    <form action="{$urls.pages.cart}" method="post" class="add-to-cart-or-refresh">
      <input type="hidden" name="token" value="{$static_token}">
      <input type="hidden" name="id_product" value="{$product.id_product}" class="product_page_product_id">
      <input type="hidden" name="id_customization" value="0">
      <input type="hidden" name="qty" value="1">
      {if !empty($product.id_product_attribute)}
        <input type="hidden" name="id_product_attribute" value="{$product.id_product_attribute}">
      {/if}

      <button
        class="add-to-cart-btn add-to-cart"
        data-button-action="add-to-cart"
        type="submit"
        {if !$product.add_to_cart_url}
          disabled
        {/if}
      >
        {l s='Ajouter' d='Shop.Theme.Actions'}
      </button>
    </form>
  </div>
{/if}
