//
//  DRViewController.h
//  DelectableReddit
//
//  Created by dsawyer on 4/15/14.
//  Copyright (c) 2014 demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
- (IBAction)refresh:(id)sender;

@end
