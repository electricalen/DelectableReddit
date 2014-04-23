//
//  DRJSONHelper.m
//  DelectableReddit
//
//  Created by dsawyer on 4/19/14.
//  Copyright (c) 2014 demo. All rights reserved.
//

#import "DRJSONHelper.h"

@implementation DRJSONHelper

+ (BOOL)isDictionary:(id)object {
    return object && [object isKindOfClass:[NSDictionary class]];
}

+ (BOOL)isArray:(id)object {
    return object && [object isKindOfClass:[NSArray class]];
}

+ (BOOL)boolForKey:(NSString *)key withDict:(NSDictionary *)dict;
{
    id obj = [dict objectForKey:key];

    if (obj && [obj isKindOfClass:[NSNumber class]]) {
        NSNumber *num = (NSNumber *)obj;
        return [num boolValue];
    } else {
        return false;
    }
}

+ (BOOL)mapStringsToObject:(NSObject *)object withDict:(NSDictionary *)dict withJSONToObjectMapping:(NSDictionary *)mapping {
    if (!object || !dict || !mapping) {
        return NO;
    }

    BOOL errorOccured = NO;

    for (NSString *mappedJSONName in [mapping allKeys]) {
        id valueRef = [dict objectForKey:mappedJSONName];

        if (valueRef && [valueRef isKindOfClass:[NSString class]]) {
            NSString *value = (NSString *)valueRef;
            [object setValue:value forKey:[mapping objectForKey:mappedJSONName]];
        } else {
            //Bad or missing JSON value
            errorOccured = YES;
        }
    }

    return errorOccured;
}

+ (BOOL)mapNumbersToObject:(NSObject *)object withDict:(NSDictionary *)dict withJSONToObjectMapping:(NSDictionary *)mapping {
    if (!object || !dict || !mapping) {
        return NO;
    }

    BOOL errorOccured = NO;

    if (!object || !dict || !mapping) {
        return NO;
    }

    for (NSString *mappedJSONName in [mapping allKeys]) {
        id valueRef = [dict objectForKey:mappedJSONName];

        if (valueRef && [valueRef isKindOfClass:[NSNumber class]]) {
            NSNumber *value = (NSNumber *)valueRef;
            [object setValue:value forKey:[mapping objectForKey:mappedJSONName]];
        } else {
            //Bad or missing JSON value
            errorOccured = YES;
        }
    }

    return errorOccured;
}

@end
