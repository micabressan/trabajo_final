let sold_off_tickets = _.filter(cart, item => {
                let index = _.findIndex(event.tickets, ticket => {
                    return _.toString(ticket._id) === _.toString(item.ticket._id);
                });
                qtde_available = event.tickets[index].quantityAvailable;
                qtde_in_cart = event.tickets[index].quantityInCart;
                return item.qty > (qtde_available-qtde_in_cart);
            });
            if (sold_off_tickets > 0)
                throw new Error('Selected tickets out of stock' + sold_off_tickets);
            return Q.all(_.map(ids, i => {
                let ticket_purchased = _.find(cart, cart_item => {
                    return cart_item.ticket._id == i;
                })
                return Event.findOneAndUpdate({
                    _id: event,
                    'tickets._id': i
                }, {
                    $inc: {
                        //'tickets.$.quantityAvailable': -ticket_purchased.qty,
                        'tickets.$.quantityInCart': ticket_purchased.qty
                    }
                })
            }))