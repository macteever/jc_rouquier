<div class="product-tabs">
  <div class="tabs-header">
    <button type="button" data-tab="description">Description</button>
    <button type="button" data-tab="features">Caractéristiques techniques</button>
    <button type="button" data-tab="details">Détails produit</button>
  </div>

  <div class="tabs-content">
    <div class="tab-panel" id="description">
      {$product.description nofilter}
    </div>

    <div class="tab-panel" id="features">
      {if !empty($product.features)}
        {foreach from=$product.features item=feature}
          <div class="feature-row">
            <span class="feature-name">{$feature.name}</span>
            <span class="feature-value">{$feature.value}</span>
          </div>
        {/foreach}
      {else}
        <div>Aucune caractéristique technique.</div>
      {/if}
    </div>

    <div class="tab-panel" id="details">
      {if $product.reference}
        <div>Référence : {$product.reference}</div>
      {/if}

      {if $product.manufacturer_name}
        <div>Marque : {$product.manufacturer_name}</div>
      {/if}

      {if $product.ean13}
        <div>EAN : {$product.ean13}</div>
      {/if}

      {if $product.weight}
        <div>Poids : {$product.weight}</div>
      {/if}
    </div>
  </div>
</div>
