$(window).load(function() {
    $('input[value="Book a Test Drive"]').click(function() {
        utag.link({
            "car.ModelName": $('div#bookTestDrive .chosen-single').eq(0).text(),
            "event.Action": "Submit",
            "event.Category": "Form",
            "event.Label": "Testdrive Enquiry",
            "event.Name": "goal_book_testdrive",
            "event.NonInteraction": "0",
            "partner.InformationLocation": "Waverley",
            "partner.InformationName": "Waverley Volkswagen"
        });
    });
    $('span.phone,a[href="tel:0395505800"]').click(function() {
        utag.link({
            "event.Action": "Click",
            "event.Category": "Call",
            "event.Label": "03 9550 5800",
            "event.Name": "goal_clicktocall",
            "event.NonInteraction": "0",
            "partner.InformationLocation": "Waverley",
            "partner.InformationName": "Waverley Volkswagen"
        });
    });
    $('form.value-my-car  input[type=submit]').click(function() {
        utag.link({
            "event.Action": "Submit",
            "event.Category": "Form",
            "event.Label": "Trade in Value  Enquiry",
            "event.Name": "goal_contact_enquiry",
            "event.NonInteraction": "0",
            "partner.InformationLocation": "Waverley",
            "partner.InformationName": "Waverley Volkswagen"
        });
    });
    $('form#formPartsEnquiry button[type=submit]').click(function() {
        utag.link({
            "event.Action": "Submit",
            "event.Category": "Form",
            "event.Label": "Parts Enquiry",
            "event.Name": "goal_contact_enquiry",
            "event.NonInteraction": "0",
            "partner.InformationLocation": "Waverley",
            "partner.InformationName": "Waverley Volkswagen"
        });
    });
    $('div#financeEnquiry input[type=submit]').click(function() {
        utag.link({
            "event.Action": "Submit",
            "event.Category": "Form",
            "event.Label": "Finance Enquiry",
            "event.Name": "goal_contact_enquiry",
            "event.NonInteraction": "0",
            "partner.InformationLocation": "Waverley",
            "partner.InformationName": "Waverley Volkswagen"
        });
    });
    $('div#contact-form-section input[type=submit]').click(function() {
        utag.link({
            "event.Action": "Submit",
            "event.Category": "Form",
            "event.Label": "Contact Enquiry",
            "event.Name": "goal_contact_enquiry",
            "event.NonInteraction": "0",
            "partner.InformationLocation": "Waverley",
            "partner.InformationName": "Waverley Volkswagen"
        });
    });
    if (document.location.href.includes('/vehicles/')) {
        $('a[data-reveal-ajax]').eq(0).click(function() {
            utag.link({
                "car.CarlineName": [$('.bread-crumbs').text().split('/')[3].trim()],
                "event.Action": "Download",
                "event.Category": "Brochure",
                "event.Label": "Form",
                "event.Name": "goal_download_brochure",
                "event.NonInteraction": "0",
                "partner.InformationLocation": "Waverley",
                "partner.InformationName": "Waverley Volkswagen"
            });
        });
    };
    $('a').click(function() {
        utag.link({
            "event.Action": "Click",
            "event.Category": "TextLinkClick",
            "event.Label": $(this).attr('href'),
            "event.Name": "general_TextLink_click",
            "event.NonInteraction": "0"
        });
    });
    $('form[name=search_form] button#vse-search-btn').click(function() {
        utag.link({
            "event.Action": "Click",
            "event.Category": "Car Search",
            "event.Label": $(this).text().length !== 0 ? $(this).text() : $(this).val(),
            "event.Name": "general_Event_search",
            "event.NonInteraction": "0"
        });
    });
    $('button,input[type=button]').click(function() {
        utag.link({
            "event.Action": "Click",
            "event.Category": "Button",
            "event.Label": $(this).text().length !== 0 ? $(this).text() : $(this).val(),
            "event.Name": "general_Event_buttonclick",
            "event.NonInteraction": "0"
        });
    });
    $('form input[type=submit]').click(function() {
        utag.link({
            "event.Action": "Submit",
            "event.Category": "Form",
            "event.Label": $(this).val(),
            "event.Name": "general_Event_formsubmit",
            "event.NonInteraction": "0",
            "partner.InformationLocation": "Waverley",
            "partner.InformationName": "Waverley Volkswagen"
        });
    });
});