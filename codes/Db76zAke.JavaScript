conn = new Mongo();
db = conn.getDB("senado");
// O dado de 'VALOR_REEMBOLSADO' é string, então para a soma 
// funcionar, precisa converter para Inteiro
db.senado2017.find().forEach(
        function (x) {
            x.VALOR_REEMBOLSADO = parseFloat(x.VALOR_REEMBOLSADO);
            db.senado2017.save(x)            
        }
);

Converte datas para formato padrao do Mongo
db.senado2017.find().forEach(function(element){

    var parts = element.DATA.split("/");
    element.DATA = new Date(parts[2], parts[1], parts[0]);
    db.senado2017.save(element);

});

// Agrega os meses e calcula a media de reembolsos
result = db.senado2017.aggregate(
    [
        {
            $group: {
                _id: {
                    month: {$month: "$DATA"},
                    year: {$year: "$DATA"} 
                    },
                count: {$sum: 1},
                total: {$sum: "$VALOR_REEMBOLSADO"},
            }
        },
        {
            $project:{
                media: {$divide:["$total", "$count"]}
            }
        },
        {
            $out: "senado_medias"
        }
    ]
)

// Agrega Senadores e Seus gastos mensais e exporta uma coleção:
senado_gastos = db.senado2017.aggregate(
    [
        {
           $project:{
               _id: {
                    month: {$month: "$DATA"},
                    year: {$year: "$DATA"},
                },
                name: "$SENADOR",
                total: {$sum: "$VALOR_REEMBOLSADO"}
            }
        },
        {
            $lookup: {
                from: "senado_medias",
                localField: "_id",
                foreignField: "_id",
                as: "middle_result"
            }
        },
        { $unwind: "$middle_result"},
        {
            $out: "senador1"
        }
//         {
//             $project:{
//                 _id: "$SENADOR",
//                 acima_media: { $gt: ["$total", "$media"]}
//             }
//         }
    ]
)


while( result.hasNext() ) {
    printjson(result.next());
}