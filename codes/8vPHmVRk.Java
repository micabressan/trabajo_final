package com.handheldgroup.tpreview;

import android.graphics.Bitmap;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.support.v7.app.ActionBarActivity;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;

import java.nio.ByteBuffer;

import device.scanner.IScannerService;
import device.scanner.ScannerService;


public class MainActivity extends ActionBarActivity {
    IScannerService iScanner;
    StreamTask streamTask = new StreamTask();

    private static ByteBuffer makePixelBuffer(byte inByte[]) {
        byte outByte[] = new byte[4 * inByte.length];
        for (int i = 0; i < inByte.length; i++) {
            outByte[i * 4] = inByte[i];
            outByte[1 + i * 4] = inByte[i];
            outByte[2 + i * 4] = inByte[i];
            outByte[3 + i * 4] = -1;
        }

        return ByteBuffer.wrap(outByte);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        iScanner = IScannerService.Stub.asInterface(ServiceManager.getService("ScannerService"));
        try {
            iScanner.aDecodeAPIInit();
            iScanner.aDecodeSetBeepEnable(0);
        } catch (RemoteException e) {
            e.printStackTrace();
        }
        findViewById(R.id.buttonStop).setEnabled(false);
    }

    public void onStartClick(View view) {
        try {
            findViewById(R.id.buttonStart).setEnabled(false);
            findViewById(R.id.buttonStop).setEnabled(true);
            iScanner.aDecodeSetScanImageMode(ScannerService.ScanMode.DCD_MODE_IMAGE);
            iScanner.aDecodeImageSetLightMode(ScannerService.LightMode.DCD_LIGHT_MODE_ON);
            iScanner.aDecodeImageStreamInit();
            iScanner.aDecodeImageStreamStart();
            streamTask = new StreamTask();
            streamTask.execute((Void) null);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void onStopClick(View View) {
        try {
            findViewById(R.id.buttonStart).setEnabled(true);
            findViewById(R.id.buttonStop).setEnabled(false);
            iScanner.aDecodeImageStreamStop();
            streamTask.isTaskStop = true;
            streamTask.cancel(true);
            iScanner.aDecodeImageSetLightMode(ScannerService.LightMode.DCD_LIGHT_MODE_OFF);
            iScanner.aDecodeImageStreamStop();
        } catch (RemoteException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void onPause() {
        super.onPause();
        onStopClick(null);
    }

    public class StreamTask extends AsyncTask<Void, Void, Void> {
        // For aDecodeImageCapture: 832 x 640 Pixel
        // For aDecodeImageStreamRead: 416 x 320 Pixel
        public int IMAGE_WIDTH = 832;
        public int IMAGE_HEIGHT = 640;

        public boolean isTaskStop = false;
        byte lowPreviewData[];

        @Override
        protected Void doInBackground(Void... params) {
            while (!isTaskStop) {
                try {
                    lowPreviewData = new byte[IMAGE_WIDTH * IMAGE_HEIGHT];
                    int imageSize = iScanner.aDecodeImageCapture(lowPreviewData);

                    if (imageSize != 0) {
                        publishProgress();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                try {
                    Thread.sleep(200L);
                } catch (InterruptedException interruptedexception) {
                    interruptedexception.printStackTrace();
                    try {
                        iScanner.aDecodeImageSetLightMode(ScannerService.LightMode.DCD_LIGHT_MODE_OFF);
                    } catch (RemoteException e) {
                        e.printStackTrace();
                    }
                }
            }
            return null;
        }

        @Override
        protected void onProgressUpdate(Void... values) {
            super.onProgressUpdate(values);
            Bitmap bitmap = Bitmap.createBitmap(IMAGE_WIDTH, IMAGE_HEIGHT, Bitmap.Config.ARGB_8888);
            bitmap.copyPixelsFromBuffer(makePixelBuffer(lowPreviewData));
            ((ImageView) findViewById(R.id.image)).setImageBitmap(bitmap);
        }
    }
}