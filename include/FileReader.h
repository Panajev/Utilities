//
//  FileReader.h
//  Utilities
//
//  Created by Goffredo Marocchi on 12/13/10.
//  Copyright 2010 IGGS. All rights reserved.
//

#import <Foundation/Foundation.h>

//http://stackoverflow.com/questions/3707427/how-to-read-data-from-nsfilehandle-line-by-line/3711079#3711079
/*
 //Sample:
 FileReader * reader = [[FileReader alloc] initWithFilePath:pathToMyFile];
 NSString * line = nil;
 while ((line = [reader readLine])) {
 NSLog(@"read line: %@", line);
 }
 [reader release];
 
 //Or (for 10.6+ and iOS 4+):
 FileReader * reader = [[FileReader alloc] initWithFilePath:pathToMyFile];
 [reader enumerateLinesUsingBlock:^(NSString * line, BOOL * stop) {
 NSLog(@"read line: %@", line);
 }];
 [reader release];
 */

@interface FileReader : NSObject {
    NSString * filePath;
	
    NSFileHandle * fileHandle;
    unsigned long long currentOffset;
    unsigned long long totalFileLength;
	
    NSString * lineDelimiter;
    NSUInteger chunkSize;
}

@property (nonatomic, copy) NSString * lineDelimiter;
@property (nonatomic) NSUInteger chunkSize;

- (id) initWithFilePath:(NSString *)aPath;

- (NSString *) readLine;
- (NSString *) readTrimmedLine;

#if NS_BLOCKS_AVAILABLE
- (void) enumerateLinesUsingBlock:(void(^)(NSString*, BOOL *))block;
#endif

@end