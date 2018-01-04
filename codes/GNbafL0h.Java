activity_main.xml
==========================
<LinearLayout android:layout_height="match_parent"
    android:layout_width="match_parent"
    android:orientation="vertical"
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:background="@drawable/background">

    <RelativeLayout
        android:layout_height="match_parent"
        android:layout_margin="50dp"
        android:layout_width="match_parent">

        <EditText
            android:hint="Enter First Person name..."
            android:id="@+id/txtFirstPerson"
            android:layout_height="wrap_content"
            android:layout_width="match_parent"
            android:textColor="#ffffff"
            android:textColorHint="#ffffff"/>

        <EditText
            android:hint="Enter Second Person"
            android:id="@+id/txtSecondPerson"
            android:layout_below="@id/txtFirstPerson"
            android:layout_height="wrap_content"
            android:layout_marginTop="20dp"
            android:layout_width="match_parent"
            android:textColor="#ffffff"
            android:textColorHint="#ffffff"/>

        <Button
            android:background="#ff9310"
            android:id="@+id/btnMatch"
            android:layout_alignParentBottom="true"
            android:layout_height="wrap_content"
            android:layout_width="match_parent"
            android:text="Show Match"
            android:textColor="#ffffff" />

        <Button
            android:background="#ff9310"
            android:id="@+id/btnClear"
            android:layout_above="@id/btnMatch"
            android:layout_height="wrap_content"
            android:layout_marginBottom="20dp"
            android:layout_width="match_parent"
            android:text="Clear Me"
            android:textColor="#ffffff" />
    </RelativeLayout>


</LinearLayout>


activity_match.xml
=====================
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@drawable/background">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="100%"
        android:textSize="100sp"
        android:textColor="#ffffff"
        android:textStyle="bold"
        android:layout_centerInParent="true"
        android:id="@+id/txtMatch"/>
</RelativeLayout>


MainActivity.java
========================
package com.example.teacher.mybundle;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {
    EditText txtFirstPerson,txtSecondPerson;
    Button btnClear,btnMatch;
    Context context;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        setPointer();
    }

    private void setPointer() {
        this.context=this;
        txtFirstPerson=findViewById(R.id.txtFirstPerson);
        txtSecondPerson=findViewById(R.id.txtSecondPerson);
        btnClear=findViewById(R.id.btnClear);
        btnClear.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                clearMe();
            }
        });
        btnMatch=findViewById(R.id.btnMatch);
        btnMatch.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                //we need to pass a data to second intent (which be calculated there)
                Intent matchIntent = new Intent(context,MatchActivity.class);
                //pass the data to the other screen with put/get extra and a bundle
                Bundle bundle = new Bundle();
                bundle.putString("person1",txtFirstPerson.getText().toString());
                bundle.putString("person2",txtSecondPerson.getText().toString());
                matchIntent.putExtras(bundle);
                //clear data
                clearMe();
                //start the new activity
                startActivity(matchIntent);
            }
        });
    }

    private void clearMe()
    {
        txtFirstPerson.setText("");
        txtSecondPerson.setText("");
    }

    @Override
    public void onBackPressed() {
        AlertDialog.Builder builder = new AlertDialog.Builder(context);
        builder.setTitle("Exit Application");
        builder.setMessage("Are you Sure?");
        builder.setNegativeButton("No", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                dialogInterface.dismiss();
            }
        });
        builder.setPositiveButton("Yes", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                finish();
            }
        });
        builder.show();
    }
}


MatchActivity.java
=======================
package com.example.teacher.mybundle;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;

public class MatchActivity extends AppCompatActivity {
    String name1,name2;
    int match;
    TextView txtMatch;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_match);
        setPointer();
    }

    private void setPointer() {
        Intent intent = getIntent();
        Bundle bundle = intent.getExtras();
        name1=bundle.getString("person1");
        name2=bundle.getString("person2");
        match=getCalc();

        //display the result.
        txtMatch=findViewById(R.id.txtMatch);
        txtMatch.setText(getCalc()+"%");
    }

    //calculate the number between two names.
    private int getCalc()
    {
        double sum1=0,sum2=0;
        //handle name 1
        char[] c1=name1.toCharArray();
        char[] c2=name2.toCharArray();

        for (char item:c1)
        {
            sum1+=item;
        }
        for (char item:c2)
        {
            sum2+=item;
        }

        //divide by lower number first
        double myMatch = sum1<sum2?sum1/sum2:sum2/sum1;
        myMatch*=100;
        Log.e("Check", "getCalc: "+(sum1<sum2?sum1+"/"+sum2:sum2+"/"+sum1));
        return (int)myMatch;

    }

    @Override
    public void onBackPressed() {
        finish();
    }
}