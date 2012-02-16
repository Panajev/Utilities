//
//  SysTools.m
//  WapTool
//
//  Created by Goffredo Marocchi on 12/16/09.
//  Copyright 2009 IGGS. All rights reserved.
//

#import "SysTools.h"
#import "MathHelper.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <stdio.h>

@implementation SysTools

SYNTHESIZE_SINGLETON_FOR_CLASS(SysTools);

@synthesize deviceFileFix, iDevice;

-(void) gatherDeviceData {
    deviceFileFix=nil;
    if([SysTools iPadUI]) {
        deviceFileFix=@"-ipad";
    }
    
    screenScale = [SysTools scalingFactor];
    iDevice = [[UIDevice alloc] init];
}

#if IPHONE_SDK_PROJECT==1
///////////////////////////////////////
//////// iPhone specific functions ////
///////////////////////////////////////
//////vvvvvvvvvvvvvvvvvvvvvvvvvvv//////

+(UIImage *) uiImage:(NSString *)fileName cached:(BOOL)flag {
	UIImage * temp = nil;
	NSString *fileLocation = [SysTools pathBundle:fileName];
	
	if (flag) {
		return [UIImage imageNamed:fileName];
	}
	else {
		temp = [UIImage imageWithContentsOfFile:fileLocation];
		temp = [SysTools decompressImage:temp];
	}
	return temp;
}

+(UIImage *) uiImageCompressed:(NSString *) fileName {
	NSString *fileLocation = [SysTools pathBundle:fileName];
	return [UIImage imageWithContentsOfFile:fileLocation]; //decompression happens at display time
}

+(UIImage *) decompressImage:(UIImage *) uiImage {
	/*
	 this can fail, so while the code doesn't have any error checking, 
	 in particular you should check that CGDataProviderCopyData() returns a valid CFDataRef 
	 (it can return NULL for various reasons).
	 */
	
	CGImageRef originalImage = uiImage.CGImage;
	CFDataRef imageData = CGDataProviderCopyData(
												 CGImageGetDataProvider(originalImage));
	if (imageData == NULL) return nil;
	
	CGDataProviderRef imageDataProvider = CGDataProviderCreateWithCFData(imageData);
	CFRelease(imageData);
	CGImageRef image = CGImageCreate(
									 CGImageGetWidth(originalImage),
									 CGImageGetHeight(originalImage),
									 CGImageGetBitsPerComponent(originalImage),
									 CGImageGetBitsPerPixel(originalImage),
									 CGImageGetBytesPerRow(originalImage),
									 CGImageGetColorSpace(originalImage),
									 CGImageGetBitmapInfo(originalImage),
									 imageDataProvider,
									 CGImageGetDecode(originalImage),
									 CGImageGetShouldInterpolate(originalImage),
									 CGImageGetRenderingIntent(originalImage));
	CGDataProviderRelease(imageDataProvider);
	UIImage *decompressedImage = [UIImage imageWithCGImage:image];
	CGImageRelease(image);	
	return decompressedImage;
}

/**
 *The following function checks if the OS version is >= 4.0
 */
+(BOOL) isOS4x {
	return [SysTools isOS:@"4.0" strict:NO];
}

+(BOOL) iPadUI {
    if(![SysTools isOS:@"3.2" strict:NO]) {
        return NO;
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // The device is an iPad running iPhone 3.2 or later.
        return YES;
    }
    else
    {
        // The device is an iPhone or iPod touch.
        return NO;
    }
}
+(BOOL) iPhoneUI:(BOOL)retina {
    if([SysTools isOS:@"3.2" strict:NO]) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            // The device is an iPad running iPhone 3.2 or later.
            return NO;
        }
        else
        {
            if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] > 1.1){
                return retina;
            }
            else {
                return (!retina);
            }
        }
    }
    else
    {
        if ([SysTools scalingFactor] > 1.1f){
            return retina;
        }
        else {
            return (!retina);
        }
    }
}

