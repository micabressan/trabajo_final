/* ListActivity, главная Activity в приложении */

public class ListActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        String appKey = "...";
        Appodeal.disableLocationPermissionCheck();
        Appodeal.initialize(this, appKey, Appodeal.INTERSTITIAL | Appodeal.VIDEO);
        Appodeal.show(this, Appodeal.INTERSTITIAL);
    }
}

/* На ней есть фрагмент, снего запускается PlayerActivity, на которой также есть фрагмент, который крутит видео */

public class PlayerActivity extends AppCompatActivity {
    public static final String EXTRA_LINK = "stream_link";

    View mDecorView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_player);

        mDecorView = getWindow().getDecorView();
    }

    @Override
    protected void onStart() {
        super.onStart();
        Appodeal.show(this, Appodeal.VIDEO);
    }

    @Override
    protected void onPause() {
        super.onPause();
        Appodeal.show(this, Appodeal.INTERSTITIAL);
    }

    @TargetApi(Build.VERSION_CODES.KITKAT)
    @Override
    public void onWindowFocusChanged(boolean hasFocus) {
        super.onWindowFocusChanged(hasFocus);
        if (hasFocus) {
            mDecorView.setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                    | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                    | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                    | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                    | View.SYSTEM_UI_FLAG_FULLSCREEN
                    | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY);
        }
    }
}

/* Собственно, всё. Больше нигде реклама не трогается */