//
//  DRRedditListing.m
//  DelectableReddit
//
//  Created by dsawyer on 4/16/14.
//  Copyright (c) 2014 demo. All rights reserved.
//

#import "DRRedditListing.h"
#import "DRJSONHelper.h"
#import "DRRedditListingItem.h"

@implementation DRRedditListing

- (id)initWithJSONObject:(id)JSONObject {
    self.listingItems = [NSMutableArray array];

    if (!JSONObject || ![JSONObject isKindOfClass:[NSDictionary class]]) {
        return nil;
    }

    self = [super init];

    NSDictionary *stringMappings = @{
        @"after": @"after",
        @"before": @"before"
    };

    [DRJSONHelper mapStringsToObject:self withDict:JSONObject withJSONToObjectMapping:stringMappings];

    if ([DRJSONHelper isArray:[JSONObject objectForKey:@"children"]]) {
        NSArray *children = [JSONObject objectForKey:@"children"];

        for (id childRef in children) {
            if ([DRJSONHelper isDictionary:childRef]) {
                NSDictionary *child = (NSDictionary *)childRef;

                if ([DRJSONHelper isDictionary:[child objectForKey:@"data"]]) {
                    NSDictionary *listingObject = [child objectForKey:@"data"];
                    DRRedditListingItem *listingItem = [[DRRedditListingItem alloc] initWithJSONObject:listingObject];

                    if (listingItem) {
                        [self.listingItems addObject:listingItem];
                    }
                }
            }
        }
    }

    return self;
}

@end
