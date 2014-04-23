//
//  DRRedditListingItem.m
//  DelectableReddit
//
//  Created by dsawyer on 4/16/14.
//  Copyright (c) 2014 demo. All rights reserved.
//

#import "DRRedditListingItem.h"
#import "DRJSONHelper.h"

@implementation DRRedditListingItem

- (id)initWithJSONObject:(id)JSONObject {
    if (!JSONObject || ![JSONObject isKindOfClass:[NSDictionary class]]) {
        return nil;
    }

    self = [super init];
    DRRedditListingItem *listingItem = self;

    NSDictionary *stringMappings = @{
        @"title": @"title",
        @"domain": @"domain",
        @"subreddit": @"subreddit",
        @"author": @"author",
        @"thumbnail": @"thumbnail",
        @"url": @"url",
        @"selftext": @"selftext",
        @"selftext_html": @"selftextHTML"
    };

    [DRJSONHelper mapStringsToObject:self withDict:JSONObject withJSONToObjectMapping:stringMappings];

    NSDictionary *numberMappings = @{
        @"clicked": @"clicked",
        @"over_18": @"nsfw",
        @"ups": @"upvotes",
        @"downs": @"downvotes",
        @"score": @"score",
        @"created": @"created",
        @"num_comments": @"commentCount",
        @"is_self": @"isSelfPost"
    };

    [DRJSONHelper mapNumbersToObject:self withDict:JSONObject withJSONToObjectMapping:numberMappings];

    if (!listingItem.isSelfPost) {
        return nil;
    }

    //Skip if this is a self post but no self text
    if ([listingItem.isSelfPost boolValue] && !listingItem.selftext) {
        return nil;
    }

    return self;
}

@end
