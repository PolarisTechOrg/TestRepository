//
//  main.m
//  FcpAssistant2
//
//  Created by admin on 9/9/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FAAppDelegate.h"
#import "FAHttpHead.h"
#import "FAJSONSerialization.h"
#import "FAStationLoginModelDto.h"
#import "FAHttpUtility.h"


int main(int argc, char * argv[])
{
    @autoreleasepool
    {
//        NSString *urlAsString = @"http://10.10.6.57/api/MyTest?uriId=1";
//        
//        NSURL *url = [NSURL URLWithString:urlAsString];
//        
//        NSError *err;
//        FAHttpHead *head = [[FAHttpHead alloc] initDefault];
//        head.Method = @"POST";
//        head.TimeOut = 30.0f;
//        FAStationLoginModelDto *body = [[FAStationLoginModelDto alloc] init];
//        body.Account = @"apple";
//        body.Password = @"12345678";
//        NSData *da = [FAHttpUtility sendRequest:url withHead:head httpBody:body error:err];
//        id tr = [FAJSONSerialization toObject:nil fromData:da];
//        
//        NSLog(@"%@", tr);

        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([FAAppDelegate class]));
    }
}
