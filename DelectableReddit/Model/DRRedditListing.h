//
//  DRRedditListing.h
//  DelectableReddit
//
//  Created by dsawyer on 4/16/14.
//  Copyright (c) 2014 demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRRedditListing : NSObject

@property (nonatomic, strong) NSMutableArray *listingItems;

@property (nonatomic, strong) NSString *before;
@property (nonatomic, strong) NSString *after;

- (id)initWithJSONObject:(id)JSONObject;

@end
