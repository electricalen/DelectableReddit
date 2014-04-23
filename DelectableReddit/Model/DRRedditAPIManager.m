//
//  DRRedditAPIManager.m
//  DelectableReddit
//
//  Created by dsawyer on 4/15/14.
//  Copyright (c) 2014 demo. All rights reserved.
//

#import "DRRedditAPIManager.h"
#import "AFNetworking.h"
#import "DRConstants.h"
#import "DRJSONHelper.h"
#import "DRRedditListingItem.h"
#import "DRRedditListing.h"

@implementation DRRedditAPIManager

- (void)downloadFrontPage:(NSString *)after {
    NSString *url = DRURLRedditAPIHomePage;

    if (after) {
        url = [NSString stringWithFormat:@"%@?after=%@", DRURLRedditAPIHomePage, after];
        NSLog(@"Getting reddit listing after: %@", after);
    }

    NSLog(@"Get reddit listing URL: %@", url);

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager   GET:url
        parameters:nil
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               DRRedditListing *redditListing = nil;

               if ([DRJSONHelper isDictionary:responseObject] &&
               [DRJSONHelper isDictionary:[responseObject objectForKey:@"data"]]) {
               NSDictionary *data = [responseObject objectForKey:@"data"];
               redditListing = [[DRRedditListing alloc] initWithJSONObject:data];
               }

               if (self.delegate) {
               [self.delegate
                redditCallComplete:YES
                        withObject:redditListing];
               }
           }

           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               NSLog(@"Error: %@", error);
           }];
}

@end
