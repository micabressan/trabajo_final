r.tableList().contains(config.rethinkdb.table).do(function(containsTable) {
      console.log(containsTable);
      return r.branch(
        containsTable,
        {created: 0},
        r.tableCreate(config.rethinkdb.table)
      );
    }).run(connection, function(err) {       
      callback(err, connection);
    });