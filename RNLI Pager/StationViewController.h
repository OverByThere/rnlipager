//
//  StationViewController.h
//  RNLI Pager
//
//  Created by Dan Clarke on 20/09/2015.
//  Copyright © 2015 OverByThere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LazyInternet/LazyInternet.h"

@interface StationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITextView *launchOutput;
    IBOutlet UILabel *stationTitle;
    IBOutlet UITableView *tableView;
    LazyInternet *getList;
    NSMutableDictionary *launchDict;
}

@property NSMutableDictionary *ourDict;

@end