-(void) sendWarning:(NSString*) msg withTitle:(NSString*) title {
    if(msg == nil || title == nil) {
        return;
    }
    
    UIAlertView *message = [[[UIAlertView alloc] initWithTitle:title
                                                       message:msg
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil] autorelease];
    
    [message show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    [alertView release];
}

+(float) scalingFactor {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]){
        return [[UIScreen mainScreen] scale];
    }
    else {
        return 1.0f;
    }
}


#pragma mark -
#pragma mark File handling

-(void) setContentRoot:(NSString*)newRootFolder {
    if(rootFolder != newRootFolder) {
        [rootFolder release];
        rootFolder = [newRootFolder copy];
    }
}

+(NSString *) docsDir {	
	NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
															  NSUserDomainMask,YES);
    NSString *path_docs = [NSString stringWithString:[arrayPaths objectAtIndex:0]];
	return path_docs;
}

+(NSString *) pathBundle:(NSString *)fileName {
    return [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
	//example: path = /var/mobile/Applications/C253637D-6A6B-4E44-AFF6-20E7B9E5D2E8/WapTool.app/temp.csv
}

+(NSString *) pathBundle:(NSString *)fileName extension: (NSString *) type {
	return [[NSBundle mainBundle] pathForResource:fileName ofType:type];
	//example: path = /var/mobile/Applications/C253637D-6A6B-4E44-AFF6-20E7B9E5D2E8/WapTool.app/temp.csv
}

+(NSString *) pathDocuments:(NSString *)fileName {
    return[[SysTools docsDir] stringByAppendingPathComponent:fileName];
	//example: path = /var/mobile/Applications/35530667-4960-4F48-843A-1B830855914A/Documents/temp.csv
}

//TODO: adjust the file management functions for MacOS X compatibility too.
- (NSString*) deviceFile:(NSString*)file {
    NSArray * tempArray = nil;
    tempArray = [[NSArray alloc] initWithArray:[file componentsSeparatedByString:@"."]];
    NSString * newFilePath = nil;
    
    if(tempArray.count == 2) {
        if([tempArray objectAtIndex:0] != nil &&[tempArray objectAtIndex:1] != nil) {
            if(deviceFileFix != nil) { 
                newFilePath = [NSString stringWithFormat:@"ipad_art/%@%@.%@", [tempArray objectAtIndex:0], deviceFileFix,
                               [tempArray objectAtIndex:1]];
            }
            else if ([[iDevice platformString] isEqualToString:IPHONE_3G_NAMESTRING]) {
                CMLog(@"iPhone 3G path...");
                newFilePath = [NSString stringWithFormat:@"iphone_art/%@.png", [tempArray objectAtIndex:0]];
            }
            else {
                newFilePath = [NSString stringWithFormat:@"iphone_art/%@.%@", [tempArray objectAtIndex:0], 
                               [tempArray objectAtIndex:1]];
            }
            CMLog(@"newFilePath = %@", newFilePath);
        }
        
        if(rootFolder != nil) {
            newFilePath = [NSString stringWithFormat:@"%@/%@", rootFolder, newFilePath];
        }
    }
    
    SAFE_RELEASE(tempArray);
    return newFilePath;
}

- (NSString*) deviceGeneralFile:(NSString*)file {
    NSArray * tempArray = nil;
    tempArray = [[NSArray alloc] initWithArray:[file componentsSeparatedByString:@"."]];
    NSString * newFilePath = nil;
    
    if(tempArray.count == 2) {
        if([tempArray objectAtIndex:0] != nil &&[tempArray objectAtIndex:1] != nil) {
            if(deviceFileFix != nil) { 
                newFilePath = [NSString stringWithFormat:@"ipad_art/%@.%@", [tempArray objectAtIndex:0], 
                               [tempArray objectAtIndex:1]];
            }
            else if (screenScale > 1.0f) {
                newFilePath = [NSString stringWithFormat:@"iphone_art/%@-hd.%@", [tempArray objectAtIndex:0], 
                               [tempArray objectAtIndex:1]];
            }
            else {
                newFilePath = [NSString stringWithFormat:@"iphone_art/%@.%@", [tempArray objectAtIndex:0], 
                               [tempArray objectAtIndex:1]];
            }
            CMLog(@"newFilePath = %@", newFilePath);
        }
        
        if(rootFolder != nil) {
            newFilePath = [NSString stringWithFormat:@"%@/%@", rootFolder, newFilePath];
        }
    }
    
    SAFE_RELEASE(tempArray);
    return newFilePath;
}


- (NSString*) deviceFileRandom:(NSString*)file minRange:(NSUInteger)min maxRange:(NSUInteger)max {
    NSString * fileName = [self deviceFile:file];
    
    NSArray * tempArray = nil;
    tempArray = [[NSArray alloc] initWithArray:[fileName componentsSeparatedByString:@"."]];
    NSString * newFilePath = nil;
    
    if(tempArray.count == 2) {
        if([tempArray objectAtIndex:0] != nil &&[tempArray objectAtIndex:1] != nil) {
            newFilePath = [NSString stringWithFormat:@"%@%d.%@", [tempArray objectAtIndex:0],
                           rangeRNGi(min, max),
                           [tempArray objectAtIndex:1]];
        }
    }
    
    SAFE_RELEASE(tempArray);
    return newFilePath;
}

- (NSString*) simpleFile:(NSString*)file {
    NSString * newFilePath = file;
    
    if(rootFolder != nil) {
        newFilePath = [NSString stringWithFormat:@"%@/%@", rootFolder, newFilePath];
    }
    return newFilePath;
}

- (NSString*) simpleDeviceFile:(NSString*)file {
    NSArray * tempArray = nil;
    tempArray = [[NSArray alloc] initWithArray:[file componentsSeparatedByString:@"."]];
    NSString * newFilePath = nil;
    
    if(tempArray.count == 2) {
        if([tempArray objectAtIndex:0] != nil &&[tempArray objectAtIndex:1] != nil) {
            if(deviceFileFix != nil) { 
                newFilePath = [NSString stringWithFormat:@"ipad_art/%@.%@", [tempArray objectAtIndex:0], 
                               [tempArray objectAtIndex:1]];
            }
            else {
                newFilePath = [NSString stringWithFormat:@"iphone_art/%@.%@", [tempArray objectAtIndex:0], 
                               [tempArray objectAtIndex:1]];
            }
            CMLog(@"newFilePath = %@", newFilePath);
        }
        
        if(rootFolder != nil) {
            newFilePath = [NSString stringWithFormat:@"%@/%@", rootFolder, newFilePath];
        }
    }
    
    SAFE_RELEASE(tempArray);
    return newFilePath;
}

- (NSString*) simpleFileRandom:(NSString*)file minRange:(NSUInteger)min maxRange:(NSUInteger)max {
    NSArray * tempArray = nil;
    tempArray = [[NSArray alloc] initWithArray:[file componentsSeparatedByString:@"."]];
    NSString * newFilePath = nil;
    
    if(tempArray.count == 2) {
        if([tempArray objectAtIndex:0] != nil &&[tempArray objectAtIndex:1] != nil) {
            newFilePath = [NSString stringWithFormat:@"%@%d.%@", [tempArray objectAtIndex:0],
                           rangeRNGi(min, max),
                           [tempArray objectAtIndex:1]];
        }
    }
    
    CMLog(@"newFilePath = %@", newFilePath);
    
    SAFE_RELEASE(tempArray);
    return newFilePath;
}

- (NSString*) sequentialFile:(NSString*)file minID:(NSUInteger)min maxID:(NSUInteger)max reset:(BOOL)flag {
    NSArray * tempArray = nil;
    tempArray = [[NSArray alloc] initWithArray:[file componentsSeparatedByString:@"."]];
    NSString * newFilePath = nil;
    
    static NSUInteger cIndex = 1;
    static NSUInteger maxIndex = 1;
    
    if(flag == YES) {
        cIndex = min;
        maxIndex = max;
    }
    
    if(tempArray.count == 2) {
        if([tempArray objectAtIndex:0] != nil &&[tempArray objectAtIndex:1] != nil) {
            newFilePath = [NSString stringWithFormat:@"%@%d.%@", [tempArray objectAtIndex:0],
                           cIndex%maxIndex,
                           [tempArray objectAtIndex:1]];
        }
    }
    cIndex++;
    
    CMLog(@"newFilePath = %@", newFilePath);
    
    SAFE_RELEASE(tempArray);
    return newFilePath;
}

#pragma mark -

+(void) sendOrientationNotifications:(SEL)callSelector to:(id)object {
	
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	
	[[NSNotificationCenter defaultCenter] removeObserver:object name:UIDeviceOrientationDidChangeNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:object
											 selector:callSelector
												 name:UIDeviceOrientationDidChangeNotification object:nil];
}

+(UIImage*)screenshotUIKit {
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
	
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    // Iterate over every window from back to front
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) 
    {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
        {
            // -renderInContext: renders in the coordinate space of the layer,
            // so we must first apply the layer's geometry to the graphics context
            CGContextSaveGState(context);
            // Center the context around the window's anchor point
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            // Apply the window's transform about the anchor point
            CGContextConcatCTM(context, [window transform]);
            // Offset by the portion of the bounds left of and above the anchor point
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [(CALayer*)[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
			
            // Render the layer hierarchy to the current context
            [[window layer] renderInContext:context];
			
            // Restore the context
            CGContextRestoreGState(context);
        }
    }
	
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	
    UIGraphicsEndImageContext();
	
    return image;
}

//////^^^^^^^^^^^^^^^^^^^^^^^^^^^//////
///////////////////////////////////////
//////// iPhone specific functions ////
///////////////////////////////////////
#endif


#if OSX_PROJECT==1
///////////////////////////////////////
//////// OS X specific functions //////
///////////////////////////////////////
//////vvvvvvvvvvvvvvvvvvvvvvvvvvv//////

+(float) contentViewAspectRatio:(NSWindow *)wFrame {
	return ([wFrame contentAspectRatio].width /
			[wFrame contentAspectRatio].height);	
}

+(float) windowBarHeight:(NSWindow *) wFrame {
	return ((float)[wFrame frame].size.height - 
			[(NSView*)[wFrame contentView] frame].size.height);
}


//////^^^^^^^^^^^^^^^^^^^^^^^^^^^//////
///////////////////////////////////////
//////// OS X specific functions //////
///////////////////////////////////////
#endif

+(NSData *) dataForBundleFile: (NSString *)fileName extension: (NSString *) type {
	
	NSString *path = [SysTools pathBundle:fileName extension:type];
	NSLog(@"(SysTools) %@ %@", fileName, path);
    NSData *myData = [NSData dataWithContentsOfFile:path];
	return myData;
}

/**
 * File created in the Documents directory
 */
+(BOOL) createFile:(NSString *) filename
{
	LOCAL_AR_POOL_ALLOC();
	//NSString *filePath = [NSString stringWithString:[SysTools pathDocuments:filename]];
	//filePath = filePath; //suppress "Unused variable" warning
	
#if DEBUG==1
	//NSLog(@"Filepath of %@ is \"%@\"", filename, filePath);
#endif
	
	//TODO: complete function template	
	
	LOCAL_AR_POOL_DRAIN();
	return TRUE;
}

+(BOOL) writeToFile:(NSString *) filename {
	LOCAL_AR_POOL_ALLOC();
	[filename compare:filename];
	//TODO: complete function template	
	LOCAL_AR_POOL_DRAIN();
	return TRUE;	
}

-(void) moveToDocumentsFolder:(NSString*)filename forceInstall:(BOOL)installFlag overwrite:(BOOL)overwriteFlag {
    NSFileManager *defFM = [NSFileManager defaultManager];
    NSString *docsDir = [SysTools docsDir];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //..Stuff that is done only once when installing a new version....
    static NSString *AppVersionKey = @"AppVersion";
    NSString * lastVersion = [userDefaults stringForKey: AppVersionKey];
    NSString * thisVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    if( [SysTools compareVersion:lastVersion with:thisVersion] != NSOrderedSame || installFlag) {
        [userDefaults setObject:thisVersion forKey:AppVersionKey];
        NSString *appDir = [[NSBundle mainBundle] resourcePath];
        NSString *src = [appDir stringByAppendingPathComponent:filename];
        NSString *dest = [docsDir stringByAppendingPathComponent:filename];
        
        if (overwriteFlag == YES) {
            [defFM removeItemAtPath:dest error:NULL];  //..remove old copy
        }
        else if ([defFM fileExistsAtPath:dest]) {
            return;
        }
        
        BOOL errors = [defFM copyItemAtPath:src toPath:dest error: NULL];
        if(errors == NO) {
            CMLog(@"File %@ copied to @%", src, dest);
        }
    }
}

+(int) randomInt:(int)minV peak:(int)maxV {
	int nValue;
	float r;
	
	r = (float)rand(); //set srand() in your application's main function.
	nValue = (r / RAND_MAX) * (maxV + 1);
	if ((float)nValue > maxV) nValue = minV;
	
	//CMLog (@"float is %f\n", (float)nValue);
	
	return nValue;	
}

+(void) printArr:(NSArray *)arr {
#if DEBUG==1
	NSEnumerator *iterator = [arr objectEnumerator];
	NSObject *obj;
	int index = 0;
	
	while ((obj = [iterator nextObject])) {
		printf("El[%d]: %s\n", index, [[obj description] cStringUsingEncoding:NSUTF8StringEncoding]);
		index++;
	}
	
#endif
	
	return;
}

+(NSString *) intToString:(int) nValue {
	return [NSString stringWithFormat:@"%d", nValue];
}
+(NSString *) uIntToString:(unsigned) nValue {
	return [NSString stringWithFormat:@"%u", nValue];
}
+(NSString *) floatToString:(float) nValue {
	return [NSString stringWithFormat:@"%f", nValue];
}
+(NSString *) hexToString:(unsigned) nValue {
	return [NSString stringWithFormat:@"%X", nValue];
}

/**
 *The following function checks if the OS version is >= targetVersion
 */
+(BOOL) isOS:(NSString*)targetVersion strict:(BOOL)eq {
	
#if OSX_PROJECT==1
	
#if DEBUG == 1
	NSLog (@"(NO) This function currently targets iOS releases only", targetVersion, OS_VERSION);
#endif
	return NO;
#else
	NSComparisonResult resultTest = [SysTools compareVersion:targetVersion with:OS_VERSION];
#endif
	
	if ((!eq) && ((resultTest == NSOrderedSame) || (resultTest == NSOrderedAscending))) {
		
#if DEBUG == 1
		if (resultTest == NSOrderedSame) 
            ;
        //NSLog (@"(OK) OS comparison result is: %@ target == %@ current", targetVersion, OS_VERSION);
		else 
            ;
        //NSLog (@"(OK) OS comparison result is: %@ target < %@ current", targetVersion, OS_VERSION);
#endif
		return  YES;
		
	}
	else if (eq && (resultTest == NSOrderedSame)) {
#if DEBUG == 1
		//NSLog (@"(OK) OS comparison result is: %@ target == %@ current", targetVersion, OS_VERSION);
#endif
		return YES;
	}
	else { 
        CMLog (@"(OK) OS comparison result is: %@ target > %@ current", targetVersion, OS_VERSION);
        return NO;
    }
}

/*
 * http://snipplr.com/view.php?codeview&id=2771 (credit)
 * compareVersions(@"10.4",             @"10.3")             returns NSOrderedDescending (1)
 * compareVersions(@"10.5",             @"10.5.0")           returns NSOrderedSame (0)
 * compareVersions(@"10.4 Build 8L127", @"10.4 Build 8P135") returns NSOrderedAscending (-1)
 */
+(NSComparisonResult) compareVersion:(NSString*)targetVersion with:(NSString*)currentVersion{
	
	//LOCAL_AR_POOL_ALLOC();
	
	int i = 0;
	
	// Break version into fields (separated by '.')
	NSMutableArray *leftFields  = [[NSMutableArray alloc] initWithArray:[targetVersion  componentsSeparatedByString:@"."]];
	NSMutableArray *rightFields = [[NSMutableArray alloc] initWithArray:[currentVersion componentsSeparatedByString:@"."]];
	
	// Implict ".0" in case version doesn't have the same number of '.'
	if ([leftFields count] < [rightFields count]) {
		while ([leftFields count] != [rightFields count]) {
			[leftFields addObject:@"0"];
		}
	} else if ([leftFields count] > [rightFields count]) {
		while ([leftFields count] != [rightFields count]) {
			[rightFields addObject:@"0"];
		}
	}
	
	// Do a numeric comparison on each field
	for(i = 0; i < [leftFields count]; i++) {
		NSComparisonResult result = [[leftFields objectAtIndex:i] compare:[rightFields objectAtIndex:i] options:NSNumericSearch];
		if (result != NSOrderedSame) {
			[leftFields release];
			[rightFields release];
			return result;
		}
	}
	
	[leftFields release];
	[rightFields release];	
	
	//LOCAL_AR_POOL_DRAIN();
	
	return NSOrderedSame;
}

+(BOOL) testRightShift {
	CMLog (@" Testing Right Shift... ");
	CMLog (@"DEBUG = %i", DEBUG);
	
	BOOL isArithmetic = NO;
	
	int shift_a = -4;
	
	shift_a >>= 1;
	CMLog(@"result of -4 >> 1 is %i", shift_a);
	switch (shift_a) {
		case -2:
#if DEBUG==1
			NSLog(@"This system supports Arithmetic right shift in Objective-C");
#endif
			isArithmetic = YES;
			break;
		default:
		{
#if DEBUG==1
			if (shift_a > 0) NSLog(@"This system supports Logical right shift in Objective-C");
			if (shift_a <= 0) NSLog(@"This system has broken right shift in Objective-C");
#endif
		}
			break;
	}	
	return isArithmetic;
}

+(void) countDigits:(int)number store:(char*) digits{
	int i = 0;
	while (number > 0) {
		digits[i++] = TO_CHAR(number%10);
		number /= 10;
	}
	digits[i]='\0';
#if DEBUG==1
	NSLog (@"n_objects_arr: %i", i);
#endif
	return;
}

+(BOOL) isDigit:(char)c  {
	BOOL result = NO;
	
	switch (c) {
		case '0':
		case '1':
		case '2':
		case '3':
		case '4':
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
#if DEBUG_VERBOSE==1
			NSLog(@"Valid digit: %c", c);
#endif
			result = YES;
			break;
			
		default:
			break;
	}
	return result;
}

+(BOOL) isTokenIntNumber:(NSString*) str {
	
	MARK;
	
	if (!str) return NO;
	
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	BOOL number_scanned = NO;
	
	char last_c = '\0';
	char c = '\0';
	
	char const* cStr = [str UTF8String];
	
	for (int i = 0; cStr[i] != '\0'; i++){
#if DEBUG_VERBOSE==1
		printf("\nEntering the for loop...\n");
#endif		
		c = cStr[i] ;
		
		if (c == '\n' || c == '\r') {
			if ([SysTools isDigit:last_c]) number_scanned = YES;
			break;
		}
		else if (c == ' ') {
#if DEBUG_VERBOSE==1
			NSLog(@"White space found...%c... Testing last digit last_c", c);
#endif
			if ([SysTools isDigit:last_c]) number_scanned = YES;
			last_c = c;
		}
		else if (c == '-') {
			if ([SysTools isDigit:last_c] || (last_c == '-') || number_scanned) {
				last_c = '\0';
				number_scanned = NO;
				break;
			}
			last_c = '-';
		}
		else if ([SysTools isDigit:c]) {
			if (number_scanned) {
				number_scanned = NO; //we already got our number, if we detect another one it means that the 
				//user submitted more than one value in the current string
				break;
			}
			else last_c = c;
		}
		else {
			last_c = '\0';
			number_scanned = NO;
			break;
		}
#if DEBUG_VERBOSE==1
		printf("Looping back in the for loop...");
#endif
	}
#if DEBUG_VERBOSE==1	
	printf("\nOut of the for loop... Testing last digit last_c\n");
#endif
	if ([SysTools isDigit:last_c]) {
		number_scanned = YES;
	}
	
	[pool drain];
	return number_scanned;
}

+(BOOL) isIntNumber:(NSString*)str into:(int*)number {
	MARK;
	BOOL result = NO;
	
	if (!str) return NO;
	
	NSArray* tokens = [SysTools splitInTokens:str separator:[NSCharacterSet whitespaceCharacterSet]];
#define DEBUG_VERBOSE (1)
#if DEBUG_VERBOSE==1
	NSLog (@"We have %i token(s): \n%@",(int)[tokens count],[tokens description]);
#endif
	
#undef DEBUG_VERBOSE
	
	if ([tokens count] == 0) return NO;
	
	NSString* tok = [tokens objectAtIndex:0];	
	result = ([tokens count] == 1)? ([SysTools isTokenIntNumber:tok]) : NO;
	
	if (result && (NULL != number)) (*number) = [tok intValue];
	
	return result;
}

+(NSArray*) splitInTokens:(NSString *)str separator:(NSCharacterSet*)div {
	
	MARK;
	
	//like componentsSeparatedByString: and componentsSeparatedByCharactersInSet: 
	//but it skips empty tokens and it treats consecutive divisor characters as a single one
	
	NSString* token;
	NSMutableArray* arrTokens = [NSMutableArray arrayWithCapacity:4];
	NSScanner* scan = [NSScanner scannerWithString:str];
	
	while (![scan isAtEnd]) {
		token = nil;
		[scan scanCharactersFromSet:div intoString:NULL]; //it scans past a block of divisor characters 
		
		if ([scan scanUpToCharactersFromSet:div intoString:&token]){
			[arrTokens addObject:token];
		}
	}
	
	return arrTokens;
}

+(void) testIsNumber {
	
	BOOL test = NO;
	NSString * kindValue;
	test = test;
	
	kindValue = nil;
	
#if TEST_FP_DIGITS==1	
	kindValue = @"FP";
	NSString *	str = [NSString stringWithString:@""];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = nil;
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (test, @"(!) Error, it is a number %@", kindValue);
	
	str = [NSString stringWithString:@"\"245\""];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245.0"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"\""];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"s"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@" s"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"  s"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	///////////////////////////
	str = [NSString stringWithString:@" "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	///////////////////////////
	
	str = [NSString stringWithString:@"  "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@" 245"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (test, @"(!) Error, it is a number %@", kindValue);
	
	str = [NSString stringWithString:@" 245 2 s"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@" 245s"];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245s"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245 s"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245.0 2.0"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245.0 2.0 4.0"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@" 245.0 2.0 4.0 5.0 "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245.0 "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (test, @"(!) Error, it is a number %@", kindValue);
	
	str = [NSString stringWithString:@"245.0         "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (test, @"(!) Error, it is a number %@", kindValue);
	
	str = [NSString stringWithString:@" 245.0 "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (test, @"(!) Error, it is a number %@", kindValue);
	
	str = [NSString stringWithString:@"245 2"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@" 245 2"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@" 245 2 "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@" 245 2 4"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245 2 4"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245 2 4 "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245.0"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (test, @"(!) Error, it is a number %@", kindValue);
#endif
	
	
#ifndef TEST_INT_DIGITS
	//NSLog(@"TEST_INT_DIGITS = %i", (int)TEST_INT_DIGITS);
	NSAssert (NO, @"This TEST_INT_DIGITS define should be set");
#else 
	NSLog(@"TEST_INT_DIGITS = %i", (int)TEST_INT_DIGITS);
#endif
	
	
	
#if TEST_INT_DIGITS==1
	kindValue = @"INT";
	NSString *	str = [NSString stringWithString:@""];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = nil;
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"      20 "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (test, @"(!) Error, it is a number %@", kindValue);
	
	str = [NSString stringWithString:@"      -20 "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (test, @"(!) Error, it is a number %@", kindValue);
	
	str = [NSString stringWithString:@"      20"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (test, @"(!) Error, it is a number %@", kindValue);
	
	str = [NSString stringWithString:@"      20  2"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"      -20  2"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"      - 20"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@" - 20 "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"- 20"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"- 20 "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@" - 20"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (test, @"(!) Error, it is a number %@", kindValue);
	
	str = [NSString stringWithString:@"-245"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (test, @"(!) Error, it is a number %@", kindValue);
	
	str = [NSString stringWithString:@"\"245\""];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"\"-245\""];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245.0"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"\""];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"s"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@" s"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"  s"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	///////////////////////////
	str = [NSString stringWithString:@" "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	///////////////////////////
	
	str = [NSString stringWithString:@"  "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@" 245"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (test, @"(!) Error, it is a number %@", kindValue);
	
	str = [NSString stringWithString:@" 245 2 s"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@" 245s"];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245s"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245 s"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245 2"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245 2 4"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@" 245 2 4 5 "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245 "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (test, @"(!) Error, it is a number %@", kindValue);
	
	str = [NSString stringWithString:@"245         "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (test, @"(!) Error, it is a number %@", kindValue);
	
	str = [NSString stringWithString:@" 245 "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (test, @"(!) Error, it is a number %@", kindValue);
	
	str = [NSString stringWithString:@"245 2"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@" 245 2"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@" 245 2 "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@" 245 2 4"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245 2 4"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245 2 4 "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245 -2 -4 "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"-245 2 4 "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"-2 4"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"2 -4 "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"-2   -4 "];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"-2 -4"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@" -2 -4"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (!test, @"(!) Error, it is not a number %@", kindValue);
	
	str = [NSString stringWithString:@"245"];
	test=[SysTools isIntNumber:str into:NULL];
	NSLog(@"test number in str \"%@\" is a number? %@", str ,(test)?@"YES":@"NO");
	NSAssert (test, @"(!) Error, it is a number %@", kindValue);
#endif
	
}

+(char const*) spellDigitsUTF8:(id)number {
	
	NSMutableString* str = nil;
	
	if ([number class] == [NSString class]) {
		if ([SysTools isIntNumber:(NSString*)number into:NULL]) {
			return [str UTF8String];
		}
	}	
	else if ([number class] == [NSNumber class]) {
		
		str = [NSString stringWithFormat:@"%i",[(NSNumber*)number intValue]];
		return [str UTF8String];
	}
	
	return NULL;	
}

+(void) printDigitsInUTF8CString:(char const*)str reverseOrder:(BOOL)reverse {
	
	if (!str[0]) return;
	
	LOCAL_AR_POOL_ALLOC();
	int indexString = 0;
	while ('\0' != str[indexString]) {
		indexString++;
	}
	int i = reverse? (indexString) : 0;
	int stopIndex = reverse? 0 : (indexString);
	
#if DEBUG==1
	NSLog(@"(Start Index) i = %i, (Stop Index) stopIndex = %i", i, stopIndex);
	NSLog(@"Printing src digits in %@ order", reverse?@"reverse":@"normal");
#endif
	
	while( reverse? (i>=stopIndex) : (i<=stopIndex) ) {
		switch (str[i]) {
			case '0':
				printf("Zero\n");
				break;
			case '1':
				printf("One\n");
				break;
			case '2':
				printf("Two\n");
				break;
			case '3':
				printf("Three\n");
				break;
			case '4':
				printf("Four\n");
				break;
			case '5':
				printf("Five\n");
				break;
			case '6':
				printf("Six\n");
				break;
			case '7':
				printf("Seven\n");
				break;
			case '8':
				printf("Eight\n");
				break;
			case '9':
				printf("Nine\n");
				break;
			default:
				CMLog(@"(!) index = %i, str[i] = %c", i ,str[i]);
				break;
		}
		i = reverse? (i-1) : (i+1);//potentially very branchy... using two functions would be better
		//print_normal and print_reverse
	}
	printf("\n");
	LOCAL_AR_POOL_DRAIN();
}

+(BOOL) readLineUTF8:(char *)output size:(int)nbytes {
	fgets(output, nbytes, stdin);
	
	int i = 0;
	for ( i = 0; output[i] != '\n'; i++);
	output[i] = '\0';
	
	return YES;
}

@end
