var root = "http://backpack.oneupthree.com";
var froot = "http://020psv.i.frys.com:8080";

var name = "";
var data = [];
var items = {};
var active = "";

// cause ie sucks
var console = window.console || { log: function() {} };

function info(text) {
  console.log(text);
  jQuery("div#info").html(text);
}

function initSetup() {
  jQuery("html").html("<head></head><body></body>");

  jQuery("head").append("<meta charset='utf-8'></meta>");
  jQuery("head").append("<meta contents='ie=edge, chrome=1' http-equiv='x-ua-compatible'></meta>");
  jQuery("head").append("<title>Hostile Takover</title>");

  jQuery("head").append("<link rel='stylesheet' href='" + root + "/styles/remote.css'>");

  jQuery("body").append("<div id='info'></div>");
  jQuery("body").append("<div id='left'></div>");
  jQuery("body").append("<div id='right'></div>");

  cUpdate();
  dUpdate();
}

function dUpdate() {
  jQuery.ajax({
    type: "POST",
    cache: false,
    url: root + "/jsonp",
    dataType: "jsonp",
    crossDomain: true
  })
  .fail(function() {
    // run again!
    info("failed to fetch data");
    update();
  })
  .done(function(r) {
    data = r;

    info("updated");

    if (name != "") {
      items = {};

      jQuery.each(r, function(i, o) {
        if (o.name == name) {
          items = o.items;
        }
      });
    }

    render();
  });
}

// just keep on updating...
function cUpdate() {

  jQuery("div#update").click(function() {
    info("updating");
    dUpdate();
  });

  jQuery("div#reset").click(function() {
    info("resetting");
    name = "";
    data = [];
    items = {};
    active = "";
    initSetup();
  });

  jQuery("li.list").click(function() {
    var n = jQuery(this).html();
    info("setting list to '" + n + "'.");
    name = n;
    dUpdate();
  });

  jQuery("li.item").click(function() {
    var n = jQuery(this).html().split(" X ")[0];
    info("active item set to '" + n + "'.");
    active = n;
    render();
  });

  jQuery("div#deleteList").click(function() {
    deleteList();
  });

  jQuery("div#delete").click(function() {
    delete items[active];
    sendList();
  });

  jQuery("div#getInfo").click(function() {
    getInfo(active);
  });

  jQuery("div#getInfoAll").click(function() {
    getInfoAll();
  });

  jQuery("div#sendPrint").click(function() {
    if (active != "") {
      sendPrint(active, items[active]);
    }
  });

  jQuery("div#sendPrintAll").click(function() {
    sendPrintAll();
  });
}

function sendList() {
  if (name != "") {
    info("attempting sync");
    jQuery.ajax({
      type: "POST",
      cache: false,
      crossDomain: true,
      url: root + "/list/" + name + "/flood",
      data: {list: items}
    })
    .complete(function() {
      info("synced list");
      render();
    })
    .fail(function() {
      info("failed sync");
    });
  }
}

function getInfo(q) {
  console.log("RUNNING !!! for " + q);
  if (/[0-9]{8}/.test(q)) {
    console.log("a" + q.substr(0, 3));
    console.log("b" + q.substr(3, 3));
    console.log("c" + q.substr(7, 7));
    var s = q.substr(0,3) + "00000" + q.substr(3,3) + q.substr(7,7);
  } else {
    var s = q;
  };
  jQuery.ajax({
    type: "GET",
    cache: false,
    data: {
      prodid: s,
      frmScanSubmit: "OK"
    },
    url: froot + "/handheld/ProdInfo",
    dataType: "html"
  })
  .fail(function() {
    info("failed to get info on " + q);
  })
  .complete(function(d) {
    // parsing hell
    var h = jQuery(d.responseText);
    var t = /[0-9]{7}/;
    var p = jQuery(h).find("b:contains('PLU#')").filter(function() {
      var b = jQuery(this).parent().html();
      return t.test(b);
    }).parent();
    jQuery(p).find("b").remove();
    var f = jQuery(p).html();

    if (typeof f != "undefined") {
      console.log(f);
      var f = f.substr(0, 7);
      // set q to new data
      var l = items[q];
      delete items[q];
      items[f] = l;
      active = f;
      sendList();
      render();
    }
  });
}

