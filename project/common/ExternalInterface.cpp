#ifndef IPHONE
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif

#include <hx/CFFI.h>
#include "Share.h"
#include <stdio.h>

//--------------------------------------------------
// Change this to match your extension's ID
//--------------------------------------------------

using namespace share;


#ifdef IPHONE

//--------------------------------------------------
// Glues Haxe to native code.
//--------------------------------------------------

void ios_share(value msg, value url, value withImage)
{
    shareContent(val_string(msg),val_string(url), val_bool(withImage));
}
DEFINE_PRIM(ios_share, 3);

static void share_screenshot (value msg, value url,value img, value w, value h) {
    buffer imgBuf = val_to_buffer(img);
    
    unsigned char *img_str = (unsigned char *)buffer_data(imgBuf);
    
    shareWithScreenShot(val_string(msg),val_string(url),img_str, val_int(w), val_int(h));
    
}

DEFINE_PRIM (share_screenshot, 5);

static value get_share_succeed()
{
    if (share::shareResultSucceed())
        return val_true;
    return val_false;
}
DEFINE_PRIM(get_share_succeed, 0);

static value get_share_failed()
{
    if (share::shareResultFailed())
        return val_true;
    return val_false;
}
DEFINE_PRIM(get_share_failed, 0);
#endif



//--------------------------------------------------
// IGNORE STUFF BELOW THIS LINE
//--------------------------------------------------

extern "C" void share_main()
{	
}
DEFINE_ENTRY_POINT(share_main);

extern "C" int share_register_prims()
{ 
    return 0; 
}