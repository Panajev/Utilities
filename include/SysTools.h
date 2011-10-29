//
//  SysTools.h
//  WapTool
//
//  Created by Goffredo Marocchi on 12/16/09.
//  Copyright 2009 IGGS. All rights reserved.
//

#import <Foundation/Foundation.h>
#if IPHONE_SDK_PROJECT==1
#import <UIKit/UIKit.h>
#import "CocoaTouchDefines.h"
#endif

#if OSX_PROJECT==1
#import <AppKit/AppKit.h>
#endif

#import "OSDefines.h"
#import "LogDefines.h"

#import "GeneralDefines.h" 
#import "SynthesizeSingleton.h"
#import "UIDevice-Hardware.h"

//http://struct.ca/2010/xcode-folder-references/
#define BUNDLE_FULL_PATH(_filePath_) [[NSBundle mainBundle] pathForResource:[_filePath_ lastPathComponent] ofType:nil inDirectory:[_filePath_ stringByDeletingLastPathComponent]]

@interface SysTools : NSObject {
    NSString * deviceFileFix;
    float screenScale;
    UIDevice * iDevice;
}

@property (readonly, nonatomic) NSString * deviceFileFix;
@property (readonly, nonatomic) UIDevice * iDevice;

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(SysTools);

-(void) gatherDeviceData;
-(NSString*) deviceFile:(NSString*)file;

+(NSString *) docsDir;

+(NSString *) pathBundle:(NSString *)fileName;
+(NSString *) pathBundle:(NSString *)fileName extension:(NSString *)type;
+(NSString *) pathDocuments:(NSString *)fileName;

+(NSData *) dataForBundleFile:(NSString *)fileName extension:(NSString *)type;

#if IPHONE_SDK_PROJECT==1
+(UIImage *) uiImage:(NSString *) fileName cached:(BOOL)flag;
+(UIImage *) uiImageCompressed:(NSString *)fileName;

+(UIImage *) decompressImage:(UIImage *) uiImage;
//+(UIImage*) getImageFromBundleFile:(NSString*)fileName;
+(BOOL) isOS4x;
+(BOOL) iPadUI;
+(BOOL) iPhoneUI:(BOOL)retina;

+(void) sendOrientationNotifications:(SEL)callSelector to:(id)object;
+(UIImage*)screenshotUIKit;
#endif

#if OSX_PROJECT==1

+(float) contentViewAspectRatio:(NSWindow *)wFrame;
+(float) windowBarHeight:(NSWindow *)wFrame;

#endif

+(BOOL) createFile:(NSString *) filename;
+(BOOL) writeToFile:(NSString *) filename;

+(int) randomInt:(int)minV peak:(int)maxV;
+(void) printArr:(NSArray *) arr;
+(NSString *) intToString:(int) nValue;
+(NSString *) uIntToString:(unsigned) nValue;
+(NSString *) floatToString:(float) nValue;
+(NSString *) hexToString:(unsigned) nValue;

+(NSComparisonResult) compareVersion:(NSString*)targetVersion with:(NSString*)currentVersion;

+(BOOL) isOS:(NSString*)targetVersion strict:(BOOL)eq;
+(float) scalingFactor;
+(BOOL) testRightShift;

+(NSArray*) splitInTokens:(NSString *)str separator:(NSCharacterSet*)div;
+(void) countDigits:(int)number store:(char*) digits;
+(BOOL) isDigit:(char)c;
+(BOOL) isIntNumber: (NSString*) str into:(int*)number;
+(BOOL) isTokenIntNumber:(NSString*) str;
+(void) testIsNumber;
+(char const*) spellDigitsUTF8:(id)number;
+(void) printDigitsInUTF8CString:(char const*)str reverseOrder:(BOOL)reverse;

+(BOOL) readLineUTF8:(char *)output size:(int)nbytes;

@end
