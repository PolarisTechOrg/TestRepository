//
//  main.m
//  FcpAssistant2
//
//  Created by admin on 9/9/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FAAppDelegate.h"
#import "FAPaginatedDto.h"
#import "FAWinLossViewModel.h"
#import "FADummieStrategyDetailViewModel.h"
#import "FAJSONSerialization.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        
        NSString *urlAsString = @"http://testweb.polaristech.com.cn:8080/FCWRestHost/api";
        urlAsString = [urlAsString stringByAppendingString:@"/strategy"];
        urlAsString = [urlAsString stringByAppendingString:@"?strategyName="];
        urlAsString = [urlAsString stringByAppendingString:@"&racerType=1"];
        urlAsString = [urlAsString stringByAppendingString:@"&onlineStatus=1"];
        urlAsString = [urlAsString stringByAppendingString:@"&isOpen="];
        urlAsString = [urlAsString stringByAppendingString:@"&tradingDirection="];
        urlAsString = [urlAsString stringByAppendingString:@"&transactionFrequency="];
        urlAsString = [urlAsString stringByAppendingString:@"&tradeType="];
        urlAsString = [urlAsString stringByAppendingString:@"&winningProbability="];
        urlAsString = [urlAsString stringByAppendingString:@"&pageSize=10"];
        urlAsString = [urlAsString stringByAppendingString:@"&pageIndex=1"];
        NSLog(@"urlAsString = %@", urlAsString);
        
        NSURL *url = [NSURL URLWithString:urlAsString];
        
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
        [urlRequest setTimeoutInterval:30.0f];
        [urlRequest setHTTPMethod:@"GET"];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        [NSURLConnection
         sendAsynchronousRequest:urlRequest
         queue:queue
         completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
             if([data length]>0 && connectionError == nil){
                 //NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                 //NSLog(@"HTML = %@", html);
                 
                 /*Class pageClass = NSClassFromString(@"FAPaginatedDto");
                 Class itemClass = NSClassFromString(@"FADummieStrategyDetailViewMode");
                 id pageInfo = [FAJSONSerialization toObject:pageClass itemOfClass:itemClass fromData:data];
                 NSLog(@"pageInfo = %@", pageInfo);
                 
                 NSError *error = nil;
                 //id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                 //NSLog(@"JSON = %@", jsonObject);
                 
                 NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                 int next = [[json objectForKey:@"HasNextPage"] shortValue];
                 
                 NSLog(@"ArrayJSON.HasNextPage = %i", next);
                 NSLog(@"ArrayJSON = %@", json);*/
                 
                 FAPaginatedDto *page = [[FAPaginatedDto alloc] init];
                 page = [FAJSONSerialization toObject:@"FAPaginatedDto" fromData:data];
                 
                 page.Items = [FAJSONSerialization toArray:@"FADummieStrategyDetailViewModel" fromData:page.Items];
                 
                 FADummieStrategyDetailViewModel *mode = [[FADummieStrategyDetailViewModel alloc] init];
                 mode = page.Items[0];
                 mode.WinLosses = [FAJSONSerialization toArray:@"FAWinLossViewModel" fromData:mode.WinLosses];
                 
                 
                 NSLog(@"end.");                 
             }
             else if(connectionError != nil){
                 NSLog(@"Error hanppend = %@", connectionError);
             }
         }];
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([FAAppDelegate class]));
    }
}
