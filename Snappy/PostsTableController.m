//
//  PostsTableController.m
//  Snappy
//
//  Created by Pär Majholm on 11/09/16.
//  Copyright © 2016 Pär Majholm. All rights reserved.
//

#import "PostsTableController.h"
#import "CachedFetchOperation.h"
#import "PostTableViewCell.h"
#import "Post.h"
#import "UIColor+SnappyColors.h"
#import "PostController.h"
#import "FilterView.h"

@interface PostsTableController ()

@property (retain, nonatomic) NSArray<Post *> * posts;
@property (retain, nonatomic) NSArray<Post *> * filteredPosts;
@property (retain, nonatomic) FilterView * filterView;

@end

@implementation PostsTableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib * rowNib = [UINib nibWithNibName:@"PostTableViewCell" bundle:nil];
    [self.tableView registerNib:rowNib forCellReuseIdentifier:@"row"];
    
    // use self-sizing cells
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 300;
    
    self.tableView.backgroundColor = [UIColor snappyBackgroundColor];
    self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    
//    FilterView * filterView = [FilterView instanceFromNib];
//    filterView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.tableView addSubview:filterView];
//    NSDictionary * views = @{ @"filter": filterView, @"super": self.tableView };
//    [self.tableView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[filter(==super)]" options:0 metrics:nil views:views]];
//    [self.tableView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-80)-[filter]" options:0 metrics:nil views:views]];
//    self.filterView = filterView;
    
    [self.refreshControl addTarget:self action:@selector(refreshPosts) forControlEvents:UIControlEventValueChanged];

    [self refreshPosts];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filteredPosts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"row" forIndexPath:indexPath];
    Post * postForRow = self.posts[indexPath.row];
    cell.name.text = postForRow.name;
    
    NSMutableString * tagsString = [NSMutableString string];
    for (NSString * tag in postForRow.tags)
    {
        NSString * formattedTag = [NSString stringWithFormat:@"#%@ ", tag.lowercaseString];
        [tagsString appendString:formattedTag];
    }
    cell.tags.text = tagsString;
    
    cell.imageView.image = nil;
    [cell.activityIndicator startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *urlString = postForRow.url;
        CachedFetchOperation * fetchOperation = [[[CachedFetchOperation alloc] initWithURLString:urlString] autorelease];
        [fetchOperation main];
        UIImage * image = [UIImage imageWithData:fetchOperation.data];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.photoImageView.image = image;
            [cell.activityIndicator stopAnimating];
        });
    });
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostController * postController = [self.storyboard instantiateViewControllerWithIdentifier:@"PostController"];
    Post * selectedPost = self.filteredPosts[indexPath.row];
    postController.post = selectedPost;
    [self showViewController:postController sender:self];
}

#pragma mark - private methods

- (void)refreshPosts
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *urlString = @"https://static.mobileinteraction.se/developertest/wordpressphotoawards.json";
        FetchOperation * fetchOperation = [[[FetchOperation alloc] initWithURLString:urlString] autorelease];
        [fetchOperation main];
        NSDictionary * jsonObject = [NSJSONSerialization JSONObjectWithData:fetchOperation.data options:0 error:nil];
        
        NSMutableArray<Post *> * posts = [NSMutableArray array];
        for (NSDictionary *postJsonObject in jsonObject[@"files"])
        {
            Post * post = [[[Post alloc] initWithJSONObject:postJsonObject] autorelease];
            [posts addObject:post];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.posts = posts;
            [self.refreshControl endRefreshing];
            [self filterPosts];
        });
    });
}

- (void)filterPosts
{
    self.filteredPosts = [self.posts copy];
    [self.tableView reloadData];
}

@end
