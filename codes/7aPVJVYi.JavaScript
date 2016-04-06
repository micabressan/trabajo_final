// Copyright (C) 2010-2015  Matthias Hoefel & Robert Walter
//
// This program is free software; you can redistribute it and/or modify 
// it under the terms of the GNU General Public License as published by 
// the Free Software Foundation; either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
// See the GNU General Public License for more details.
// ======================================================================

// ==UserScript==
// @name            Gc2OcLink
// @description     Gc2OcLink provides a link to a opencaching.de listing from a geocaching.com listing. The user has to install a greasemonkey script to add the link to the GC listing page.
// @copyright       2010-2015 Matthias Hoefel & Robert Walter
// @license         GPLv3 , http://www.gnu.org/copyleft/gpl.html
// @version         0.3.1
// @oujs:author     Metrax
// @homepageURL     https://openuserjs.org/scripts/Metrax/Gc2OcLink
// @include         http://www.geocaching.com/seek/cache_details*
// @include         http*://www.geocaching.com/my/*
// @include         http*://www.geocaching.com/bookmarks/view*
// @include         http*://www.geocaching.com/seek/nearest*
// @include         http*://www.geocaching.com/geocache/*
// @include         http*://www.geocaching.com/play/search/*
// @grant           GM_xmlhttpRequest
// @grant           GM_addStyle
// @updateURL       https://openuserjs.org/meta/Metrax/Gc2OcLink.meta.js
// @downloadURL     https://openuserjs.org/install/Metrax/Gc2OcLink.user.js
// ==/UserScript==

var VERSION = "0.3.1";
var DEBUG = true;

var LABEL_HEADER = "Also listed at";

if (document.URL.search("www\.geocaching\.com\/my\/") >= 0) {
    modifyMyProfile();
} else if (document.URL.search("\/geocache\/") >= 0) {
    modifyCacheDetails();
} else if (document.URL.search("www\.geocaching\.com\/bookmarks\/view\.aspx") >= 0) {
    modifyBookmarkList();
} else if (document.URL.search("www\.geocaching\.com\/seek\/nearest\.aspx") >= 0) {
    modifySearchResultList();
} else if (document.URL.search("www\.geocaching\.com\/play\/search\/") >= 0) {
    modifyNewSearchResultList();
}

function modifyMyProfile() {
    debug("modify my profile");

    modifyProfileSideBar();
    // addListColumn();
}

/**
 * Modifies the right hand side bar of the profile. Currently adds a simple
 * version info.
 */
function modifyProfileSideBar() {
    var gc2ocDiv = document.createElement("div");
    gc2ocDiv.setAttribute("class", "YourProfileWidget");
    gc2ocDiv.setAttribute("id", "gc2ocLinkDiv");

    var gc2ocHeader = document.createElement("h3");
    gc2ocHeader.setAttribute("class", "WidgetHeader");
    gc2ocHeader.innerHTML = "gc2oc Link";

    gc2ocDiv.appendChild(gc2ocHeader);

    var gc2ocBody = document.createElement("div");
    gc2ocBody.setAttribute("class", "WidgetBody");
    gc2ocBody.setAttribute("id", "gc2ocLinkDivBody");

    var spanElement = document.createElement("span");
    spanElement.appendChild(document.createTextNode("Version: " + VERSION));

    gc2ocBody.appendChild(spanElement);
    gc2ocDiv.appendChild(gc2ocBody);

    // The favorite widget has a id, so we use it to get the parent element.
    // Any other widget with an id would do the job as well.
    var favoritesWidget = document.getElementById("ctl00_ContentBody_pnlFavoritesWidget");
    favoritesWidget.parentNode.appendChild(gc2ocDiv);
}

