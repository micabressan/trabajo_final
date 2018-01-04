package com.example.android.myorganizer;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.support.design.widget.Snackbar;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.ImageButton;
import android.widget.TextView;
import android.widget.Toast;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.LinkedList;

/**
 * Created by dotre on 02.10.2017.
 */

public class TodayTaskAdapter extends ArrayAdapter {
    LinkedList<TodayTask> list;
    LayoutInflater inflater;
    private static TodayTaskAdapter instance;

    private TodayTaskAdapter(Context context) {
        super();
        this.list = new LinkedList<>();
        inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
    }

    public static TodayTaskAdapter getInstance(Context context) {
        if (instance == null) {
            instance = new TodayTaskAdapter(context);
        }
        return instance;
    }

    @Override
    public int getCount() {
        return list.size();
    }

    @Override
    public TodayTask getItem(int position) {
        return list.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    public void remove(int position) {
        list.remove(position);
    }

    @Override
    public View getView(final int position, View convertView, final ViewGroup parent) {
        View rowView = inflater.inflate(R.layout.list_view, parent, false);
        TextView taskName = (TextView) rowView.findViewById(R.id.taskName);
        TextView taskDescription = (TextView) rowView.findViewById(R.id.taskDescription);
        TextView taskDate = (TextView) rowView.findViewById(R.id.taskDate);
        ImageButton button = (ImageButton) rowView.findViewById(R.id.deleteButton);
        deleteButtonClicked(button, position);

        TodayTask task = getItem(position);
        taskName.setText(task.getTaskName());
        taskDescription.setText(task.getTaskDescription());

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("HH:mm dd MM yyyy");
        Calendar calendar =task.getTaskDate();
        taskDate.setText(simpleDateFormat.format(calendar.getTime()));
        return rowView;
    }

    private void deleteButtonClicked(ImageButton button, final int position) {
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(final View v) {
                AlertDialog.Builder adb = new AlertDialog.Builder(v.getContext());
                adb.setTitle("Delete?");
                adb.setMessage("Are you sure you want to delete ");
                adb.setNegativeButton("Cancel", null);
                adb.setPositiveButton("Ok", new AlertDialog.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        remove(position);
                        notifyDataSetChanged();
                        Toast.makeText(v.getContext(), "Task succesfully deleted", Toast.LENGTH_SHORT).show();
                    }
                });
                adb.show();

            }
        });
    }


    public void notifyDataSetChanged(View view) {
        super.notifyDataSetChanged();
        Snackbar snackbar = Snackbar.make(view.findViewById(R.id.main_list),"New Task added", Snackbar.LENGTH_SHORT);
        snackbar.show();
    }
}