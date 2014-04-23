//
//  DRViewController.m
//  DelectableReddit
//
//  Created by dsawyer on 4/15/14.
//  Copyright (c) 2014 demo. All rights reserved.
//

#import "DRViewController.h"
#import "DRRedditAPIManager.h"
#import "DRListingCell.h"
#import "DRRedditListingItem.h"
#import "DRConstants.h"
#import "DRRedditListing.h"
#import "DRPostContentViewController.h"

@interface DRViewController () <UITableViewDataSource, UITableViewDelegate, DRRedditAPIManagerDelegate>

@property (nonatomic, strong) DRRedditAPIManager *redditAPIManager;
@property (nonatomic, strong) NSMutableArray *listingItems;
@property (nonatomic, strong) DRRedditListing *redditListing;
@property (nonatomic, assign) BOOL shouldRefresh;

@end

@implementation DRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //Fix issue with white space at the top of the view
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.redditAPIManager = [[DRRedditAPIManager alloc] init];
    self.redditAPIManager.delegate = self;
    [self.redditAPIManager downloadFrontPage:nil];
    self.listingItems = [NSMutableArray array];
    self.loadingView.hidden = NO;
    self.shouldRefresh = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Methods

- (void)setPageLoading:(BOOL)isLoading {
}

#pragma mark - API Methods

- (void)redditCallComplete:(BOOL)success withObject:(id)obj {
    if (self.shouldRefresh) {
        [self.listingItems removeAllObjects];
        self.shouldRefresh = NO;
    }

    if (obj && [obj isKindOfClass:[DRRedditListing class]]) {
        self.redditListing = (DRRedditListing *)obj;

        [self.listingItems addObjectsFromArray:self.redditListing.listingItems];

        [self.tableView reloadData];
        self.loadingView.hidden = YES;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.listingItems count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return DRListingCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DRListingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListingCell" forIndexPath:indexPath];

    DRRedditListingItem *listingItem = [self.listingItems objectAtIndex:indexPath.row];

    cell.titleLabel.text = listingItem.title;

    if (listingItem.thumbnail && [listingItem.thumbnail length] > 0) {
        [cell updateImageURL:[NSURL URLWithString:listingItem.thumbnail]];
    } else {
        [cell updateImageURL:nil];
    }

    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //The last row is about to be shown
    if (indexPath.row == [self.listingItems count] - 1) {
        if (!self.loadingView.hidden) {
            return;
        }

        self.shouldRefresh = NO;
        self.loadingView.hidden = NO;

        if (self.redditListing.after && [self.redditListing.after length] > 0) {
            [self.redditAPIManager downloadFrontPage:self.redditListing.after];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    DRRedditListingItem *listingItem = [self.listingItems objectAtIndex:indexPath.row];

    [self performSegueWithIdentifier:@"GotoContentView" sender:listingItem];
}

#pragma mark - Segue


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GotoContentView"]) {
        DRRedditListingItem *listingItem = (DRRedditListingItem *)sender;

        DRPostContentViewController *contentViewController = (DRPostContentViewController *)segue.destinationViewController;

        if ([listingItem.isSelfPost boolValue]) {
            contentViewController.selfText = listingItem.selftext;
            contentViewController.contentURL = nil;
        } else {
            contentViewController.selfText = nil;
            contentViewController.contentURL = [NSURL URLWithString:listingItem.url];
        }
    }
}

- (IBAction)refresh:(id)sender {
    if (!self.loadingView.hidden) {
        return;
    }

    self.shouldRefresh = YES;
    self.loadingView.hidden = NO;

    [self.redditAPIManager downloadFrontPage:nil];
}

@end
