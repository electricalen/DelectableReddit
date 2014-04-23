//
//  DRPostContentViewController.h
//  DelectableReddit
//
//  Created by dsawyer on 4/21/14.
//  Copyright (c) 2014 demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRPostContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) NSURL *contentURL;
@property (strong, nonatomic) NSString *selfText;

@end
