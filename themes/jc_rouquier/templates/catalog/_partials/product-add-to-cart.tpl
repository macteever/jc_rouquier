{if !$configuration.is_catalog}

<div class="product-add-to-cart js-product-add-to-cart">

  <form action="{$urls.pages.cart}" method="post" class="add-to-cart-or-refresh">

    <input type="hidden" name="token" value="{$static_token}">
    <input type="hidden" name="id_product" value="{$product.id_product}" class="product_page_product_id">
    <input type="hidden" name="id_customization" value="0">

    {if !empty($product.id_product_attribute)}
      <input type="hidden" name="id_product_attribute" value="{$product.id_product_attribute}">
    {/if}

    {if $page.page_name == 'product'}
      <div class="product-quantity">
        <div>
          <button type="button" class="qty-btn qty-down">−</button>

          <input
            type="number"
            name="qty"
            value="{$product.minimal_quantity}"
            min="{$product.minimal_quantity}"
            class="qty-input"
          >

          <button type="button" class="qty-btn qty-up">+</button>

          <span class="minimal-qty">
            Min. commande: {$product.minimal_quantity} unité
          </span>
        </div>

      </div>
    {/if}

    <button
      class="add-to-cart-btn add-to-cart"
      data-button-action="add-to-cart"
      type="submit"
      {if !$product.add_to_cart_url}
        disabled
      {/if}
    >
      {l s='Ajouter au devis' d='Shop.Theme.Actions'}
    </button>

  </form>

</div>

{/if}