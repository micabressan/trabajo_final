package com.example.maxim.survivalapp;

import android.app.Activity;
import android.app.Fragment;
import android.app.ProgressDialog;
import android.os.AsyncTask;
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
        new RSSReader().execute();
        super.onCreate(savedInstanceState);
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
    private class RSSReader extends AsyncTask<Void,Void,ArrayList<RSSItem>> {
        private ProgressDialog p;

        @Override
        protected ArrayList<RSSItem> doInBackground(Void... params) {
            RSSResponder responder = new RSSResponder();
            ArrayList<RSSItem> items = new ArrayList<RSSItem>();
            responder.fetchXML();
            items = responder.getItems();
            return items;
        }

        @Override
        protected void onPostExecute(ArrayList<RSSItem> items) {
            mAdapter = new InfoItemAdapter(getActivity(),items);
            ListView mListView = (ListView) getActivity().findViewById(R.id.RSSFeedList);
            mListView.setAdapter(mAdapter);
            p.dismiss();
        }

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            p = ProgressDialog.show(getActivity(), "", getString(R.string.loading));
        }

    }
}