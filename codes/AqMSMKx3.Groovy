return [
    "query": [
        "bool": [
            "must": [
                [
                    "term": [
                        "shipment.status": ShippingConstants.SHIP_STATUS_SHIPPED.id
                    ]
                ],
                [
                    "term": [
                        "shipment.mode": ShippingConstants.SHIPPING_MODE_ME2.id
                    ]
                ],
                [
                    "range": [
                        "shipment.last_updated": [
                            "from": "now-2d",
                            "to": "now-10m"
                        ]
                    ]
                ]
            ]
        ]
    ]
]