function addListColumn() {

    // The favorite widget has a id, so we use it to get the parent element.
    // Any other widget with an id would do the job as well.
    var favoritesWidget = document.getElementById("ctl00_ContentBody_pnlFavoritesWidget");

    debug("entrypoint found");

    // Search the div that contains the table by walking backwards through the
    // list of divs by using previouseSibling
    var tableEnclosingDiv = favoritesWidget.parentNode.previousSibling;

    while (!tableEnclosingDiv.attributes || tableEnclosingDiv.getAttribute("class") != "yui-u first") {
        tableEnclosingDiv = tableEnclosingDiv.previousSibling;
    }
    if (!tableEnclosingDiv) {
        debug("table enclosing div not found");
        return;
    }

    debug("table enclosing div found");

    debug("tableEnclosingDiv = " + tableEnclosingDiv);
    debug("tableEnclosingDiv = " + tableEnclosingDiv.childNodes);

    var tableElement;
    var childNodes = tableEnclosingDiv.childNodes;
    var nodeName = "TABLE";
    for ( var i = 0; i < childNodes.length; i++) {
        debug("childNodes[i].nodeName = " + childNodes[i].nodeName);
        if (childNodes[i].nodeName == nodeName) {
            tableElement = childNodes[i];
            break;
        }

    }
    // search for the table
    debug("table = " + tableElement);
    while (tableElement.nodeName != nodeName) {
        tableElement = tableElement.nextSibling;
        debug("table = " + tableElement);
    }

    if (tableElement == null) {
        debug("table not found");
        return;
    }

    debug("table found");
    var tableRows = tableElement.getElementsByTagName("TR");
    for ( var i = 0; i < tableRows.length; i++) {
        var cell = document.createElement("td");
        cell.appendChild(document.createTextNode("Hallo!"));
        tableRows[i].appendChild(cell);
    }
    debug("done");

}

/**
 * Modifies the cache details page. Adds a box with the oc link.
 */
function modifyCacheDetails() {
    debug("modify cache details");

    var go2olpDiv = document.createElement("div");
    go2olpDiv.setAttribute("class", "CacheDetailNavigationWidget Spacing");

    var go2olpHeader = document.createElement("h3");
    go2olpHeader.setAttribute("class", "WidgetHeader");
    go2olpHeader.setAttribute("style", "margin-top:1em; font-size:100%");
    go2olpHeader.innerHTML = "<strong>" + LABEL_HEADER + "</strong>";

    go2olpDiv.appendChild(go2olpHeader);

    var go2olpBody = document.createElement("div");
    go2olpBody.setAttribute("class", "WidgetBody");
    go2olpBody.setAttribute("id", "go2olpBody");

    //var cacheCodeWidget = document.getElementById("ctl00_ContentBody_uxWaypointName");
    var cacheCodeWidget = document.getElementById("ctl00_ContentBody_CoordInfoLinkControl1_uxCoordInfoCode");
    
    var gcWaypoint = getGCCOMWayPointFromElement(cacheCodeWidget);
    
    var spanElement = createOCLink(gcWaypoint, "opencaching.de");

    go2olpBody.appendChild(spanElement);
    go2olpDiv.appendChild(go2olpBody);

    var lnk = document.getElementById("ctl00_ContentBody_lnkTravelBugs");
    lnk.parentNode.insertBefore(go2olpDiv, lnk);
}


function modifyBookmarkList() {
    debug("modify bookmark list");

    // Get the nearest element with an id
    var abuseReportDiv = document.getElementById("ctl00_ContentBody_ListInfo_uxAbuseReport");
    
    debug("entrypoint found: " + abuseReportDiv);

    var tableTag = findFirstChildNodeByClass(abuseReportDiv.parentNode.childNodes, "Table NoBottomSpacing");
    if (!tableTag) {
        debug("table tag not found");
        return;
    }
    debug("table tag: " + tableTag);

    var tableHead = findFirstChildNodeByName(tableTag.childNodes, "THEAD");
    var headerRow = findFirstChildNodeByName(tableHead.childNodes, "TR");
    var headerCell = document.createElement("th");
    headerCell.appendChild(document.createTextNode(LABEL_HEADER));
    headerRow.appendChild(headerCell);

    var tableRows = document.getElementsByTagName('TR');
    var count=0;
    for(var i=0;i<tableRows.length;i++) {
      if(tableRows[i].id.match('^ctl00_ContentBody_ListInfo_BookmarkWpts_ctl.._dataRow$')) {
        debug(tableRows[i].innerHTML);
        addLinkColumn2BookmarkListRow(tableRows[i]);
      }  
    } 
}

