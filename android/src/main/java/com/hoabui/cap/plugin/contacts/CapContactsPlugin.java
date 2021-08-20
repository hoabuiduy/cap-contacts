package com.hoabui.cap.plugin.contacts;

import static android.content.ContentValues.TAG;

import android.Manifest;
import android.content.ContentResolver;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.provider.ContactsContract;
import android.util.Log;

import androidx.activity.result.ActivityResult;

import com.getcapacitor.JSObject;
import com.getcapacitor.PermissionState;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.ActivityCallback;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.getcapacitor.annotation.Permission;
import com.getcapacitor.annotation.PermissionCallback;
import java.util.ArrayList;
import java.util.List;

@CapacitorPlugin(
    name = "CapContacts",
    permissions = { @Permission(strings = { Manifest.permission.READ_CONTACTS, Manifest.permission.WRITE_CONTACTS }, alias = "contacts") }
)
public class CapContactsPlugin extends Plugin {

    private CapContacts implementation = new CapContacts();

    @PluginMethod
    public void echo(PluginCall call) {
        String value = call.getString("value");

        JSObject ret = new JSObject();
        ret.put("value", implementation.echo(value));
        call.resolve(ret);
    }

    @PluginMethod
    public void checkPermission(PluginCall call){
        JSObject rs = new JSObject();

        if (this.getPermissionState("contacts") != PermissionState.GRANTED) {
            rs.put("granted", false);
        } else {
          rs.put("granted", true);
        }
        call.resolve(rs);
    }

    @PluginMethod
    public void requestPermission(PluginCall call){
        this.checkPermission(call);
    }

    @PluginMethod
    public void getContacts(PluginCall call) {
        String name = call.getString("name");
        if (this.getPermissionState("contacts") != PermissionState.GRANTED) {
            requestAllPermissions(call, "contactPermissionCallback");
        } else {
            List<JSObject> list = implementation.getContacts(getContext(), name);
            JSObject ret = new JSObject();
            ret.put("contacts", list);
            call.resolve(ret);
        }
    }

    @PluginMethod
    public void pickContact(PluginCall call){
        Uri uri = Uri.parse("content://contacts");
        Intent intent = new Intent(Intent.ACTION_PICK, uri);
        intent.setType(ContactsContract.CommonDataKinds.Phone.CONTENT_TYPE);
        startActivityForResult(call, intent, "pickContactResult");
    }

    @ActivityCallback
    private void pickContactResult(PluginCall call, ActivityResult result) {
        if (call == null) {
            return;
        }

        Intent uri = result.getData();
        String[] projection = { ContactsContract.CommonDataKinds.Phone.NUMBER, ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME };

        Cursor cursor = getContext().getContentResolver().query(uri.getData(), projection,
                null, null, null);
        cursor.moveToFirst();

        int numberColumnIndex = cursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER);
        String number = cursor.getString(numberColumnIndex);

        int nameColumnIndex = cursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME);
        String name = cursor.getString(nameColumnIndex);

        Log.d(TAG, "ZZZ number : " + number +" , name : "+name);
        JSObject obj = new JSObject();
        obj.put("name", name);
        obj.put("phone", number);
        JSObject rs = new JSObject();
        rs.put("contact", obj);
        call.resolve(rs);
        // Do something with the result data
    }

    @PermissionCallback
    private void contactPermissionCallback(PluginCall call) {
        String name = call.getString("name");
        if (getPermissionState("contacts") == PermissionState.GRANTED) {
            List<JSObject> list = this.implementation.getContacts(getContext(), name);
            JSObject ret = new JSObject();
            ret.put("contacts", list);
            call.resolve(ret);
        }
    }



}
