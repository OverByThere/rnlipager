//
//  StationViewController.m
//  RNLI Pager
//
//  Created by Dan Clarke on 20/09/2015.
//  Copyright © 2015 OverByThere. All rights reserved.
//

#import "StationViewController.h"

@interface StationViewController ()

@end

@implementation StationViewController

@synthesize ourDict;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",ourDict);
    [[[self navigationController] navigationBar] setTranslucent:FALSE]; //http://stackoverflow.com/a/22473381
    getList = [[LazyInternet alloc] init];
    [launchOutput setText:[NSString stringWithFormat:@"%@",ourDict]];
    [stationTitle setText:[NSString stringWithFormat:@"%@",[ourDict objectForKey:@"name"]]];
    // Do any additional setup after loading the view.
    
}

-(IBAction)getLaunches:(id)sender {
    [getList startDownload:@"https://overbythere.co.uk/apps/rnli/list.php" withDelegate:self withUnique:@"fulllist"];
    //[updateTime setTitle:@"Loading..."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)lazyInternetDidLoad:(NSData *)data withUnique:(id)unique {
    NSError *error;
    launchDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if(!launchDict) { NSLog(@"%@",error); }
    NSLog(@"We got data.");
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    if ([paths count] > 0) {
        // http://iosdevelopertips.com/data-file-management/read-and-write-nsarray-nsdictionary-and-nsset-to-a-file.html
        NSString *dictPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"dict.out"];
        [launchDict writeToFile:dictPath atomically:YES];
    }
    [tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(launchDict) { return [[launchDict allKeys] count]; }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RNLILaunch"];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO selector:@selector(caseInsensitiveCompare:)];
    NSArray *sectKeys = [[[launchDict objectForKey:@"launches"] allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    NSMutableDictionary *sectData = [[launchDict objectForKey:@"launches"] objectForKey:[sectKeys objectAtIndex:indexPath.section]];
    
    NSArray *cellKeys = [[sectData allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    NSMutableDictionary *cellData = [sectData objectForKey:[cellKeys objectAtIndex:indexPath.row]];
    
    if(launchDict) {
        [[cell textLabel] setText:[NSString stringWithFormat:@"%@ - %@",[cellData objectForKey:@"name"],[cellData objectForKey:@"time"]]];
        [[cell detailTextLabel] setText:[cellData objectForKey:@"date"]];
        //[cell setValue:cellData forKey:@"ourData"];
    }
    else { [[cell textLabel] setText:@"Loading..."]; }
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
