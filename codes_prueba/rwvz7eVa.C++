function random(t)
{
    if ( requests.length > 0 )
    {
        i = Math.floor(Math.random()*requests.length);
        var item = requests[i];
        if ( t > 0 )
        {
            setTimeout('random('+(t-1)+');', (count-t)*4);
        }else{
            used.push( item );
            requests.splice(i, 1);
            $('.btn-download').show();
            setTimeout(function(){
                $('#random-name').html( item ).css('color', '#FF4040');
            }, 500);............
        }
 
        $('#random-name').html( item );
............
    }else{
        $('#random-name').html( '-' );
    }
}
 
(function() {
 
    $(function() {.......
        // auto start TEST
        $('.btn-download').click(function(){
            $('#random-name').css('color', '#c9aaa2');
............
            random(count);
            $(this).hide();
            return false;
        });
........
........
        /*.css({
            '-webkit-filter': 'grayscale(1)',
            'opacity': '0.5'
        })*/
        $('.elements-gifts > a').click(function(){
            $('.elements-gifts > a').css({
                '-webkit-filter': 'grayscale(1)',
                'opacity': '0.5'
            }).removeClass('active');
            $(this).css({
                '-webkit-filter': '',
                'opacity': '1'
            }).addClass('active');
        });
    });
 
}).call(this);