//
//  StationViewController.h
//  RNLI Pager
//
//  Created by Dan Clarke on 20/09/2015.
//  Copyright © 2015 OverByThere. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StationViewController : UIViewController {
    IBOutlet UITextView *launchOutput;
}

@property NSMutableDictionary *ourDict;

@end
