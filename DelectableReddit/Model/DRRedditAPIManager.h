//
//  DRRedditAPIManager.h
//  DelectableReddit
//
//  Created by dsawyer on 4/15/14.
//  Copyright (c) 2014 demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DRRedditAPIManagerDelegate

- (void)redditCallComplete:(BOOL)success withObject:(id)obj;

@end

@interface DRRedditAPIManager : NSObject

@property (nonatomic, weak) id <DRRedditAPIManagerDelegate> delegate;

- (void)downloadFrontPage:(NSString *)after;

@end
