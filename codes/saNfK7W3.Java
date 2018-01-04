package com.code.pali.wisatasemaranag;

import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.code.pali.wisatasemaranag.helper.Constants;

import butterknife.BindView;
import butterknife.ButterKnife;

public class WisataDitailActivity extends AppCompatActivity {

    @BindView(R.id.iv_detail_gambar)
    ImageView ivDetailGambar;
    @BindView(R.id.tv_detail_alamat)
    TextView tvDetailAlamat;
    @BindView(R.id.tv_detail_deskripsi)
    TextView tvDetailDeskripsi;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail_wisata);
        ButterKnife.bind(this);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        // menampung data yang dikirim
        Bundle b = getIntent().getExtras();
        String namaWisata = b.getString(Constants.NAMA_WISATA);
        String gambarWisata = b.getString(Constants.GAMBAR_WISATA);
        String alamatWisata = b.getString(Constants.ALAMAT_WISATA);
        String deskripsiWisata = b.getString(Constants.DESKRIPSI_WISATA);

        //memasukan data yang didapat ke layout
        getSupportActionBar().setTitle(namaWisata);
        Glide.with(this).load("https://drive.google.com/thumbnail?id= " + gambarWisata).into(ivDetailGambar);
        tvDetailAlamat.setText(alamatWisata);
        tvDetailDeskripsi.setText(deskripsiWisata);

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                        .setAction("Action", null).show();
            }
        });
    }
}