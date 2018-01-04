    var initClientList = {};
    
    for (var client in clients) {
      redisClient.hgetall(clients[client], function (err, clientData) {
        initClientList[clientData["clientId"]] = [clientData["x"], clientData["y"]];
      });
    }
    
    console.log(initClientList);