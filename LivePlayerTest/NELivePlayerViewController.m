//
//  NELivePlayerViewController.m
//  LivePlayerTest
//
//  Created by zhouhan on 2017/9/29.
//  Copyright © 2017年 zhouhan. All rights reserved.
//

#import "NELivePlayerViewController.h"

@interface NELivePlayerViewController ()

@end

@implementation NELivePlayerViewController

CGFloat screenWidth;
CGFloat screenHeight;

-(instancetype)initWithURL:(NSURL*)url andDecodeParam:(NSMutableArray*)decodeParam{
    self=[self initWithName:@"NELivePlayerViewController" bundle:nil];
    if (self) {
        self.url=url;
        self.decodeType=[decodeParam objectAtIndex:0];
        self.mediaType=[decodeParam objectAtIndex:1];
    }
    return  self;
}

-(instancetype)initWithName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view=[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    screenWidth=CGRectGetWidth([[UIScreen mainScreen] bounds]);
    screenHeight=CGRectGetHeight([[UIScreen mainScreen] bounds]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
