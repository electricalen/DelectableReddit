//
//  DRRedditListingItem.h
//  DelectableReddit
//
//  Created by dsawyer on 4/16/14.
//  Copyright (c) 2014 demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRRedditListingItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *domain;
@property (nonatomic, strong) NSString *subreddit;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *selftext;
@property (nonatomic, strong) NSString *selftextHTML;

@property (nonatomic, assign) NSNumber *clicked;
@property (nonatomic, assign) NSNumber *nsfw;
@property (nonatomic, assign) NSNumber *upvotes;
@property (nonatomic, assign) NSNumber *downvotes;
@property (nonatomic, assign) NSNumber *score;
@property (nonatomic, assign) NSNumber *created;
@property (nonatomic, assign) NSNumber *commentCount;
@property (nonatomic, assign) NSNumber *isSelfPost;

- (id)initWithJSONObject:(id)JSONObject;

@end
