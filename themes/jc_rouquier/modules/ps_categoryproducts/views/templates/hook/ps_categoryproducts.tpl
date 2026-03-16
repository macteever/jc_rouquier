{if $products}
<section class="product-similar">
  <div class="product-similar-header">
    <h2>Produits similaires</h2>

    <div class="product-similar-nav">
      <button class="product-similar-prev" type="button" aria-label="Produits précédents">
        ←
      </button>
      <button class="product-similar-next" type="button" aria-label="Produits suivants">
        →
      </button>
    </div>
  </div>

  <div class="swiper product-similar-swiper">
    <div class="swiper-wrapper">
      {foreach from=$products item="product"}
        <div class="swiper-slide">
          {include file='catalog/_partials/miniatures/product.tpl' product=$product}
        </div>
      {/foreach}
    </div>
  </div>
</section>
{/if}
