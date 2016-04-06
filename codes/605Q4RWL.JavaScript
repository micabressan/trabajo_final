/** @type {jQuery} */
var $document = $( document );
/** @type {jQuery} */
var $window = $( window );
/** @type {jQuery} */
var $wrapepr = $( '#wrapper' );
/** @type {int} */
var counter = $( '.block' ).last().text() || 0;
/** @type {int} */
var i;
/** @type {int} */
var itemHeight = $( '.block' ).first().height();
	
/**
* @return int Document height
*/
function getDocumentHeight()
{
	var db = document.body;
	var dde = document.documentElement;

	return Math.max( db.scrollHeight, dde.scrollHeight, db.offsetHeight, dde.offsetHeight, db.clientHeight, dde.clientHeight );
}

/**
* @return int Document scroll
*/
function getDocumentScroll()
{
	return window.pageYOffset || document.documentElement.scrollTop;
}

/**
* @return string Random color in hex (#xxxxxx) format
*/
function getRandomColor()
{
	return '#'+(0x1000000+(Math.random())*0xffffff).toString(16).substr(1,6);
}

$window.on( 'scroll',
	$.debounce(
		200,
		function() {
			/** @type {int} */
			var windowHeight = window.height;
			/** @type {int} */
			var scrollTop = getDocumentScroll();
			/** @type {int} */
			var documentHeight = getDocumentHeight();
			/** @type {int} */
			var newElementsCount = 1 + Math.floor( windowHeight / itemHeight );
			
			if ( documentHeight <= scrollTop + ( windowHeight / 2 ) )
			{
				for( i = counter; i < counter + newElementsCount; i++ )
				{
					$( '<div/>', {
						'class': 'block',
						'text': i
					} ).appendTo( $wrapper ).css({
						backgroundColor: getRandomColor() // только ебланы так делают, есть классы для этого с заранее определенным набором цветом, кейс бессмысcленен почти полностью
					});
				}
					
				counter = i;
			}
		}
	)
);