/**
 *
 * Stencyl Extension, Create by Robin Schaafsma
 * wwww.byrobingames.com
 *
 **/

package com.byrobin.simpleshare;

import org.haxe.lime.*;
import android.content.Intent;

import android.app.Activity;
import android.content.res.AssetManager;
import android.content.Context;
import android.content.ContentValues;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.ByteArrayInputStream;
import android.net.Uri;
import android.graphics.Bitmap;
import android.util.Base64;
import android.provider.MediaStore;
import android.util.Log;

import org.haxe.extension.Extension;

public class Share extends Extension
{
    
    public static String path;
    public static Uri uri;
    
    private static boolean shareSucceed = false;
    private static boolean shareFailed = false;

    public static void shareContent(final String msg, final String url, final boolean withImage)
	{
        
        mainActivity.runOnUiThread(new Runnable()
        {
        	public void run()
			{
                
                if(!withImage)
                {

                    Intent intent = new Intent(android.content.Intent.ACTION_SEND);
                    intent.setType("text/plain");
                    intent.putExtra(Intent.EXTRA_TEXT, msg + "\n\n" + url);
                    Extension.mainContext.startActivity(Intent.createChooser(intent, "Share via.."));
                    
                    shareSucceed = true;
                    shareFailed = false;
                    
                }
                    
            }
        });
    }
    
    public static void saveImageAndShare (final String msg, final String url, final String base64Img)
    {
        mainActivity.runOnUiThread(new Runnable()
                                   {
            public void run()
            {
                Bitmap image = convertToImage(base64Img);
                
                try {
                    FileOutputStream fos = Extension.mainContext.openFileOutput("screen.png", Context.MODE_WORLD_READABLE);
                    
                    image.compress(Bitmap.CompressFormat.PNG, 100, fos);
                    fos.close();
                    
                } catch (Exception e) {
                    Log.e("saveToInternalStorage()", e.getMessage());
                }
                
                File filePath = Extension.mainContext.getFileStreamPath("screen.png");
                
                Log.e("file path ", filePath.toString());
                
                Uri fileUri = Uri.fromFile(filePath);
                
                Intent intent = new Intent(android.content.Intent.ACTION_SEND);
                intent.setType("image/jpeg");
                intent.putExtra(Intent.EXTRA_TEXT, msg + "\n\n" + url);
                intent.putExtra(Intent.EXTRA_STREAM, fileUri);
                Extension.mainContext.startActivity(Intent.createChooser(intent, "Share via.."));
                
                shareSucceed = true;
                shareFailed = false;
            }
        });
    }
    
    
    public static Bitmap convertToImage(String image)
    {
        try
        {
            InputStream stream = new ByteArrayInputStream(Base64.decode(image.getBytes(), Base64.DEFAULT));
            Bitmap bitmap = android.graphics.BitmapFactory.decodeStream(stream);
            return bitmap;
        }
        catch (Exception e)
        {
            return null;
        }
    }
    
    
    static public boolean shareResultSucceed()
    {
        if(shareSucceed)
        {
            shareSucceed = false;
            return true;
        }
        return false;
    }
    
    static public boolean shareResultFailed()
    {
        return shareFailed;
    }

}