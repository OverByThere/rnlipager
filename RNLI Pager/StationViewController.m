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
    [launchOutput setText:[NSString stringWithFormat:@"%@",ourDict]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
