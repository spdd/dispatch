//
//  ViewController.m
//  ios
//
//  Created by Max on 05.07.13.
//  Copyright (c) 2013 Max Lunin. All rights reserved.
//

#import "ViewController.h"

#import "dispatch.h"

#import <string>
#import <iostream>

@implementation ViewController

- (IBAction)onRunButtonClick:(id)sender
{
    for (int i = 0; i < 20; ++i)
    {
        dispatch::async(dispatch::get_queue_with_priority(dispatch::QUEUE_PRIORITY::HIGH), [=]()
        {
            NSAssert(![NSThread isMainThread], nil);
            
            std::string first_string = std::to_string(i);
            
            dispatch::async(dispatch::get_main_queue(), [=]
            {
                NSAssert([NSThread isMainThread], nil);
                
                std::string second_string = std::to_string(i+1);
                
                std::cout << first_string << " -> " << second_string << std::endl;
                
                [self.tableView reloadData];
            });
        });
    }
}

@end
