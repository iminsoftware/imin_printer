package com.imin.printer.imin_printer;

import android.app.Application;
import android.content.Context;

import androidx.multidex.MultiDex;

/**
 * @Author xhy
 * @Feature description :
 * @Date 2023/8/2 15:28
 */
public class BaseApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
    }
    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }
}
