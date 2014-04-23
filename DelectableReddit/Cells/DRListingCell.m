//
//  DRListingCell.m
//  DelectableReddit
//
//  Created by dsawyer on 4/19/14.
//  Copyright (c) 2014 demo. All rights reserved.
//

#import "DRListingCell.h"

@implementation DRListingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        // Initialization code
    }

    return self;
}

- (void)awakeFromNib {
    // Initialization code

    self.thumbnailView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.thumbnailView];

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textColor = [UIColor blueColor];
    self.titleLabel.font = [UIFont systemFontOfSize:12];

    [self.contentView addSubview:self.titleLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    self.thumbnailView.frame = CGRectMake(10, 10, 50, 50);

    self.contentView.frame = self.bounds;

    CGRect rect;
    rect.origin.y = 5;
    rect.size.height = 40;

    if (self.thumbnailView.image) {
        rect.origin.x = 70;
        rect.size.width = CGRectGetWidth(self.contentView.bounds) - 100;
    } else {
        rect.origin.x = 10;
        rect.size.width = CGRectGetWidth(self.contentView.bounds) - 70;
    }

    self.titleLabel.frame = rect;
}

- (void)updateImageURL:(NSURL *)url {
    if (!url) {
        self.thumbnailView.image = nil;
        [self setNeedsLayout];
        return;
    }

    //Load the thumbnail images in the background
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);

    dispatch_async(queue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];

        dispatch_sync(dispatch_get_main_queue(), ^{
                self.thumbnailView.image = image;
                [self setNeedsLayout];
            });
    });
}

@end
