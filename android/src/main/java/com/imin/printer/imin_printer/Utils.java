package com.imin.printer.imin_printer;

import android.content.Context;

/**
 * @Author xhy
 * @Feature description :
 * @Date 2023/7/21 11:31
 */
public class Utils {
    private Utils() {
    }

    public static Utils getInstance() {
        return Holder.instance;
    }

    private static class Holder {
        private static final Utils instance = new Utils();
    }

    private Context mContext;
    public Context getContext() {
        return mContext;
    }
    public void setContext(Context context) {
        this.mContext = context;
    }
}
