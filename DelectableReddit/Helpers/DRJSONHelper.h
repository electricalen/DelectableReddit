//
//  DRJSONHelper.h
//  DelectableReddit
//
//  Created by dsawyer on 4/19/14.
//  Copyright (c) 2014 demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRJSONHelper : NSObject

+ (BOOL)isDictionary:(id)object;
+ (BOOL)isArray:(id)object;

+ (BOOL)boolForKey:(NSString *)key withDict:(NSDictionary *)dict;

//Use key-value coding to fill in class properties with JSON data
+ (BOOL)mapStringsToObject:(NSObject *)object withDict:(NSDictionary *)dict withJSONToObjectMapping:(NSDictionary *)mapping;
+ (BOOL)mapNumbersToObject:(NSObject *)object withDict:(NSDictionary *)dict withJSONToObjectMapping:(NSDictionary *)mapping;


@end
