{if !$configuration.is_catalog}
  <div class="product-miniature-add-to-cart">
    <form action="{$urls.pages.cart}" method="post" class="add-to-cart-or-refresh">
      <input type="hidden" name="token" value="{$static_token}">
      <input type="hidden" name="id_product" value="{$product.id_product}">
      <input type="hidden" name="qty" value="1">

      {if !empty($product.id_product_attribute)}
        <input type="hidden" name="id_product_attribute" value="{$product.id_product_attribute}">
      {/if}

      <button
        class="add-to-cart-btn add-to-cart"
        data-button-action="add-to-cart"
        type="submit"
      >
        {l s='Ajouter au devis' d='Shop.Theme.Actions'}
      </button>
    </form>
  </div>
{/if}
