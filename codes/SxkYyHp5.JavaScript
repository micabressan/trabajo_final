function Cart() {
    this.token = $('meta[name="csrf-token"]').attr('content');
    this.messages = '';

    this.init = function () {
        $('.my-cart').css({
            'overflow-y': 'auto',
            'height': $(window).height()
        });
    };

    this.add = function (id, count) {
        $.post('cart/add', {
            _id: id,
            _count: count,
            _token: this.token
        }, function (data) {
            console.log(data);
            cart.buttons(data);
            cart.html(data);
            $.notify(data.notify.msg, data.notify.status);
        });
    };

    this.buttons = function (result) {
        //console.log(result.messages.validate);
        if (result.messages.validate != undefined) {
            alert(result.messages.validate);
        }

        $('.cart-header').text(result.messages.cart_status_mes);
        $('.cart-sum').text('Sum: ' + result.sum);
        $('.cart-count').text('Count: ' + result.count);

        if (result.messages.cart_clear == true) {
            $('.cart-clear').hide();
        } else if (result.messages.cart_clear == false) {
            $('.cart-clear').show();
        } else {
            console.error('App error');
        }
    };

    this.html = function (data) {
        var html = '';

        if (typeof data == 'object') {
            var cart = data.cart;
            $.each(cart, function (key, value) {
                html += '<div class="col-md-12">';
                html += '<div class="element-product thumbnail">                                \
        <img src="' + value.preview_img + '" alt="' + value.title + '">                     \
                                                                                            \
        <div class="caption">                                                               \
            <h3>' + value.title + '</h3>                                                    \
                                                                                            \
            <p>' + value.description + '</p>                                                \
                                                                                            \
            <p>                                                                             \
                <button class="ajax-minus btn btn-primary btn-sm">-</button>                     \
                <input type="text" value="' + value.count + '" size="5"/>                   \
                <button class="ajax-plus btn btn-primary btn-sm">+</button>                      \
                <button class="cart-delete-item" data-cart="' + value.id + '">Delete</button>     \
            </p>                                                                            \
            <p>                                                                             \
                <a href="/detail/' + value.id + '/" class="btn btn-default"                 \
                    role="button">Detail</a>                                                \
            </p>                                                                            \
        </div>                                                                              \
        </div>';

                html += '</div>';
            });
        }

        $('.my-cart').html(html);
    };

    this.loadData = function () {
        $.post('cart/get', {
            _token: this.token
        }, function (result) {
            //console.log(result);
            cart.buttons(result);
            cart.html(result);
        });
    };

    this.clear = function () {
        $.post('cart/clear', {
            _token: this.token
        }, function (result) {
            cart.buttons(result);
            $('.my-cart > .col-md-12').remove();
            $.notify(result.notify.msg, result.notify.status);
        });
    };

    this.deleteItem = function (id) {
        $.post('cart/delete-item/' + id + '/', {
            _token: this.token
        }, function (result) {
            console.log(result);
            cart.buttons(result);
            $.notify(result.notify.msg, result.notify.status);
        });
    };
}

var cart = new Cart();

$(document).ready(function () {

    cart.init();
    cart.html(cart.loadData());

    $('.my-cart').on('click', '.cart-delete-item', function () {
        $(this).parents('.col-md-12').remove();
        cart.deleteItem($(this).attr('data-cart'));
    });

    $('.cart-clear').click(function () {
        $(this).hide();
        cart.clear();
    });

    $('.cart-buy').click(function () {
        if ($('.cart-clear').is(":visible")) {
            console.log($(this).is(":visible"));
        }
        var id = $(this).attr('data-cart');
        var count = $(this).parents('div.caption').find('p > input').val();
        cart.add(id, count);
    });
});