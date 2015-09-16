//
//  ViewController.m
//  RNLI Pager
//
//  Created by Work on 03/09/2015.
//  Copyright © 2015 OverByThere. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    getList = [[LazyInternet alloc] init];
    [getList startDownload:@"https://overbythere.co.uk/apps/rnli/list.php" withDelegate:self withUnique:@"fulllist"];
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [[self view] addSubview:tableView];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
}

-(void)lazyInternetDidLoad:(NSData *)data withUnique:(id)unique {
    NSError *error;
    dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if(!dict) {
        NSLog(@"%@",error);
    }
    //NSLog(@"%@",dict);
    [tableView reloadData];
}


-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(dict) { return [[[dict objectForKey:@"launches"] allKeys] count]; }
    return 1;
}

-(UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"launchcell"];
    //[cell set]
    NSArray *allKeys = [[dict objectForKey:@"launches"] allKeys];
    NSMutableDictionary *ourData = [[dict objectForKey:@"launches"] objectForKey:[allKeys objectAtIndex:indexPath.row]];
    if(dict) {
        [[cell textLabel] setText:[ourData objectForKey:@"name"]];
        [[cell detailTextLabel] setText:[ourData objectForKey:@"nicetime"]];
    }
    else { [[cell textLabel] setText:@"Loading..."]; }
    return cell;
}

-(void)lazyInternetGotSize:(int)totalSize withUnique:(id)unique { }
-(void)lazyInternetDidFailWithError:(NSError *)error withUnique:(id)unique { NSLog(@"%@",error); }
-(void)lazyInternetProgress:(CGFloat)currentProgress withUnique:(id)unique { }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
