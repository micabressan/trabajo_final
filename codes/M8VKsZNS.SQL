select    
    patrick_cubecart_order_inv.cart_order_id,
Productcode,
patrick_cubecart_order_inv.name,
   	    Opret_udg,
            patrick_cubecart_customer.Customer_id
            Firstname,
            Lastname,
            patrick_cubecart_customer.Gadenavn,
            patrick_cubecart_customer.Husnr,
            patrick_cubecart_customer.Hoveddor,
            patrick_cubecart_customer.Etage,
            patrick_cubecart_customer.Sidedor,
            patrick_cubecart_customer.Town,
            patrick_cubecart_customer.Phone,
            patrick_cubecart_customer.Mobile,
            patrick_cubecart_customer.Email,
            patrick_cubecart_customer.info_1,
            patrick_cubecart_customer.info_2 
           
            FROM patrick_cubecart_order_inv
        

			INNER JOIN patrick_cubecart_order_sum ON 
            patrick_cubecart_order_inv.cart_order_id = patrick_cubecart_order_sum.cart_order_id

			INNER JOIN patrick_cubecart_customer ON
            patrick_cubecart_order_sum.customer_id = patrick_cubecart_customer.customer_id 
            
            WHERE (patrick_cubecart_customer.user_group_id = '66560' or patrick_cubecart_customer.user_group_id = '298');