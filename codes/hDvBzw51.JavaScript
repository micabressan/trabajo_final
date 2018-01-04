function inputDriver() {
    var driver = new Object();
    driver.pesel = $('#peselArea').val();
    driver.firstname = $('#firstnameArea').val();
    driver.lastname = $('#lastnameArea').val();
    driver.dateOfBirth = $('#dateOfBirthArea').val();
    driver.placeOfBirth = $('#placeOfBirthArea').val();
    driver.firstLicense = $('#dateFirstLicenseArea').val();

    $.ajax({
        url: '/api/values/driver',
        type: 'POST',
        data: driver,
        success: function () {
            alert("hurraaaa");
        },
        error: function (jqXHR, exception) {
            var msg = "";
            if (jqXHR.status === 0) {
                msg = 'Not connect.\n Verify Network.';
            } else if (jqXHR.status == 404) {
                msg = 'Requested page not found. [404]';
            } else if (jqXHR.status == 500) {
                msg = 'Internal Server Error [500].';
            } else if (exception === 'parsererror') {
                msg = 'Requested JSON parse failed.';
            } else if (exception === 'timeout') {
                msg = 'Time out error.';
            } else if (exception === 'abort') {
                msg = 'Ajax request aborted.';
            } else {
                msg = 'Uncaught Error.\n' + jqXHR.responseText;
            }
            alert(msg);
        }
    });
}

$(document).ready(function () {
    $('.digit').keypress(digitValidator);
    $('.nodigit').keypress(nodigitValidator);
    $('.nodigitSpace').keypress(nodigitSpaceValidator);
    $('#submit').click(inputDriver);
});




function digitValidator() {
    return event.charCode >= 48 && event.charCode <= 57;
}

function nodigitValidator() {
    var polish = "ąćęłńóźżĄĆĘŁŃÓŹŻśŚ";
    return event.charCode >= 65 && event.charCode <= 90 ||
        event.charCode >= 97 && event.charCode <= 122 ||
        event.charCode === polish.charCodeAt(0) ||
        event.charCode === polish.charCodeAt(1) ||
        event.charCode === polish.charCodeAt(2) ||
        event.charCode === polish.charCodeAt(3) ||
        event.charCode === polish.charCodeAt(4) ||
        event.charCode === polish.charCodeAt(5) ||
        event.charCode === polish.charCodeAt(6) ||
        event.charCode === polish.charCodeAt(7) ||
        event.charCode === polish.charCodeAt(8) ||
        event.charCode === polish.charCodeAt(9) ||
        event.charCode === polish.charCodeAt(10) ||
        event.charCode === polish.charCodeAt(11) ||
        event.charCode === polish.charCodeAt(12) ||
        event.charCode === polish.charCodeAt(13) ||
        event.charCode === polish.charCodeAt(14) ||
        event.charCode === polish.charCodeAt(15) ||
        event.charCode === polish.charCodeAt(16) ||
        event.charCode === polish.charCodeAt(17) ||
        event.charCode === polish.charCodeAt(18);
};

function nodigitSpaceValidator() {
    var polish = "ąćęłńóźżĄĆĘŁŃÓŹŻśŚ";
    return event.charCode >= 65 && event.charCode <= 90 ||
        event.charCode >= 97 && event.charCode <= 122 ||
        event.charCode === polish.charCodeAt(0) ||
        event.charCode === polish.charCodeAt(1) ||
        event.charCode === polish.charCodeAt(2) ||
        event.charCode === polish.charCodeAt(3) ||
        event.charCode === polish.charCodeAt(4) ||
        event.charCode === polish.charCodeAt(5) ||
        event.charCode === polish.charCodeAt(6) ||
        event.charCode === polish.charCodeAt(7) ||
        event.charCode === polish.charCodeAt(8) ||
        event.charCode === polish.charCodeAt(9) ||
        event.charCode === polish.charCodeAt(10) ||
        event.charCode === polish.charCodeAt(11) ||
        event.charCode === polish.charCodeAt(12) ||
        event.charCode === polish.charCodeAt(13) ||
        event.charCode === polish.charCodeAt(14) ||
        event.charCode === polish.charCodeAt(15) ||
        event.charCode === polish.charCodeAt(16) ||
        event.charCode === polish.charCodeAt(17) ||
        event.charCode === polish.charCodeAt(18) ||
        event.charCode === 32;
};