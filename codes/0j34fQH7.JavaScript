$('#technologia').on('selectmenuselect',function(){
        $( "#jakosc" ).selectmenu({disabled: false});
        $( "#jakosc" ).selectmenu("destroy");
        switch($(this).val()) {
            case 'analogowa' :
            $("select#jakosc option[value='vga_button']").attr('disabled', false );
            $("select#jakosc option[value='mpix1_button']").attr('disabled', false );
            $("select#jakosc option[value='mpix2_button']").attr('disabled', false );
            $("select#jakosc option[value='mpix3_button']").attr('disabled', true );
            $("select#jakosc option[value='mpix5_button']").attr('disabled', true );
            $( '[name="jakosc"]' ).selectmenu({
                width: 200,
                placeholder: 'Wybierz...'
            });
            //$( "#jakosc" ).selectmenu( "refresh" );
            break;

            case 'cyfrowa':
            $("select#jakosc option[value='vga_button']").attr('disabled', true );
            $("select#jakosc option[value='mpix1_button']").attr('disabled', false );
            $("select#jakosc option[value='mpix2_button']").attr('disabled', false );
            $("select#jakosc option[value='mpix3_button']").attr('disabled', false );
            $("select#jakosc option[value='mpix5_button']").attr('disabled', false );
            //$( "#jakosc" ).selectmenu( "refresh" );
            $( '[name="jakosc"]' ).selectmenu({
                width: 200,
                placeholder: 'Wybierz...'
            });
            break;
        }
    });