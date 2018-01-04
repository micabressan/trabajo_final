

// NAV

var ww = document.body.clientWidth;

jQuery(document).ready(function($) {
  $(".nav li a").each(function() {
    if ($(this).next().length > 0) {
    	$(this).addClass("parent");
		};
	})

	$(".toggleMenu").click(function(e) {
		e.preventDefault();
		$(this).toggleClass("active");
		$(".nav").toggle();
	});
	adjustMenu();


$(window).bind('resize orientationchange', function() {
	ww = document.body.clientWidth;
	adjustMenu();
});

var adjustMenu = function($) {
	if (ww < 770) {
    // if "more" link not in DOM, add it
    if (!$(".more")[0]) {
    $('<div class="more">&nbsp;</div>').insertBefore($('.parent'));
    }
		$(".toggleMenu").css("display", "inline-block");
		if (!$(".toggleMenu").hasClass("active")) {
			$(".nav").hide();
		} else {
			$(".nav").show();
		}
		$(".nav li").unbind('mouseenter mouseleave');
		$(".nav li a.parent").unbind('click');
    $(".nav li .more").unbind('click').bind('click', function() {

			$(this).parent("li").toggleClass("hover");
		});
	}
	else if (ww >= 770) {
    // remove .more link in desktop view
    $('.more').remove();
		$(".toggleMenu").css("display", "none");
		$(".nav").show();
		$(".nav li").removeClass("hover");
		$(".nav li a").unbind('click');
		$(".nav li").unbind('mouseenter mouseleave').bind('mouseenter mouseleave', function() {
		 	// must be attached to li so that mouseleave is not triggered when hover over submenu
		 	$(this).toggleClass('hover');
		});
	}
}


// TOP


if ($('#back-to-top').length) {
    var scrollTrigger = 200, // px
        backToTop = function () {
            var scrollTop = $(window).scrollTop();
            if (scrollTop > scrollTrigger) {
                $('#back-to-top').addClass('show');
            } else {
                $('#back-to-top').removeClass('show');
            }
        };
    backToTop();
    $(window).on('scroll', function () {
        backToTop();
    });
    $('#back-to-top').on('click', function (e) {
        e.preventDefault();
        $('html,body').animate({
            scrollTop: 0
        }, 700);
    });
}


// SLIDER

    jQuery(document).ready(function($) {

      $("#owl-demo").owlCarousel({
     	  autoPlay: 3000,
          navigation : false,
          slideSpeed : 300,
          paginationSpeed : 400,
          singleItem:true


      });

    });


// EQUAL ROWS

jQuery(document).ready(function($) {

equalheight = function(container){

var currentTallest = 0,
     currentRowStart = 0,
     rowDivs = new Array(),
     $el,
     topPosition = 0;
 $(container).each(function() {

   $el = $(this);
   $($el).height('auto')
   topPostion = $el.position().top;

   if (currentRowStart != topPostion) {
     for (currentDiv = 0 ; currentDiv < rowDivs.length ; currentDiv++) {
       rowDivs[currentDiv].height(currentTallest);
     }
     rowDivs.length = 0; // empty the array
     currentRowStart = topPostion;
     currentTallest = $el.height();
     rowDivs.push($el);
   } else {
     rowDivs.push($el);
     currentTallest = (currentTallest < $el.height()) ? ($el.height()) : (currentTallest);
  }
   for (currentDiv = 0 ; currentDiv < rowDivs.length ; currentDiv++) {
     rowDivs[currentDiv].height(currentTallest);
   }
 });
}

$(window).load(function() {
  equalheight('.equal');
});


$(window).resize(function(){
  equalheight('.equal');
});

});


// faq toggle

$(".faq-title").click(function () {
	$(this).next(".faq-details").toggle("fast");
	$(this).toggleClass('opened');
});

})