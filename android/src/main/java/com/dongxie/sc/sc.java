package com.dongxie.sc;

import android.provider.Settings;
import android.util.Log;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableNativeMap;
import com.fm.openinstall.OpenInstall;
import com.fm.openinstall.listener.AppInstallAdapter;
import com.fm.openinstall.model.AppData;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;
//import com.google.android.gms.ads.identifier.AdvertisingIdClient;

public class sc extends ReactContextBaseJavaModule {
    ReactApplicationContext reactContext;
    public sc(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext=reactContext;
    }

    @Override
    public String getName() {
        return "sc";
    }

    @ReactMethod
    public void getIDFA(Promise promise) {
        try {

            String adId = Settings.Secure.getString(this.reactContext.getContentResolver(), Settings.Secure.ANDROID_ID);
            promise.resolve(adId);
        } catch (Exception e) {
            promise.reject(e);
        }
    }
    @ReactMethod
    public void getOpenInstallData(final Promise promise) {
        //获取OpenInstall安装数据
        OpenInstall.getInstall(new AppInstallAdapter() {
            @Override
            public void onInstall(AppData appData) {
                try {
                    //获取渠道数据
                    String channelCode = appData.getChannel();
                    //获取自定义数据
                    String bindData = appData.getData();
                    Log.d("OpenInstall", "getInstall : installData = " + appData.toString());
                    WritableMap data = new WritableNativeMap();

                    data.putString("hi","hi");
                    if(bindData!=null&&bindData!=""){
                        JSONObject jsonObject = new JSONObject(bindData);

                        WritableMap mp=new WritableNativeMap();
                        Iterator<String> keys=jsonObject.keys();
                        while(keys.hasNext()){
                            String key=keys.next();
                            mp.putString(key,jsonObject.getString(key));
                        }
                        data.putMap("data",mp);
                    }
                    data.putString("channelCode",channelCode);

                    promise.resolve(data);

                } catch (Exception e) {
                    promise.reject(e);
                }
            }
        });
    }
    @ReactMethod
    public void openInstallReportRegister(){
        OpenInstall.reportRegister();
    }

    @ReactMethod
    public void openInstallReportEffectPoint(String pointId,long point){
        OpenInstall.reportEffectPoint(pointId,point);
    }
}
