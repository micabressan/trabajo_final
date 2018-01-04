package com.code.pali.wisatasemaranag.fragment;

import android.app.ProgressDialog;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import com.code.pali.wisatasemaranag.Api.ServiceClient;
import com.code.pali.wisatasemaranag.Api.ServiceGenerator;
import com.code.pali.wisatasemaranag.R;
import com.code.pali.wisatasemaranag.adapter.WisataAdapter;
import com.code.pali.wisatasemaranag.model.ListWisata;
import com.code.pali.wisatasemaranag.model.Wisata;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.Unbinder;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;


public class HomeFragment extends Fragment {

    @BindView(R.id.rv_home)
    RecyclerView rvHome;
    Unbinder unbinder;

    ProgressDialog pd;
    public HomeFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_home, container, false);
        unbinder = ButterKnife.bind(this, view);
        LinearLayoutManager llm =new LinearLayoutManager(getActivity());
        rvHome.setLayoutManager(llm);
        getData();
        return view;
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        unbinder.unbind();
    }

    private void getData(){

        ServiceClient service = ServiceGenerator.getClient().create(ServiceClient.class);
        Call<ListWisata> call=service.getWisata("semarang");

        pd = new ProgressDialog(getActivity());
        pd.setMessage("Load Data From Server...");
        pd.show();

        call.enqueue(new Callback<ListWisata>() {
            @Override
            public void onResponse(Call<ListWisata> call, Response<ListWisata> response) {
                ListWisata wisata = response.body();
                pd.dismiss();

                WisataAdapter adapter = new WisataAdapter(wisata.getListWisataSemarang());
                rvHome.setAdapter(adapter);

            }

            @Override
            public void onFailure(Call<ListWisata> call, Throwable t) {
                Toast.makeText(getActivity(),""+t.getMessage(), Toast.LENGTH_LONG).show();

            }
        });
    }
}