function addLinkColumn2BookmarkListRow(tableRow) {
    
    if (tableRow.attributes && tableRow.getAttribute("id")) {
        // The row with a id is the first row of the two lined entry.
        // dangerous! position might be subject to change!
        var wayPointLink = tableRow.getElementsByTagName("TD")[3];
        
        var gcWayPoint = getGCCOMWayPointFromElement(wayPointLink);
        
        if(gcWayPoint != '') {
            debug("gcWayPoint = " + gcWayPoint);
            var cell = document.createElement("td");
            if (gcWayPoint.match(/(GC[A-Z0-9]+)/)) {
                cell.appendChild(createOCLink(gcWayPoint, "oc.de"));
            } else {
                cell.appendChild(document.createTextNode("Failed to get GC-Waypoint. Update to a new version of gc2oc link."));
            }
            
            var rowSpan = document.createAttribute("rowspan");
            
            rowSpan.nodeValue="2";
            cell.setAttributeNode(rowSpan);
            tableRow.appendChild(cell);
        }
    }
    debug("test");
}

function modifySearchResultList() {
    debug("modify search result list");

    var resultTable = document.getElementById("ctl00_ContentBody_ResultsPanel");
    var tableBodies = resultTable.getElementsByTagName("TBODY");

    // yes, we have two of them. And we need the second one.
    var tableRows = tableBodies[1].getElementsByTagName("TR");
    
    for ( var i = 0; i < tableRows.length; i++) {
        var rowClass = tableRows[i].getAttribute("class");
        var searchListHeaderRowClass = "BorderTop";
        var ownSearchListRowClass = "TertiaryRow Data BorderTop";
        var friendSearchListRowClass = "SolidRow Data BorderTop";
        var friendSearchListAlternatingRowClass = "AlternatingRow Data BorderTop";
        if (rowClass == ownSearchListRowClass || 
                rowClass == friendSearchListRowClass || 
                rowClass == friendSearchListAlternatingRowClass || 
                rowClass == searchListHeaderRowClass ) {
            
            var cell;
            if (rowClass == ownSearchListRowClass || 
                    rowClass == friendSearchListRowClass || 
                    rowClass == friendSearchListAlternatingRowClass) {
                cell = document.createElement("td");
                
                // dangerous! position might be subject to change!
                var wayPointCell = tableRows[i].getElementsByTagName("TD")[5];
                var gcWayPoint = getGCCOMWayPointFromElement(wayPointCell);
                
                debug("gcWayPoint = " + gcWayPoint);

                // cell.appendChild(document.createTextNode(gcWayPoint));
                cell.appendChild(createOCLink(gcWayPoint));
                
                
            } else {
                cell = document.createElement("th");
                cell.appendChild(document.createTextNode(LABEL_HEADER));
                var scope = document.createAttribute("scope");
                scope.nodeValue="col";
                cell.setAttributeNode(scope);
            }
            tableRows[i].appendChild(cell);
        }
    }
}

