/**
 *
 * Stencyl Extension, Create by Robin Schaafsam
 * wwww.byrobingames.com
 *
 **/

#include <Share.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES3/gl.h>

using namespace share;

@interface ViewController : UIViewController
{

}

@end

//----------//----------//----------//----------//----------//----------//

@implementation ViewController

namespace share

{
    static ViewController *acController;
    
    BOOL shareSucceed;
    BOOL shareFailed;
    
    
    void shareContent(const char *msg, const char *url, bool withImage)
    {
        ViewController *acController = [[ViewController alloc] init];
        
        if (acController == nil)
        {
            acController = [[ViewController alloc] init];
        }
        
        if(!withImage)
        {
            NSString *message = [NSString stringWithUTF8String:msg];
            NSString *tempURL= [NSString stringWithUTF8String:url];
            NSURL *newURL = [NSURL URLWithString:tempURL];
            
            NSArray* shareItems = @[message, newURL];
            
            UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
            
            NSArray *excludeActivities = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo, UIActivityTypePostToWeibo];
            
            avc.excludedActivityTypes = excludeActivities;
            
            id VC = [[[[[UIApplication sharedApplication] keyWindow] subviews] objectAtIndex:0] nextResponder];
            
            if(NSClassFromString(@"UIPopoverPresentationController"))// Show ActivityViewController in popover on IOS8 for iPad
            {
                NSLog(@"UiPopoverPresentationController for iPad IOS8");
                
                CGFloat width  = acController.view.frame.size.width;
                CGFloat height = acController.view.frame.size.height;
                
                NSLog(@"%.2f",width);
                NSLog(@"%.2f",height);
                
                
                UIPopoverPresentationController *popPresenter = [avc popoverPresentationController];
                popPresenter.sourceView = acController.view;
                popPresenter.permittedArrowDirections = 0;
                
                if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft)
                {
                    popPresenter.sourceRect = CGRectMake(width, height ,1, 1);
                }
                else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)
                {
                    popPresenter.sourceRect = CGRectMake(width, height ,1, 1);
                }
                else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown)
                {
                    popPresenter.sourceRect = CGRectMake(height, width, 1, 1);
                }
            }
            //if iPhone/iPod or iPad IOS<7
            {
                NSLog(@"iPhone/iPod or Ipad IOS <7");
                
                [avc setCompletionHandler:^(NSString *activityType, BOOL completed)
                 {
                     if (completed == TRUE)
                     {
                         shareSucceed = YES;
                         shareFailed = NO;
                     }
                     else if (completed == FALSE)
                     {
                         shareSucceed = NO;
                         shareFailed = YES;
                     }

                 }];
                
                [VC presentViewController:avc animated:YES completion:nil];
            }
        }
    }
    
    void shareWithScreenShot(const char *msg, const char *url, unsigned char *outputData, int w, int h)
    {
        ViewController *acController = [[ViewController alloc] init];
        
        if (acController == nil)
        {
            acController = [[ViewController alloc] init];
        }
        //////////////////////////////////EDIT:screenshot////////////////////////////////////////
            CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
            CGContextRef bitmapContext=CGBitmapContextCreate(outputData, w, h, 8, 4*w, colorSpace,  kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrderDefault);
            CFRelease(colorSpace);
            CGImageRef cgImage=CGBitmapContextCreateImage(bitmapContext);
            CGContextRelease(bitmapContext);
        
            UIImage * screenshot = [UIImage imageWithCGImage:cgImage];
            CGImageRelease(cgImage);
            
            ////////////////////
            
            NSString *message = [NSString stringWithUTF8String:msg];
            NSString *tempURL= [NSString stringWithUTF8String:url];
            //NSURL *newURL = [NSURL URLWithString:tempURL];
            
            NSArray* shareItems = @[message, tempURL, screenshot];
            
            UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
            
            NSArray *excludeActivities = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo, UIActivityTypePostToWeibo];
            
            avc.excludedActivityTypes = excludeActivities;
            
            id VC = [[[[[UIApplication sharedApplication] keyWindow] subviews] objectAtIndex:0] nextResponder];
            
            if(NSClassFromString(@"UIPopoverPresentationController"))// Show ActivityViewController in popover on IOS8 for iPad
            {
                NSLog(@"UiPopoverPresentationController for iPad IOS8");
                
                CGFloat width  = acController.view.frame.size.width;
                CGFloat height = acController.view.frame.size.height;
                
                NSLog(@"%.2f",width);
                NSLog(@"%.2f",height);
                
                
                UIPopoverPresentationController *popPresenter = [avc popoverPresentationController];
                popPresenter.sourceView = acController.view;
                popPresenter.permittedArrowDirections = 0;
                
                if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft)
                {
                    popPresenter.sourceRect = CGRectMake(width, height ,1, 1);
                }
                else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)
                {
                    popPresenter.sourceRect = CGRectMake(width, height ,1, 1);
                }
                else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown)
                {
                    popPresenter.sourceRect = CGRectMake(height, width, 1, 1);
                }
            }
            //if iPhone/iPod or iPad IOS<7
            {
                NSLog(@"iPhone/iPod or Ipad IOS <7");
                
                [avc setCompletionHandler:^(NSString *activityType, BOOL completed)
                 {
                     
                     if (completed == TRUE)
                     {
                         shareSucceed = YES;
                         shareFailed = NO;
                     }
                     else if (completed == FALSE)
                     {
                         shareSucceed = NO;
                         shareFailed = YES;
                     }
                     
                 }];
                
                [VC presentViewController:avc animated:YES completion:nil];
            }
    }

    bool shareResultSucceed()
    {
            if (shareSucceed)
            {
                shareSucceed = NO;
                return 1;
            }

        return 0;
    }
    
    bool shareResultFailed()
    {
            if (shareFailed)
            {
                shareFailed = NO;
                return 1;
            }

        return 0;
    }


    
}

@end