//
//  WeatherApi.m
//  http_sample
//
//  Created by kumano shuta on 2015/04/02.
//  Copyright (c) 2015年 shoota. All rights reserved.
//

#import "WeatherApi.h"

@interface WeatherApi()

@property(strong,nonatomic) NSMutableData *response;

@end



@implementation WeatherApi

- (instancetype)init {
    self.response = [NSMutableData data];
    return self;
}

// レスポンスを受け取った時。
// レスポンスbodyではなく、レスポンスheaderを取得したときのdelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"response : %@",response);
    [self.response setLength:0];
}

// レスポンスデータが到達したとき。
// レスポンスパケットを受け取ったときと考えてよい
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.response appendData:data];
    NSLog(@"data : %@", self.response);
}

// レスポンスがすべて到達したとき
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *jsonString  = [[NSString alloc] initWithData:self.response encoding:NSUTF8StringEncoding];
    NSLog(@"json %@", jsonString);
    NSDictionary *dic = [NSDictionary dictionaryWithObject:jsonString forKey:@"response"];
    NSNotification *n  =[NSNotification notificationWithName:@"responseWeather" object:self userInfo:dic];
    [[NSNotificationCenter defaultCenter] postNotification: n];
}

@end
