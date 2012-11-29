//
//  DetailViewController.m
//  GoogleChallenge
//
//  Created by Bili on 26.10.12.
//  Copyright (c) 2012 Vladimir Gogunsky. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPlaceName:nil];
    [self setPlaceAdress:nil];
    [self setEventsTableView:nil];
    [super viewDidUnload];
}
@end
