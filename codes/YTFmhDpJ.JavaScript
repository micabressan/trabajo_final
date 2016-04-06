<!-- Syntax is probably incorrect, that's just an example -->

<div class="unique_class" data-isRendered="false"><!-- lots of carousel code --></div>
<script type="text/javascript">
	jQuery.each(".unique_class", function(){
		if (jQuery(this).data("isRendered") == "false") {
			//Here goes js that make things work
			jQuery(this).data("isRendered", "true");
		}
	});
</script>