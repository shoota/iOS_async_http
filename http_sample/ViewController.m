//
//  ViewController.m
//  http_sample
//
//  Created by kumano shuta on 2015/04/02.
//  Copyright (c) 2015年 shoota. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *getButton;
@property (weak, nonatomic) IBOutlet UITextView *jsonview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.getButton addTarget:self action:@selector(getData) forControlEvents:UIControlEventTouchUpInside];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(responseCallBack:) name:@"responseWeather" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) responseCallBack:(NSNotification *) notification {
    NSLog(@"NSNotification call back");
    NSDictionary *responseData = [notification userInfo];
    NSString *jsonStr = [responseData objectForKey:@"response"];
    
    [self.jsonview setText:jsonStr];
}

- (void)getData {
    [self.jsonview setText:@""];
    NSString *urlSting = @"http://api.openweathermap.org/data/2.5/forecast?lat=40.566669&lon=141.483337";
    NSURL *url = [NSURL URLWithString:urlSting];
    
    WeatherApi *api = [[WeatherApi alloc] init];
    
    // send
    NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:url] delegate:api];
    
    if(!con) {
        NSLog(@"can not send");
    }

}

@end