function modifyNewSearchResultList() {
        debug("modify new search result list");
        var resultTable = document.getElementById("searchResultsTable");
        
        // Build Table Header
        var tableHeads = resultTable.getElementsByTagName("THEAD");
        var tableHeadRows = tableHeads[0].getElementsByTagName("TR");
		var tableColGroup = resultTable.getElementsByTagName("COLGROUP");
		//tableColGroup.innerHTML = tableColGroup.innerHTML + '<col></col>'; 
		ColCell = document.createElement("col");
		tableColGroup[0].appendChild(ColCell);
		
        HeaderCell = document.createElement("th");
        HeaderCell.setAttribute("class", "sort-column");
        HeaderCell.setAttribute("scope", "col");
        HeaderCell.style.width = "10%";
        HeaderCellText = document.createElement("a");
        HeaderCellText.setAttribute("class", "outbound-link");
        HeaderCellText.appendChild(document.createTextNode("OC"));
        HeaderCell.appendChild(HeaderCellText);
        tableHeadRows[0].appendChild(HeaderCell);
        
        // Manipulate Cache Rows
        var tableBodies = resultTable.getElementsByTagName("TBODY");
        var tableRows = tableBodies[0].getElementsByTagName("TR");     
        for ( var i = 0; i < tableRows.length; i++) {
            tableCols = tableRows[i].getElementsByTagName("TD");
            tableColLinks = tableCols[0].getElementsByTagName("A");
            tableColSpans = tableColLinks[0].getElementsByTagName("SPAN");
            if(tableColSpans[1].innerHTML == "Premium" || tableColSpans[1].innerHTML == "Disabled") {
                CacheText = tableColSpans[3];
            } else {
                CacheText = tableColSpans[2];
            }
            CacheCode = getGCCOMWayPointFromElement(CacheText);
            OCCell = document.createElement("td");
            OCCell.setAttribute("class","mobile-show pri-1");
            //OCCell.style.width = "10%";
            OCCell.appendChild(createOCLink(CacheCode));
			//OCCell.className = 'pri-1';
            tableRows[i].appendChild(OCCell);
        }

}


function getGCCOMWayPointFromElement(element) {
    var regex = /(GC[A-Z0-9]{1,5})+/;
    var cache = element.textContent.match(regex);
    debug("Geocache: " + cache[0]);
    return cache[0];
}

function getLatLonSpan() {
    var latlon_span = document.getElementById('ctl00_ContentBody_LatLon');

    var regex = /([NS])\s(\d{1,3}).\s(\d{1,2})\.(\d{3})\s([EW])\s(\d{1,3}).\s(\d{1,2})\.(\d{3})/;
    debug("Cache coordinates:", latlon_span.textContent.match(regex));
}

function getLatitude() {
    getLatLonSpan();
    var lat = parseFloat(RegExp.$2) + (parseFloat(RegExp.$3) + (parseFloat(RegExp.$4) / 1000)) / 60;
    if (RegExp.$1 == 'S') {
        lat = -1 * lat;
    }
    lat = Math.round(lat * 100000) / 100000;
    debug("lat=" + lat);
    return lat; 
}

function getLongitude() {
    getLatLonSpan();
    var lon = parseFloat(RegExp.$6) + (parseFloat(RegExp.$7) + (parseFloat(RegExp.$8) / 1000)) / 60;
    if (RegExp.$5 == 'W') {
        lon = -1 * lon;
    }
    lon = Math.round(lon * 100000) / 100000;
    debug("lon=" + lon);
    return lon;
}

/**
 * Parses the value of the found flag from the request response.
 * 
 * @param dom
 *            dom of the response
 * @return the found flag or <code>false</code> if response was empty.
 */
function parseXML_GetFoundFlag(dom) {
    var caches = dom.getElementsByTagName("cache");

    if (caches.length < 1)
        return false;

    var foundFlag = caches[0].getAttribute("found");
    return foundFlag;
}

function parseXML_GetInactiveFlag(dom) {
    var caches = dom.getElementsByTagName("cache");

    if (caches.length < 1)
        return false;

    var inactiveFlag = caches[0].getAttribute("inactive");
    return inactiveFlag;
}

/**
 * Parses the oc waypoint from the request response.
 * 
 * @param dom
 *            dom of the response
 * @return the oc waypoint or <code>false</code> if response was empty.
 */
function parseXML_GetOCwp(dom) {
    var caches = dom.getElementsByTagName("cache");

    if (caches.length < 1)
        return false;

    var wp = caches[0].getAttribute("wpoc");
    return wp;
}

