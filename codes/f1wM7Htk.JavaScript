$(document).ready(function() {
  $(window).scroll(function() {

    if ($(this).scrollTop() > 6) {
      $('.search_n_find .pre').css({
        color: '#202020',
        transition: 'color 1s'
      });
    } else {
      console.log('pre white');
      $('.search_n_find .pre').css({
        color: '#FFFFFF !important',
        transition: 'color 1s'
      });
    }

    var scrollingMagic = function (className, scroll, scroll2) {
      if ($(window).scrollTop() > scroll && $(window).scrollTop() < 1800) {
        $(className).css({
          color: '#FFFFFF',
          transition: 'color 1s'
        });
      } else if ($(window).scrollTop() > 1800) {
        $(className).css({
          // color: 'black',
          color: '#3E3D3E',
          transition: 'color 1s'
        });

      } else {
        $(className).css({
          color: '#202020',
          transition: 'color 1s'
        });
      }

      if (className === '.search_c' || className === '.search_m' || className === '.search_y' || className === '.search_k') {
        if ($(window).scrollTop() > scroll || $(window).scrollTop() > scroll2 && $(window).scrollTop() < 1799) {
          $(className).css({
            color: '#FFFFFF',
            transition: 'color 0.5s'
          });
        }
      }

      if ($(window).scrollTop() < 6) {
        $(className).css({
          color: '#FFFFFF',
          transition: 'color 1s'
        });
      }

      if ($(window).scrollTop() < 6) {
        $('.pre').css({
          color: '#FFFFFF',
          transition: 'color 1s'
        });
      }
    }

    scrollingMagic('.search_brand', 150);
    scrollingMagic('.search_create', 300);
    scrollingMagic('.search_unique', 450);
    scrollingMagic('.search_make', 600);
    scrollingMagic('.search_passion', 750);
    scrollingMagic('.search_style', 900);
    scrollingMagic('.search_design', 1050);
    scrollingMagic('.search_think', 1200);
    scrollingMagic('.search_solution', 1350);
    scrollingMagic('.search_c', 1800, 300);
    scrollingMagic('.search_m', 1800, 600);
    scrollingMagic('.search_y', 1800, 900);
    scrollingMagic('.search_k', 1800, 1200);
  }
}