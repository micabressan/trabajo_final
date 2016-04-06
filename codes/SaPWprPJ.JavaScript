        $('.delete').on('click', function() {
            console.log('aaaaaa');
            var id = $(this).data('id');
            $.ajax(
                    {
                        url: '{{ url('authors/delete') }}' + '/' + id,
                        type: "DELETE",
                        data: {
                            "_method": 'DELETE',
                        },
                        success: function() {
                            console.log('bbbbbb');
                        }
                    })
        });