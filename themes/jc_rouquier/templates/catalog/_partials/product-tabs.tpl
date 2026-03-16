<section class="product-tabs">
  {if $product.description}
    <div class="product-tab" id="description">
      <h2>{l s='Description' d='Shop.Theme.Catalog'}</h2>
      <div class="product-description">{$product.description nofilter}</div>
    </div>
  {/if}

  <div class="product-tab" id="product-details">
    <h2>{l s='Product Details' d='Shop.Theme.Catalog'}</h2>
    {include file='catalog/_partials/product-details.tpl'}
  </div>

  {if $product.attachments}
    <div class="product-tab" id="attachments">
      <h2>{l s='Attachments' d='Shop.Theme.Catalog'}</h2>
      <section class="product-attachments">
        {foreach from=$product.attachments item=attachment}
          <div class="attachment">
            <h3>
              <a href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">{$attachment.name}</a>
            </h3>
            <p>{$attachment.description}</p>
            <a href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">
              {l s='Download' d='Shop.Theme.Actions'} ({$attachment.file_size_formatted})
            </a>
          </div>
        {/foreach}
      </section>
    </div>
  {/if}

  {foreach from=$product.extraContent item=extra key=extraKey}
    <div class="product-tab {$extra.attr.class}" id="extra-{$extraKey}" {foreach $extra.attr as $key => $val} {$key}="{$val}"{/foreach}>
      <h2>{$extra.title}</h2>
      {$extra.content nofilter}
    </div>
  {/foreach}
</section>
