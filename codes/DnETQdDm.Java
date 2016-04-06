package pt.itgroup.hsguide.core.deckBrowser;

import pt.itgroup.hsguide.core.interfaces.*;
import org.jsoup.*;
import pt.itgroup.hsguide.core.database.*;
import pt.itgroup.hsguide.core.helpers.*;
import java.io.*;
import org.jsoup.select.*;
import pt.itgroup.hsguide.core.models.*;
import pt.itgroup.hsguide.core.enums.*;
import java.util.*;
import org.jsoup.nodes.*;

public class HPDeckSource implements DeckBrowserSource
{
    private static String BASE_URL;
    private static String DECKS_URL;
    
    static {
        HPDeckSource.BASE_URL = "http://www.hearthpwn.com";
        HPDeckSource.DECKS_URL = "/decks?";
    }
    
    private String constructDeckNameFilter(String string) {
        final String[] split = string.trim().split(" ");
        string = "";
        for (int length = split.length, i = 0; i < length; ++i) {
            final String s = split[i];
            String s2 = "+";
            final StringBuilder append = new StringBuilder().append(string);
            if (string.isEmpty()) {
                s2 = "";
            }
            string = append.append(s2).append(s).toString();
        }
        return string;
    }
    
    @Override
    public HSDeck getDeckDetail(final HSDeck hsDeck, final float n) {
        try {
            final Document value = Jsoup.connect(HPDeckSource.BASE_URL + hsDeck.getUrl()).get();
            final Elements select = value.select("section.class-listing table.listing td.col-name");
            final HashMap<String, String> classHsItemMap = new HashMap<String, String>();
            final ArrayList<String> list = new ArrayList<String>();
            for (int i = 0; i < select.size(); ++i) {
                final String text = select.get(i).select("a").get(0).text();
                classHsItemMap.put(text, select.get(i).text().trim().substring(select.get(i).text().trim().length() - 1));
                list.add(text);
            }
            hsDeck.setClassHsItemMap(classHsItemMap);
            hsDeck.setClassHsItemList(DataBaseManager.getInstance().getAllCardsByNames(list));
            final Elements select2 = value.select("section.neutral-listing table.listing td.col-name");
            final HashMap<String, String> neutralHsItemMap = new HashMap<String, String>();
            final ArrayList<String> list2 = new ArrayList<String>();
            for (int j = 0; j < select2.size(); ++j) {
                final String text2 = select2.get(j).select("a").get(0).text();
                neutralHsItemMap.put(text2, select2.get(j).text().trim().substring(select2.get(j).text().trim().length() - 1));
                list2.add(text2);
            }
            hsDeck.setNeutralHsItemMap(neutralHsItemMap);
            hsDeck.setNeutralHsItemList(DataBaseManager.getInstance().getAllCardsByNames(list2));
            hsDeck.setDescription(HtmlHelper.parseDescription(value.select("div.deck-description").html(), n, false));
            return hsDeck;
        }
        catch (IOException ex) {
            ex.printStackTrace();
            return hsDeck;
        }
    }
    
