//
//  DetailViewController.h
//  GoogleChallenge
//
//  Created by Bili on 26.10.12.
//  Copyright (c) 2012 Vladimir Gogunsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *placeName;
@property (strong, nonatomic) IBOutlet UILabel *placeAdress;
@property (strong, nonatomic) IBOutlet UITableView *EventsTableView;

@end
