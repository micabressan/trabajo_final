package com.example.maxim.survivalapp;

import android.app.Activity;
import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import java.util.ArrayList;

import model.RSSItem;
import responder.RSSResponder;

/**
 * Created by Maxim on 8/08/15.
 */
public class InfoFragment extends Fragment {
    private static final String ARG_SECTION_NUMBER = "section_number";
    private InfoItemAdapter mAdapter;

    /**
     * Returns a new instance of this fragment for the given section
     * number.
     */
    public static InfoFragment newInstance(int sectionNumber) {
        InfoFragment fragment = new InfoFragment();
        Bundle args = new Bundle();
        args.putInt(ARG_SECTION_NUMBER, sectionNumber);
        fragment.setArguments(args);
        return fragment;
    }

    public InfoFragment() {
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.getRSSFeed(this.getActivity());
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.info_frag, container, false);
        return rootView;
    }

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
        ((Main2Activity) activity).onSectionAttached(
                getArguments().getInt(ARG_SECTION_NUMBER));
    }

    //GetRSSFeed method
    private void getRSSFeed(Activity a) {
        ListView mListView = (ListView) a.findViewById(R.id.RSSFeedList);
        ArrayList<RSSItem> items = new ArrayList<RSSItem>();
        try {
            RSSResponder responder = new RSSResponder();
            responder.fetchXML();
            items = responder.getItems();
        } catch(Exception e) {
            e.printStackTrace();
        }

        this.mAdapter = new InfoItemAdapter(a,items);
        mListView.setAdapter(mAdapter);

    }
}