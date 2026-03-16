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
 *}
{extends file=$layout}

{block name='head' append}
  <meta property="og:type" content="product">
  {if $product.cover}
    <meta property="og:image" content="{$product.cover.large.url}">
  {/if}

  {if $product.show_price}
    <meta property="product:pretax_price:amount" content="{$product.price_tax_exc}">
    <meta property="product:pretax_price:currency" content="{$currency.iso_code}">
    <meta property="product:price:amount" content="{$product.price_amount}">
    <meta property="product:price:currency" content="{$currency.iso_code}">
  {/if}
  {if isset($product.weight) && ($product.weight != 0)}
    <meta property="product:weight:value" content="{$product.weight}">
    <meta property="product:weight:units" content="{$product.weight_unit}">
  {/if}
{/block}

{block name='head_microdata_special'}
  {include file='_partials/microdata/product-jsonld.tpl'}
{/block}

{block name='content'}
  <section id="main" class="product-page">
    <meta content="{$product.url}">

    <div class="product-layout js-product-container">
      <div class="product-gallery">
        {include file='catalog/_partials/product-flags.tpl'}
        {include file='catalog/_partials/product-cover-thumbnails.tpl'}
      </div>

      <div class="product-info">
        <div class="product-header">
          <div class="product-reference">
            Réf: {if $product.reference}{$product.reference}{else}-{/if}
          </div>

          <h1 class="product-title">{$product.name}</h1>

          <div class="product-short-description">
            {$product.description_short nofilter}
          </div>
        </div>
        {block name='notifications'}
          {include file='_partials/notifications.tpl'}
        {/block}
        <div class="product-price-block">
          {block name='product_prices'}
            {include file='catalog/_partials/product-prices.tpl'}
          {/block}
        </div>

        <div class="product-buy-block js-product-actions">
          <form action="{$urls.pages.cart}" method="post" id="add-to-cart-or-refresh">
            <input type="hidden" name="token" value="{$static_token}">
            <input type="hidden" name="id_product" value="{$product.id}" id="product_page_product_id">
            <input type="hidden" name="id_customization" value="{$product.id_customization}" id="product_customization_id" class="js-product-customization-id">

            {if $product.is_customizable && count($product.customizations.fields)}
              {include file='catalog/_partials/product-customization.tpl' customizations=$product.customizations}
            {/if}

            <div class="product-variants">
              {block name='product_variants'}
                {include file='catalog/_partials/product-variants.tpl'}
              {/block}
            </div>

            {if $packItems}
              <section class="product-pack">
                <p>{l s='This pack contains' d='Shop.Theme.Catalog'}</p>
                {foreach from=$packItems item='product_pack'}
                  {include file='catalog/_partials/miniatures/pack-product.tpl' product=$product_pack showPackProductsPrice=$product.show_price}
                {/foreach}
              </section>
            {/if}

            {include file='catalog/_partials/product-discounts.tpl'}

            <div class="product-add-to-cart">
              {block name='product_add_to_cart'}
                {include file='catalog/_partials/product-add-to-cart.tpl'}
              {/block}
            </div>

            {include file='catalog/_partials/product-additional-info.tpl'}

            {block name='product_refresh'}{/block}
          </form>
        </div>

        <div class="product-reassurance">
          <div class="reassurance-item flex-col gap-5">
            <div class="flex-row gap-10">
              <img src="{$smarty.const._THEME_DIR_}assets/img/icons/ship.svg" alt="sécurité" loading="lazy">
              <span class="fs-16 fw-600">Livraison rapide</span>
            </div>
            Expédition sous 24-48h pour les produits en stock
          </div>
          <div class="reassurance-item flex-col gap-5">
            <div class="flex-row gap-10">
              <img src="{$smarty.const._THEME_DIR_}assets/img/icons/send-back.svg" alt="sécurité" loading="lazy">
              <span class="fs-16 fw-600">Retours possibles</span>
            </div>
            Retour gratuit sous 30 jours pour les professionnels
          </div>
          <div class="reassurance-item flex-col gap-5">
            <div class="flex-row gap-10">
              <img src="{$smarty.const._THEME_DIR_}assets/img/icons/shield.svg" alt="sécurité" loading="lazy">
              <span class="fs-16 fw-600">Garantie professionnelle</span>
            </div>
            Retour gratuit sous 30 jours pour les professionnels
          </div>
        </div>
      </div>
    </div>

    {block name='product_tabs'}
      {include file='catalog/_partials/product-tabs.tpl'}
    {/block}

    {block name='product_footer'}
      {hook h='displayFooterProduct' product=$product category=$category}
    {/block}

    {block name='product_images_modal'}
      {include file='catalog/_partials/product-images-modal.tpl'}
    {/block}
  </section>
{/block}
