package com.imin.printer.imin_printer;

public class BytesUtils {

    public static final byte GS =  0x1D;// Group separator

    public static byte[] printBitmap(byte[] bytes){
        byte[] bytes1  = new byte[4];
        bytes1[0] = GS;
        bytes1[1] = 0x76;
        bytes1[2] = 0x30;
        bytes1[3] = 0x00;

        return combineArrays(bytes1, bytes, cutAndLine());
    }

    public static byte[] cutAndLine() {
        byte[] command = {0x1d, 0x56, 0x42, 0x01};

        return command;
    }

    public static byte[] combineArrays(byte[]... a) {
        int massLength = 0;
        for (byte[] b : a) {
            massLength += b.length;
        }
        byte[] c = new byte[massLength];
        byte[] d;
        int index = 0;
        for (byte[] anA : a) {
            d = anA;
            System.arraycopy(d, 0, c, index, d.length);
            index += d.length;
        }
        return c;
    }


    public static byte[] byteMerger(byte[] byte_1, byte[] byte_2) {
        byte[] byte_3 = new byte[byte_1.length + byte_2.length];
        System.arraycopy(byte_1, 0, byte_3, 0, byte_1.length);
        System.arraycopy(byte_2, 0, byte_3, byte_1.length, byte_2.length);
        return byte_3;
    }
    /**
     * 生成间断性黑块数据
     * @param w : 打印纸宽度, 单位点
     * @return
     */
    public static byte[] initBlackBlock(int w){
        int ww = (w + 7)/8 ;
        int n = (ww + 11)/12;
        int hh = n * 24;
        byte[] data = new byte[ hh * ww + 5];

        data[0] = (byte)ww;//xL
        data[1] = (byte)(ww >> 8);//xH
        data[2] = (byte)hh;
        data[3] = (byte)(hh >> 8);

        int k = 4;
        for(int i=0; i < n; i++){
            for(int j=0; j<24; j++){
                for(int m =0; m<ww; m++){
                    if(m/12 == i){
                        data[k++] = (byte)0xFF;
                    }else{
                        data[k++] = 0;
                    }
                }
            }
        }
        data[k++] = 0x0A;
        return data;
    }

    /**
     * 生成一大块黑块数据
     * @param h : 黑块高度, 单位点
     * @param w : 黑块宽度, 单位点, 8的倍数
     * @return
     */
    public static byte[] initBlackBlock(int h, int w){
        int hh = h;
        int ww = (w - 1)/8 + 1;
        byte[] data = new byte[ hh * ww + 6];

        data[0] = (byte)ww;//xL
        data[1] = (byte)(ww >> 8);//xH
        data[2] = (byte)hh;
        data[3] = (byte)(hh >> 8);

        int k = 4;
        for(int i=0; i<hh; i++){
            for(int j=0; j<ww; j++){
                data[k++] = (byte)0xFF;
            }
        }
        data[k++] = 0x00;data[k++] = 0x00;
        return data;
    }

    public static byte[] hexStringToBytes(String hexString) {
        if (hexString == null || hexString.equals("")) {
            return null;
        }
        hexString = hexString.toUpperCase();
        int length = hexString.length() / 2;
        char[] hexChars = hexString.toCharArray();
        byte[] d = new byte[length];
        for (int i = 0; i < length; i++) {
            int pos = i * 2;
            d[i] = (byte) (charToByte(hexChars[pos]) << 4 | charToByte(hexChars[pos + 1]));
        }
        return d;
    }
    private static byte charToByte(char c) {
        return (byte) "0123456789ABCDEF".indexOf(c);
    }
}
