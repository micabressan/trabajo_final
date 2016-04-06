$(function() {
	var BASE_URL = 'http://scribblegrid.com/';

	/* Canvas */
	// Globals
	var pixSize = 8, canvasSize = 512, lastPoint = null, currentColor = "000", mouseDown = 0;
	var mainPixelDataRef, northPixelDataRef, eastPixelDataRef, southPixelDataRef, westPixelDataRef;
	var messagesRef;
	
	var colors = ["000","f00","0f0","00f","88f","f8d","f88","f05","f80","0f8","cf0","08f","408","8ff"];
	var userColor = colors[Math.floor(Math.random()*colors.length)];
	// Prevent light usernames
	colors.splice(-1, 0, "ff8");
	colors.unshift('fff');
	
	
	// Draw a line from the mouse's last position to its current position
	var drawLineOnMouseMove = function(e) {
		if (!mouseDown) return;

		e.preventDefault();

		// Bresenham's line algorithm. We use this to ensure smooth lines are drawn
		var offset = $('#drawing-canvas').offset();
		var x1 = Math.floor((e.pageX - offset.left) / pixSize), // pixSize - 1?
		y1 = Math.floor((e.pageY - offset.top) / pixSize - 0.2); // -"-
		var x0 = (lastPoint == null) ? x1 : lastPoint[0];
		var y0 = (lastPoint == null) ? y1 : lastPoint[1];
		var dx = Math.abs(x1 - x0), dy = Math.abs(y1 - y0);
		var sx = (x0 < x1) ? 1 : -1, sy = (y0 < y1) ? 1 : -1, err = dx - dy;
		while (true) {
			//write the pixel into Firebase, or if we are drawing white, remove the pixel
			mainPixelDataRef.child(x0 + ":" + y0).set(currentColor === "fff" ? null : currentColor);

			if (x0 == x1 && y0 == y1) break;
			var e2 = 2 * err;
			if (e2 > -dy) {
				err = err - dy;
				x0 = x0 + sx;
			}
			if (e2 < dx) {
				err = err + dx;
				y0 = y0 + sy;
			}
		}
		lastPoint = [x1, y1];
	};
	
	// Add callbacks that are fired any time the pixel data changes and adjusts the canvas appropriately.
	// Note that child_added events will be fired for initial pixel data as well.
	var drawPixel = function(snapshot, context) {
		var coords = snapshot.name().split(":");
		context.fillStyle = "#" + snapshot.val();
		context.fillRect(parseInt(coords[0]) * pixSize, parseInt(coords[1]) * pixSize, pixSize, pixSize);
	}
	var clearPixel = function(snapshot, context) {
		var coords = snapshot.name().split(":");
		context.clearRect(parseInt(coords[0]) * pixSize, parseInt(coords[1]) * pixSize, pixSize, pixSize);
	};
	
	var setUpListeners = function(dataRef, context) {
		dataRef.on('child_added', function(snapshot) {
			drawPixel(snapshot, context);
		});
		dataRef.on('child_changed', function(snapshot) {
			drawPixel(snapshot, context);
		});
		dataRef.on('child_removed', function(snapshot) {
			clearPixel(snapshot, context);
		});		
	}
	
	var changeRoom = function(navigator, cardinal) {
		/* Location */
		
		if (navigator) {
			var href = $(navigator).attr('href');
			window.location = BASE_URL + href;
			ga('send', 'event', 'room', 'change', {'page': '/' + href});
		}
		
		var room;

		if (window.location.hash) {
			room = window.location.hash.replace('#', '');
		} else {
			room = '0,0';
		}
		
		var roomCoordinates = room.split(',');

		if (roomCoordinates.length > 1) {
			var roomX = Number(roomCoordinates[0]);
			var roomY = Number(roomCoordinates[1]);
			var northCoords = roomX + ',' + (roomY + 1);
			var eastCoords = (roomX + 1) + ',' + roomY;
			var southCoords = roomX + ',' + (roomY - 1);
			var westCoords = (roomX - 1) + ',' + roomY;
			
			$('#room span:eq(0)').html(roomX);
			$('#room span:eq(1)').html(roomY);
		} else {
			$('#room').hide();
		}
		
		var oppositeCardinal;
		
		if (navigator) {
			// Remove old event listener
			$('#drawing-canvas').unbind();
			
			switch (cardinal) {
				case 'north':
					mainPixelDataRef = northPixelDataRef;
					oppositeCardinal = 'south';
					break;
				case 'east':
					mainPixelDataRef = eastPixelDataRef;
					oppositeCardinal = 'west';
					break;
				case 'south':
					mainPixelDataRef = southPixelDataRef;
					oppositeCardinal = 'north';
					break;
				case 'west':
					mainPixelDataRef = westPixelDataRef;
					oppositeCardinal = 'east';
					break;
			}
			
			mainPixelDataRef.off();
			northPixelDataRef.off();
			eastPixelDataRef.off();
			southPixelDataRef.off();
			westPixelDataRef.off();
			
			$('#' + cardinal + '-canvas').before('<canvas id="new-canvas" class="canvas-thumb ' + cardinal + '" width="' + canvasSize + '" height="' + canvasSize + '"></canvas>');
			$('#drawing-canvas').before($('#' + cardinal + '-canvas'));
			$('#' + oppositeCardinal + '-canvas').before($('#drawing-canvas'));
			$('#' + oppositeCardinal + '-canvas').remove();
			$('#drawing-canvas').attr('id', oppositeCardinal + '-canvas');
			$('#' + cardinal + '-canvas').attr('id', 'drawing-canvas');
			$('#drawing-canvas').removeAttr('class')
			$('#' + oppositeCardinal + '-canvas').addClass('canvas-thumb ' + oppositeCardinal);
			$('#new-canvas').attr('id', cardinal + '-canvas');
		}
		
		// Set up main canvas
		var mainCanvas = document.getElementById('drawing-canvas');
		var mainContext = mainCanvas.getContext ? mainCanvas.getContext('2d') : null;
		if (mainContext == null) {
			alert("You must use a browser that supports HTML5 Canvas.");
			return;
		}

		// Keep track of if the mouse is up or down
		mainCanvas.onmousedown = function () { mouseDown = 1; return false; };
		mainCanvas.onmouseout = mainCanvas.onmouseup = function () {
			mouseDown = 0; lastPoint = null;
		};
		
		$(mainCanvas).mousemove(drawLineOnMouseMove);
		$(mainCanvas).mousedown(drawLineOnMouseMove);
		
		mainPixelDataRef = new Firebase('https://scribblegrid.firebaseIO.com/canvas/' + room);
		setUpListeners(mainPixelDataRef, mainContext);
		
		// Setup and create references to adjacent rooms
		if (roomCoordinates.length > 1) {
				var northCanvas = document.getElementById('north-canvas');
				var northContext = northCanvas.getContext('2d');
				northContext.clearRect(0, 0, canvasSize, canvasSize);
				northPixelDataRef = new Firebase('https://scribblegrid.firebaseIO.com/canvas/' + northCoords);
				setUpListeners(northPixelDataRef, northContext);
				
				var eastCanvas = document.getElementById('east-canvas');
				var eastContext = eastCanvas.getContext('2d');
				eastContext.clearRect(0, 0, canvasSize, canvasSize);
				eastPixelDataRef = new Firebase('https://scribblegrid.firebaseIO.com/canvas/' + eastCoords);
				setUpListeners(eastPixelDataRef, eastContext);

				var southCanvas = document.getElementById('south-canvas');
				var southContext = southCanvas.getContext('2d');
				southContext.clearRect(0, 0, canvasSize, canvasSize);
				southPixelDataRef = new Firebase('https://scribblegrid.firebaseIO.com/canvas/' + southCoords);
				setUpListeners(southPixelDataRef, southContext);

				var westCanvas = document.getElementById('west-canvas');
				var westContext = westCanvas.getContext('2d');
				westContext.clearRect(0, 0, canvasSize, canvasSize);
				westPixelDataRef = new Firebase('https://scribblegrid.firebaseIO.com/canvas/' + westCoords);
				setUpListeners(westPixelDataRef, westContext);
		}
		
		$('.navigator').each(function(index) {
			var coords;
			
			switch (index) {
				case 0:
					$(this).unbind().click(function (e) {
						e.preventDefault();
						changeRoom(this, 'north');
					});
					coords = northCoords;
					break;
				case 1:
					$(this).unbind().click(function (e) {
						e.preventDefault();
						changeRoom(this, 'west');
					});
					coords = westCoords;
					break;
				case 2:
					$(this).unbind().click(function (e) {
						e.preventDefault();
						changeRoom(this, 'east');
					});
					coords = eastCoords;
					break;
				case 3:
					$(this).unbind().click(function (e) {
						e.preventDefault();
						changeRoom(this, 'south');
					});
					coords = southCoords;
					break;
			}
			
			var self = this;
			
			$('#phone-navigator-' + index).unbind().click(function () {
				$(self).click();
			});
			
			$(this).attr('href', '#' + coords);
		});
		
		/* Chat */
		
		if (navigator) {
			$('#chat-form').unbind();
			messagesRef.off();
		}
		
		// Get a reference to the root of the chat data.
		messagesRef = new Firebase('https://scribblegrid.firebaseIO.com/chat/' + room);

		// When the user presses enter on the message input, write the message to firebase.
		$('#chat-form').submit(function (e) {
			e.preventDefault();
			var name = $('#name-input').val();
			var text = $('#message-input').val();
			if (text == '') {
				alert('Please enter a message.');
				return false;
			}
			if (name != '') {
				messagesRef.push({name:name, text:text, color: userColor});
				$('#message-input').val('');
				$('#name-input').hide();
				$('#message-input').focusWithoutScrolling();
			} else {
				alert('Please select a name.');
				$('#name-input').focusWithoutScrolling();
			}
		});
		
		if (navigator) {
			$('#messages').html('');
			$('<div id="loading" />').html('<img src="img/loader.gif" /> loading...').appendTo($('#messages'));
			$('#messages')[0].scrollTop = $('#messages')[0].scrollHeight;
			$('#message-input').focusWithoutScrolling();
		}
		
		messagesRef.once('value', function (snapshot) {
			if(snapshot.val() === null) {
				$('#loading').remove();
				$('#initializing').remove();
				$('<div />').html('<strong>#' + room + '</strong>').appendTo($('#messages'));
				$('<div id="saysomething" />').html('<em>Say something...</em>').appendTo($('#messages'));
			} else {
				$('<div />').html('<strong>#' + room + '</strong>').appendTo($('#messages'));
			}
		});
		
		// Add a callback that is triggered for each chat message.
		messagesRef.limit(10).on('child_added', function (snapshot) {
			$('#loading').remove();
			$('#saysomething').remove();
			var message = snapshot.val();
			$('<div/>').text(message.text).prepend($('<strong style="color: #' + message.color + '" />').text(message.name+': ')).appendTo($('#messages'));
			$('#messages')[0].scrollTop = $('#messages')[0].scrollHeight;
		});
	}
	
	// Setup each color palette & add it to the screen
	for (c in colors) {
		var item = $('<div/>').css("background-color", '#' + colors[c]).addClass("colorbox");
		item.click((function () {
			var col = colors[c];
			return function () {
			currentColor = col;
			};
		})());
		item.appendTo('#colorholder');
	}
	
	// Init
	changeRoom(false, false);
	$('#message-input').focusWithoutScrolling();
	currentColor = "fff";
				for (var x = 0; x < 64; x++) {
	        		for (var y = 0; y < 64; y++) {

		        		mainPixelDataRef.child(x + ":" + y).set(currentColor === "fff" ? null : currentColor);

		        	}
		        }
    
});