(function ($) {

  $.fn.changeTag = function(tagname) {
    // Create a jquery element based on selector
    var old_elm = $(this);

    // Get the array of original dom objects
    var original_elements = old_elm.get();
    
    // Note: We get the original dom objects because jQuery objects do not 
    // provide access to the attributes array
    for (var i = 0; i < original_elements.length; i += 1) {

      // Create reference to original element in dom
      var original_element = original_elements[i];
      
      // Create new element with desired tagname
      var new_elm = $(document.createElement(tagname));
      
      // Add original element's inner elements to new element
      new_elm.html($(original_element).html());

      // Create an array of the original element's attributes;
      var original_attributes = original_element.attributes;
      
      // Create a new generic object that will hold the attributes for the new
      // element
      var attributes = new Object();

      for (var j = 0; j < original_attributes.length; j += 1) {
        var attribute = original_attributes[j];

        // Note: The attributes "nodeName","localName",and "name" appear to have
        // the same value, so I just chose one. It's entirely possible that
        // these could have different values in different contexts...
        //var name = attribute.localName;
        //var name = attribute.name;
        var name = attribute.nodeName;
        
        //Note: The attributes "nodeValue","textContext",and "value" appear to 
        // have the same value, so I just chose one. It's entirely possible that
        // these could have different values in different contexts...
        //var value = attribute.textContext;
        //var value = attribute.value;
        var value = attribute.nodeValue;

        //Populate attributes object
        attributes[name] = value;
      }

      //Assign attributes from old element to new element        
      new_elm.attr(attributes);
      
      //Replace old_element with new element 
      $(original_element).replaceWith(new_elm);
    }
  };

}(jQuery));