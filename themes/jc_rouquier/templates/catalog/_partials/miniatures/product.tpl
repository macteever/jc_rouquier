{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}
{block name='product_miniature_item'}
<div class="js-product product">
  <article class="product-miniature js-product-miniature product-card" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}">
    <a href="{$product.url}" class="product-card-image">
      {if $product.cover}
        <img
          src="{$product.cover.bySize.home_default.url}"
          alt="{$product.name}"
          loading="lazy"
        >
      {else}
        <img
          src="{$urls.no_picture_image.bySize.home_default.url}"
          alt="{$product.name}"
          loading="lazy"
        >
      {/if}
    </a>

    <div class="product-card-body">
      <div class="flex-col">
        <h3 class="product-card-title">
          <a class="fw-500 color-primary" href="{$product.url}">
            {$product.name}
          </a>
        </h3>

        <div class="product-card-reference">
          Réf: {if $product.reference}{$product.reference}{else}-{/if}
        </div>
      </div>

      <div class="flex-col gap-10">
        <div>
          {if $product.show_price}
            <div class="product-card-price fw-700 color-primary fs-20">
              {$product.price}
            </div>
          {/if}

          <div class="product-card-unit fs-12">
            HT / unité
          </div>
        </div>

        <div class="product-card-actions">
          {include file='catalog/_partials/product-miniature-add-to-cart.tpl'}

          <a href="{$product.url}" class="product-details-btn">
            Détails
          </a>
        </div>
      </div>
    </div>
  </article>
</div>
{/block}
