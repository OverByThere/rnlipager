//
//  ViewController.h
//  RNLI Pager
//
//  Created by Work on 03/09/2015.
//  Copyright © 2015 OverByThere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LazyInternet/LazyInternet.h"

@interface ViewController : UIViewController <LazyInternetDelegate, UITableViewDataSource, UITableViewDelegate> {
    LazyInternet *getList;
    UITableView *tableView;
    NSMutableDictionary *dict;
}


@end