    @Override
    public List<HSDeck> getDeckListFiltered(final DeckBrowserRequest deckBrowserRequest) {
        final List<HSPlayerClass> classFilter = deckBrowserRequest.getClassFilter();
        final ArrayList<HSDeck> list = new ArrayList<HSDeck>();
        try {
            String s2;
            final String s = s2 = HPDeckSource.BASE_URL + HPDeckSource.DECKS_URL;
            if (deckBrowserRequest.getSortingKey() != null) {
                s2 = s;
                if (!deckBrowserRequest.getSortingKey().trim().isEmpty()) {
                    s2 = s + "&" + HP_REQUEST_PARAMS.FILTER_OPTION.requestParam + deckBrowserRequest.getSortingKey();
                }
            }
            String string = s2;
            if (deckBrowserRequest.getDeckNameFilter() != null) {
                string = s2;
                if (!deckBrowserRequest.getDeckNameFilter().trim().isEmpty()) {
                    string = s2 + "&" + HP_REQUEST_PARAMS.FILTER_SEARCH.requestParam + this.constructDeckNameFilter(deckBrowserRequest.getDeckNameFilter());
                }
            }
            String string2 = string;
            if (classFilter != null) {
                string2 = string;
                if (classFilter.size() > 0) {
                    string2 = string;
                    if (!classFilter.contains(HSPlayerClass.ALL)) {
                        int n = 0;
                        for (final HSPlayerClass hsPlayerClass : classFilter) {
                            if (hsPlayerClass.isSingleClass()) {
                                n += hsPlayerClass.getHsFilterValue();
                            }
                        }
                        string2 = string + "&" + HP_REQUEST_PARAMS.FILTER_CLASS.requestParam + n;
                    }
                }
            }
            String string3 = string2;
            if (deckBrowserRequest.getOrderBy() != null) {
                string3 = string2;
                if (!deckBrowserRequest.getOrderBy().isEmpty()) {
                    String s3;
                    if (deckBrowserRequest.isAsc()) {
                        s3 = "";
                    }
                    else {
                        s3 = "-";
                    }
                    string3 = string2 + "&" + HP_REQUEST_PARAMS.FILTER_SORT.requestParam + s3 + deckBrowserRequest.getOrderBy();
                }
            }
            final Elements select = Jsoup.connect(string3).referrer(HPDeckSource.BASE_URL + "/").followRedirects(true).ignoreHttpErrors(true).get().select("table#decks tr");
            for (int i = 1; i < select.size() - 1; ++i) {
                final Element value = select.get(i);
                final Elements select2 = value.select("td.col-name span.tip a");
                final Elements select3 = value.select("td.col-deck-type");
                final Elements select4 = value.select("td.col-class");
                final Elements select5 = value.select("td.col-ratings div.rating-sum");
                final Elements select6 = value.select("td.col-dust-cost");
                final Elements select7 = value.select("td.col-updated abbr");
                final HSDeck hsDeck = new HSDeck();
                hsDeck.setName(select2.get(0).text());
                hsDeck.setUrl(select2.get(0).attr("href"));
                hsDeck.setType(select3.get(0).text());
                hsDeck.setPlayerClass(select4.get(0).text());
                hsDeck.setRating(select5.get(0).text());
                hsDeck.setCost(select6.get(0).text());
                if (select7.get(0).hasAttr("data-epoch")) {
                    hsDeck.setLastUpdate(select7.get(0).attributes().get("data-epoch"));
                }
                hsDeck.setLastUpdateAsString(select7.get(0).text());
                list.add(hsDeck);
            }
        }
        catch (IOException ex) {
            ex.printStackTrace();
        }
        return list;
    }
    
    public enum HP_FILTER_OPTIONS
    {
        HOT("1"), 
        NEW("2"), 
        TOP_ALL_TIME("5"), 
        TOP_MONTH("4"), 
        TOP_WEEK("3");
        
        public String sortingKey;
        
        private HP_FILTER_OPTIONS(final String sortingKey) {
            this.sortingKey = sortingKey;
        }
    }
    
    public enum HP_ORDER_OPTIONS
    {
        CLASS("class"), 
        DUSTCOST("dustcost"), 
        RATING("rating"), 
        VIEWCOUNT("viewcount");
        
        public String orderBy;
        
        private HP_ORDER_OPTIONS(final String orderBy) {
            this.orderBy = orderBy;
        }
    }
    
    public enum HP_REQUEST_PARAMS
    {
        FILTER_CLASS("filter-class="), 
        FILTER_OPTION("filter-deck-tag="), 
        FILTER_SEARCH("filter-search="), 
        FILTER_SORT("sort=");
        
        public String requestParam;
        
        private HP_REQUEST_PARAMS(final String requestParam) {
            this.requestParam = requestParam;
        }
    }
}