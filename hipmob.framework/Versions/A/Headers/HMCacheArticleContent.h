//
//  HMCacheArticleContent.m
//  hipmob
//
//  Created by Olufemi Omojola on 04/04/2014.
//  Copyright (c) 2013-2015 Orthogonal Labs, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMFetchContent : NSObject
-(id)initWithURL:(NSString *)url forCacheFile:(NSString *)path;
@end

@interface HMCacheArticleContent : NSObject
+(NSArray *)persistArticle:(NSDictionary *)details forApp:(NSString *)app inFolder:(NSString *)cacheFolder withResourceURL:(NSString *)resourceURL;

+(void)retrieveResource:(NSString *)url withBaseURL:(NSString *)baseURL forArticle:(NSString *)article andApp:(NSString *)app inFolder:(NSString *)appCacheFolder;

+(void)updateArticle:(NSString *)articleid withSource:(NSDictionary *)source forApp:(NSString *)app withResourceURL:(NSString *)resourceURL;

+(void)cacheContent:(NSString *)content forApp:(NSString *)app inFolder:(NSString *)appCacheFolder withName:(NSString *)name;

+(void)flushCacheContentForApp:(NSString *)app inFolder:(NSString *)appCacheFolder withName:(NSString *)name;
@end
