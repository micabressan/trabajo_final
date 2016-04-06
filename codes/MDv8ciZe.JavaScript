$(function(){
//INIT//
    $('.slider').width($('.slider a').length * 240);
    var $carouselDesktop    = $(".carousel-desktop"),
        $slider    = $(".slider"),
        carouselWidth = $(window).width(),
        sliderWidth = $slider.width(),
        difference = sliderWidth - carouselWidth;
        ratio = difference/carouselWidth,
        margin = 0,
        console.log("difference: "+ difference);
        console.log("CArousel: " +$(window).width());
        console.log("sliderWidth" +sliderWidth);
        console.log("ratio "+ratio);
        console.log(sliderWidth);
    $(window).resize(function(){
        carouselWidth = $(window).width();
        sliderWidth = $slider.width();
        difference = sliderWidth - carouselWidth;
        ratio = difference/carouselWidth;
        $slider.css({marginLeft: -difference});
        console.log("difference: "+ difference/2);
        console.log("CArousel: " +carouselWidth);
        console.log("sliderWidth" +sliderWidth);
        console.log("ratio "+ratio);
        console.log(sliderWidth);
    })
// $carouselDesktop.mouseenter(function(){
//     $slider.stop().animate({marginLeft: -difference}, 1000);
// })
var margin = 0;
var mouseIn =false;



$('img').click(function(event){
    event.preventDefault();
})
$carouselDesktop.mouseenter(function(event){
    console.log("mouse enter");
    margin = Math.round(event.pageX * (ratio+0.005));
    $slider.animate({marginLeft: -margin}, 500,function(){console.log("done");mouseIn = true; });
});
$carouselDesktop.mousemove(function(event){
    margin = Math.round(event.pageX * (ratio+0.005));
    if(margin < difference && mouseIn){
        console.log("w mousemove");
        $slider.css({marginLeft: -margin});
    }
        console.log(margin);
    });
$carouselDesktop.mouseleave(function(){
    console.log("jestem w mouse leave");
    mouseIn = false;
});
/////////////////////////////////////////DARKEN ON HOVER /////////////////////////////////////////////////
$('.darken').hover(function() {
    $(this).find('img').fadeTo(10, 0.5);
}, function() {
    $(this).find('img').fadeTo(10, 1);
});

});