function getInfoAll() {
  if (items != {}) {
    jQuery.each(items, function(p, a) {
      active = p;
      getInfo(p);
    });
  }
}

function deleteList() {
  if (name != "") {
    info("attempting delete");
    jQuery.ajax({
      type: "POST",
      cache: false,
      crossDomain: true,
      url: root + "/list/" + name + "/delete",
      data: {name: name}
    })
    .complete(function() {
      info("deleted list");
      name = "";
      items = {};
      active = "";
      dUpdate();
      render();
    });
  }
};

function sendList() {
  if (name != "") {
    info("attempting sync");
    jQuery.ajax({
      type: "POST",
      cache: false,
      crossDomain: true,
      url: root + "/list/" + name + "/flood",
      data: {list: items}
    })
    .complete(function() {
      info("synced list");
      render();
    })
    .fail(function() {
      info("failed sync");
    });
  }
}

function sendPrint(q, a) {
  if (!a) a = 1;
  if (! /^[0-9]{7}$/.test(q)) return info(q + " is not a plu");
  if (q != "") {
    info("attempting print");
    var nq = q.substr(0, q.length - 1);
    jQuery.ajax({
      type: "POST",
      cache: false,
      url: froot + "/handheld/labelprint",
      data: {
        lp_printer: "020_wprn_03_po",
        lp_item_quantity: a,
        lp_label_type: "2",
        lp_item_id: nq,
        upc_barcode: "",
        frmLabelSubmit: "Print Label"
      }
    })
    .complete(function() {
      info(nq + " sent to printer.");
      render();
    })
    .fail(function() {
      info("failed to print " + nq);
    });
  }
}

function sendPrintAll() {
  if (items != {}) {
    jQuery.each(items, function(p, a) {
      sendPrint(p, a);
    });
  }
}

function render() {
  // left side
  jQuery("div#left").html("<div class='row' id='reset'>Reset</div><div class='row' id='update'>Update</div><ul></ul>");
  if (name == "") {
    jQuery.each(data, function(i, l) {
      jQuery("div#left ul").append("<li class='list'>" + l.name + "</li>");
    });
  } else {
    jQuery.each(items, function(u, q) {
      var e = jQuery("<li>")

      jQuery(e).addClass("item");
      if (u == active) {
        jQuery(e).addClass("active");
      }

      if (q != 1) {
        jQuery(e).html(u + " X " + q);
      } else {
        jQuery(e).html(u);
      }

      jQuery("div#left ul").append(e);

    });
  }

  // right side
  jQuery("div#right").html("");
  if (name != "") {
    jQuery("div#right").append("<div class='row' id='deleteList'>Delete list</div>");
    jQuery("div#right").append("<div class='row' id='getInfoAll'>Get all Info</div>");
    jQuery("div#right").append("<div class='row' id='sendPrintAll'>Print All</div>");
  }
  jQuery("div#right").append("<ul></ul>");
  if (active != "") {
    jQuery("div#right ul").append("<li>I: " + active + "</li>");
    if (typeof items[active] != 'undefined') {
      jQuery("div#right ul").append("<li>A: " + items[active] + "</li>");
    }
    jQuery("div#right").append("<div class='row' id='delete'>Delete Item</div>");
    jQuery("div#right").append("<div class='row' id='getInfo'>Get Info</div>");
    jQuery("div#right").append("<div class='row' id='sendPrint'>Print</div>");
  };

  cUpdate();
}

jQuery(document).ready(function() {
  initSetup();
  info("takeover complete");
});