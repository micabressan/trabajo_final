package com.example.maxim.survivalapp;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import java.util.ArrayList;

import model.RSSItem;

/**
 * Created by maxim on 16/08/2015.
 */
public class InfoItemAdapter extends BaseAdapter {
    private ArrayList<RSSItem> mItems;
    private Context mContext;

    public InfoItemAdapter(Context mContext, ArrayList<RSSItem> mItems) {
        this.mItems = mItems;
        this.mContext = mContext;
    }

    @Override
    public int getCount() {
        return this.mItems.size();
    }

    @Override
    public Object getItem(int position) {
        if(!(position >= this.getCount())) {
            return this.mItems.get(position);
        } else {
            return null;
        }
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        if(convertView == null) {
            LayoutInflater mInflater = (LayoutInflater) mContext.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            convertView = mInflater.inflate(R.layout.info_list_item, null);
        }

        TextView txtTitle = (TextView) convertView.findViewById(R.id.RSSItemTitle);
        txtTitle.setText(this.mItems.get(position).getTitle());
        TextView txtDescription = (TextView) convertView.findViewById(R.id.RSSItemDescriptionLink);
        txtDescription.setText(this.mItems.get(position).getDescription());

        return convertView;
    }
}