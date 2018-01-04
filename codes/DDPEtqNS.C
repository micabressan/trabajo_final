(deftemplate car
			(slot manufacturer)
			(slot model)
			(slot color)
			(slot seats)
			(slot doors)
			(slot class)
			(slot body-style)
			(slot transmission)
			(slot engine-volume))
(defrule user-input
	=> 
	(printout t "Color? ")
	(assert (color (read)))
	(printout t "Seats? ")
	(assert (seats (read)))
	(printout t "Doors? ")
	(assert (doors (read)))
	(printout t "Class? (midsize/compact/family-car) ")
	(assert (class (read)))
	(printout t "Body style? (hatchback/sedan/minivan) ")
	(assert (body-style (read)))
	(printout t "Transmission? (automatic/manual) ")
	(assert (transmission (read))))
(defrule pick-a-car 
		(color ?color) 
		(seats ?seats)
		(doors ?doors)
		(class ?class)
		(body-style ?body-style)
		(transmission ?transmission)
		?car <- (car (color ?color)
				(seats ?seats)
				(doors ?doors)
				(class ?class)
				(body-style ?body-style)
				(transmission ?transmission)) 
		=>
		(printout t "This car totally matches your preferences: " (fact-slot-value ?car manufacturer) " "
					(fact-slot-value ?car model) ", engine volume "
					(fact-slot-value ?car engine-volume) crlf))
					

(defrule pick-a-car-by-color
		(color ?color) 
		?car <- (car (color ?color)) 
		=>
		(printout t "This model matches by the color " ?color " : "
					(fact-slot-value ?car manufacturer) " "
					(fact-slot-value ?car model) ", seats count: "
					(fact-slot-value ?car seats) ", doors count: "
					(fact-slot-value ?car doors) ", class: "
					(fact-slot-value ?car class) ", body-style: "
					(fact-slot-value ?car body-style) ", transmission type: "
					(fact-slot-value ?car transmission) ", engine volume: "
					(fact-slot-value ?car engine-volume) crlf))
					
(defrule pick-a-car-by-class
		(class ?class) 
		?car <- (car (class ?class)) 
		=>
		(printout t "This model matches by the class " ?class " : "
					(fact-slot-value ?car manufacturer) " "
					(fact-slot-value ?car model) ", color: "
					(fact-slot-value ?car color) ", seats count: "
					(fact-slot-value ?car seats) ", doors count: "
					(fact-slot-value ?car doors) ", body-style: "
					(fact-slot-value ?car body-style) ", transmission type: "
					(fact-slot-value ?car transmission) ", engine volume: "
					(fact-slot-value ?car engine-volume) crlf))

(deffunction reset-all ()
	(reset)
	(load-facts "C:\\cars.txt"))