function debug(message) {
    if (DEBUG && console) {
        console.debug(message);
    }
}

function createOCLink(gcWaypoint, linkLabel) {
    var spanElement = document.createElement("span");
    spanElement.setAttribute("id", "go2olp_ocRef");

    if (linkLabel) {
        var ocLinkElement = document.createElement('a');
        ocLinkElement.href = "http://www.opencaching.de";
        ocLinkElement.target = "_blank";
        ocLinkElement.appendChild(document.createTextNode(linkLabel));
        spanElement.appendChild(ocLinkElement);
        spanElement.appendChild(document.createTextNode(": "));
    }

    var urlString = 'http://www.opencaching.de/map2.php?mode=wpsearch&wp=' + gcWaypoint;

    GM_xmlhttpRequest( {
        method : 'GET',
        url : urlString,
        timeout : 1,
        headers : {
            'User-agent' : 'gc2oclink (greasemonkey)' + VERSION,
            'Accept' : 'text/xml'
        },
        onload : function(responseDetails) {
            var parser = new DOMParser();
            debug(responseDetails.responseText);
            var dom = parser.parseFromString(responseDetails.responseText, "text/xml");
            var ocwp = parseXML_GetOCwp(dom);
            if (!ocwp) {
                spanElement.appendChild(document.createTextNode("not listed"));
            } else {
                debug('ocKey: ' + ocwp);

                var linkElement = document.createElement('a');
                linkElement.href = "http://www.opencaching.de/viewcache.php?wp=" + ocwp;
                linkElement.target = "_blank";
                linkElement.appendChild(document.createTextNode(ocwp));
                var inactiveFlag = parseXML_GetInactiveFlag(dom);
                if(inactiveFlag == '1') {
                    linkElement.style.textDecoration = "line-through";
                }
                spanElement.appendChild(linkElement);
                
                var foundFlag = parseXML_GetFoundFlag(dom);
                
                
                if (foundFlag && foundFlag == '1') {
                    spanElement.appendChild(document.createTextNode(" "));
                    var foundIcon = document.createElement('img');
                    foundIcon.src = "http://www.opencaching.de/resource2/ocstyle/images/viewcache/16x16-found.png";
                    foundIcon.title = "Logged on opencaching.de";
                    spanElement.appendChild(foundIcon);
                }
            }
        },
        ontimeout : function (responseDetails) {
            spanElement.appendChild(document.createTextNode("Connection error"));
        },
        onerror : function (responseDetails) {
            spanElement.appendChild(document.createTextNode("Connection error"));
        }
    });
    return spanElement;
}

/**
 * Finds a child node by its name. Simply walks through the child array and
 * compares the node names.
 * 
 * @param childNodes
 *            Array of nodes to search through
 * @param nodeName
 *            Name of the node to search
 * @return node found or <code>null</code>
 */
function findFirstChildNodeByName(childNodes, nodeName) {
    for ( var i = 0; i < childNodes.length; i++) {
        debug("childNodes[i].nodeName = " + childNodes[i].nodeName);
        if (childNodes[i].nodeName == nodeName) {
            return childNodes[i];
        }
    }
    debug("no node found with name " + nodeName);
}

/**
 * Finds a child node by its class attribute value. Simply walks through the
 * child array and compares the content of the class attribute (if available.
 * 
 * @param childNodes
 *            Array of nodes to search through
 * @param className
 *            Name of the node to search
 * @return node found or <code>null</code>
 */
function findFirstChildNodeByClass(childNodes, className) {
    for ( var i = 0; i < childNodes.length; i++) {
        if (!childNodes[i].attributes) {
            debug("node with no attributes");
        } else {
            var nodeClass = childNodes[i].getAttribute("class");
            debug("childNodes[i] class = " + nodeClass);
            if (nodeClass == className) {
                return childNodes[i];
            }
        }
    }
    debug("no node found with class " + className);
}