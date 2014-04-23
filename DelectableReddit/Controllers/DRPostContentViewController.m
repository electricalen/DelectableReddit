//
//  DRPostContentViewController.m
//  DelectableReddit
//
//  Created by dsawyer on 4/21/14.
//  Copyright (c) 2014 demo. All rights reserved.
//

#import "DRPostContentViewController.h"

@interface DRPostContentViewController ()

@end

@implementation DRPostContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        // Custom initialization
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //Fix issue with white space at the top of the view
    self.automaticallyAdjustsScrollViewInsets = NO;

    if (self.selfText && [self.selfText length] > 0) {
        //This is a self text post, display text instead of web content
        self.webView.hidden = YES;
        self.textView.hidden = NO;
        self.textView.text = self.selfText;
    } else if (self.contentURL) {
        //Display web content
        self.webView.hidden = NO;
        self.textView.hidden = YES;

        [self.webView loadRequest:[NSURLRequest requestWithURL:self.contentURL]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
