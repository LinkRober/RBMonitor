//
//  XYViewController.m
//  Walle
//
//  Created by lbrsilva-allin on 07/04/2017.
//  Copyright (c) 2017 lbrsilva-allin. All rights reserved.
//

#import "XYViewController.h"
#import "AFNetworking.h"
static NSMutableArray<Class> *URLProtocols;

@interface XYViewController ()
@property (nonatomic, strong) AFHTTPSessionManager *afSessionManager;
@end

@implementation XYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    NSURLSessionTask *task = [self.afSessionManager GET:@"http://localhost:8081"
//                                             parameters:nil
//                                               progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                                   NSLog(@"%@",responseObject);
//                                               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                                                   NSLog(@"%@",error);
//                                               }];
    
    NSURLSessionTask *task = [self.afSessionManager POST:@"http://localhost:8081"
                                              parameters:nil progress:nil
                                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                     //
                                                     NSLog(@"%@",responseObject);
                                                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                     //
                                                     NSLog(@"%@",error);
                                                 }];
    

}

- (AFHTTPSessionManager *)afSessionManager {
    if(nil == _afSessionManager) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.protocolClasses = URLProtocols;
        _afSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil sessionConfiguration:config];
        _afSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _afSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain", nil];
        [_afSessionManager.requestSerializer setValue:@"Basic vivasam=4aef31355d971066272917f8e12465e6" forHTTPHeaderField:@"Authorization"];
        [_afSessionManager.requestSerializer setValue:[self headerCookie] forHTTPHeaderField:@"Cookie"];
        [_afSessionManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        [_afSessionManager.requestSerializer setTimeoutInterval:15];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        _afSessionManager.securityPolicy = securityPolicy;
        [_afSessionManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            if(status == AFNetworkReachabilityStatusNotReachable) {
                
            }
        }];
    }
    return _afSessionManager;
}

- (NSString *)headerCookie
{
    return @"";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
