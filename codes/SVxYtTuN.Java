kidsAdapter
======================
package com.example.teacher.mylistview;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;
import android.widget.Toast;

import java.util.List;

/**
 * Created by teacher on 12/28/2017.
 */

public class KidsAdapter extends BaseAdapter {
    Context context;
    List<String> listKids;

    public KidsAdapter(Context context, List<String> listKids) {
        this.context = context;
        this.listKids = listKids;
    }

    //return count of list size (the getview will run as much as getCount()
    @Override
    public int getCount() {
        return listKids.size();
    }

    //return item by index (from our list)
    @Override
    public Object getItem(int i) {
        return null;
    }

    //return item id by index
    @Override
    public long getItemId(int i) {
        return 0;
    }

    //return the view , will run as much as get count
    @Override
    public View getView(final int index, View view, ViewGroup viewGroup) {
        TextView kidsName = new TextView(context);
        kidsName.setText(listKids.get(index));
        kidsName.setTextSize(32);
        kidsName.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Toast.makeText(context, "sending gift to "+listKids.get(index), Toast.LENGTH_SHORT).show();
            }
        });
        kidsName.setOnLongClickListener(new View.OnLongClickListener() {
            @Override
            public boolean onLongClick(View view) {
                AlertDialog.Builder builder = new AlertDialog.Builder(context);
                builder.setTitle("Remove kid");
                builder.setMessage("Do you want to remove\n"+listKids.get(index));
                builder.setNegativeButton("No", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        dialogInterface.dismiss();
                    }
                });
                builder.setPositiveButton("Yes", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        listKids.remove(index);
                        notifyDataSetChanged();
                        dialogInterface.dismiss();
                    }
                });
                builder.show();

                return true;
            }
        });
        return kidsName;
    }
}


MainActivity.java
====================
package com.example.teacher.mylistview;

import android.content.Context;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.ListView;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {

    ListView lstKids;
    List<String> kidsNames;
    Context context;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        setPointer();
    }

    private void setPointer() {
        this.context=this;
        lstKids=findViewById(R.id.lstKids);
        fillData();
        KidsAdapter myAdapter = new KidsAdapter(context,kidsNames);
        lstKids.setAdapter(myAdapter);
    }

    private void fillData() {
        kidsNames = new ArrayList<>();
        kidsNames.add("Leena");
        kidsNames.add("Hanit");
        kidsNames.add("Yana");
        kidsNames.add("Adva");
        kidsNames.add("Aya");
        kidsNames.add("Rond");
        kidsNames.add("Rehab");
        kidsNames.add("Boris");
        kidsNames.add("Daniel");
        kidsNames.add("Saleh the wrapper");
        kidsNames.add("Kakadu");
        kidsNames.add("Alex");
        kidsNames.add("Richared");
        kidsNames.add("Nipo");
        kidsNames.add("Amital");
        kidsNames.add("Anawer");
    }

}


activity_main.xml
=====================
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:layout_margin="16dp">

    <ListView
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:id="@+id/lstKids"/>
</LinearLayout>