
/**
 *
 * Stencyl Extension, Create by Robin Schaafsam
 * wwww.byrobingames.com
 *
 **/

#ifndef Share
#define Share

namespace share

{
    void shareContent(const char *msg, const char *url, bool withImage);
    void shareWithScreenShot(const char *msg, const char *url, unsigned char *outputData, int w, int h);
    bool shareResultSucceed();
    bool shareResultFailed();
}


#endif
