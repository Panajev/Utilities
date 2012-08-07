//
//  SysTools.h
//  WapTool
//
//  Created by Goffredo Marocchi on 12/16/09.
//  Copyright 2009 IGGS. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.

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
    NSString * __weak deviceFileFix;
    float screenScale;
    UIDevice * iDevice;
    NSString * rootFolder;
}

@property (weak, readonly, nonatomic) NSString * deviceFileFix;
@property (readonly, nonatomic) UIDevice * iDevice;

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(SysTools);

-(void) gatherDeviceData;
-(void) sendWarning:(NSString*) msg withTitle:(NSString*) title;

//File management methods
-(void) setContentRoot:(NSString*)newRootFolder;
-(NSString*) deviceFile:(NSString*)file;
-(NSString*) deviceRelFile:(NSString*)file;
-(NSString*) deviceGeneralFile:(NSString*)file;
-(NSString*) deviceFileRandom:(NSString*)file minRange:(NSUInteger)min maxRange:(NSUInteger)max;
-(NSString*) simpleFile:(NSString*)file;
-(NSString*) simpleDeviceFile:(NSString*)file;
-(NSString*) simpleFileRandom:(NSString*)file minRange:(NSUInteger)min maxRange:(NSUInteger)max;
-(NSString*) sequentialFile:(NSString*)file minID:(NSUInteger)min maxID:(NSUInteger)max reset:(BOOL)flag;

+(NSString *) docsDir;
+(NSString *) pathBundle:(NSString *)fileName;
+(NSString *) pathBundle:(NSString *)fileName extension:(NSString *)type;
+(NSString *) pathDocuments:(NSString *)fileName;
+(NSData *) dataForBundleFile:(NSString *)fileName extension:(NSString *)type;
+(BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

//

#if IPHONE_SDK_PROJECT==1
+(UIImage *) uiImage:(NSString *) fileName cached:(BOOL)flag;
+(UIImage *) uiImageCompressed:(NSString *)fileName;

+(UIImage *) decompressImage:(UIImage *) uiImage;
+(BOOL) isOS4x;
+(BOOL) iPadUI;
+(BOOL) iPadUI:(BOOL)retina;
+(BOOL) iPhoneUI:(BOOL)retina;
+(float) scalingFactor;

+(void) sendOrientationNotifications:(SEL)callSelector to:(id)object;
+(UIImage*)screenshotUIKit;
#endif

#if OSX_PROJECT==1

+(float) contentViewAspectRatio:(NSWindow *)wFrame;
+(float) windowBarHeight:(NSWindow *)wFrame;

#endif

+(BOOL) createFile:(NSString *) filename;
+(BOOL) writeToFile:(NSString *) filename;
-(void) moveToDocumentsFolder:(NSString*)filename forceInstall:(BOOL)installFlag overwrite:(BOOL)overwriteFlag;

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

