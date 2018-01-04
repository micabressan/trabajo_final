subor: 920-order_delivery_options.2014.mdl

$TPL->variables_push(\%db0_line) unless ($db0_line{'metahash'}{'delivery'}{'free_delivery_service'} && (($basket{'total_price_incl_VAT'} < $tom::setup{'free_shipping_limit'}) || $basket{'free_delivery'}));

znamena ze:

pushnem delivery produkt do TPL IBA KED ten dany delivery je free_delivery_service a zaroven kosik ma mensiu hodnotu ako free_shipping_limit alebo kosik ma nastaveny free_delivery (moja logika)

Zober si delivery (Doprava zdarma)... je to nastavene ako "free_delivery_service", hodnota v kosiku je mensia ako "free_shipping_limit" a kosik ma nastaveny free_delivery... cize vysledok je:

unless(1 && ((0) || 1)), cize unless(1 && 1).. cize true