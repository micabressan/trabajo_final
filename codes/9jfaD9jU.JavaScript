$(".product select").select2();
		$('.pluse').click(function () {
			var category_id = parseInt($('.category:last').attr('data-id'))+1;
			var input =
				'<div class="category" data-id="'+category_id+'">'+
				'<label></label>'+
				'<input id="Catalog_catalog_category_id_'+category_id+'" class="span5" type="text" name="Catalog[catalog_category_id]['+category_id+']" maxlength="255">'+
				'</div>';
			pluse2();
			$('.categories').append(input);

		});
		function pluse2() {
			$('.pluse2').click(function () {

				var category = $(this).parents('.category');
				var category_id = parseInt(category.attr('data-id'));
				var product_id = parseInt(category.find('.product:last').attr('data-id')) + 1;
				$(".product select").select2();
				var clone_product = category.find('.product:last').clone();
				clone_product.attr('data-id', product_id);
				clone_product.find('select').attr({
					id: 'Catalog_products_' + category_id + '_' + product_id,
					name: 'Catalog[products][' + category_id + '][' + product_id + '][]'
				});
				clone_product.find('input').attr({
					id: 'Catalog_products_' + category_id + '_' + product_id,
					name: 'Catalog[products][' + category_id + '][' + product_id + '][]'
				});
				clone_product.find('.pluse2').remove();
				clone_product.find('.select2').remove();

				category.find('.products').append(clone_product);
				$('select#Catalog_products_' + category_id + '_' + product_id).select2();
			});
		}
		pluse2();