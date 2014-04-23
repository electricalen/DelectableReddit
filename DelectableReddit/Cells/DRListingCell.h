//
//  DRListingCell.h
//  DelectableReddit
//
//  Created by dsawyer on 4/19/14.
//  Copyright (c) 2014 demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRListingCell : UITableViewCell
@property (strong, nonatomic) UIImageView *thumbnailView;
@property (strong, nonatomic) UILabel *titleLabel;

- (void)updateImageURL:(NSURL *)url;

@end
