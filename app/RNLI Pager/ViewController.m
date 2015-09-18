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
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [updateTime setTitle:@"Loading..."];
    [updateTime setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
}

-(void)lazyInternetDidLoad:(NSData *)data withUnique:(id)unique {
    NSError *error;
    dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if(!dict) { NSLog(@"%@",error); }
    NSLog(@"We got data.");
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    if ([paths count] > 0) {
        // http://iosdevelopertips.com/data-file-management/read-and-write-nsarray-nsdictionary-and-nsset-to-a-file.html
        NSString *dictPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"dict.out"];
        [dict writeToFile:dictPath atomically:YES];
        
        NSURL *fileUrl = [NSURL fileURLWithPath:dictPath];
        NSDate *fileDate;
        [fileUrl getResourceValue:&fileDate forKey:NSURLContentModificationDateKey error:&error];
        NSString *dateString = [NSDateFormatter localizedStringFromDate:fileDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
        if (error) { NSLog(@"%@",error); }
        else { [updateTime setTitle:[NSString stringWithFormat:@"Last updated %@",dateString]]; }
    }
    [tableView reloadData];
}

-(IBAction)refreshData:(id)sender {
    [getList startDownload:@"https://overbythere.co.uk/apps/rnli/list.php" withDelegate:self withUnique:@"fulllist"];
}


-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(dict) { return [[[dict objectForKey:@"launches"] allKeys] count]; }
    return 1;
}

-(UITableViewCell *)tableView:(nonnull UITableView *)tv cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RNLILaunch"];
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
