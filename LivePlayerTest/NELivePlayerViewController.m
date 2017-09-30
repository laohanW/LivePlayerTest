//
//  NELivePlayerViewController.m
//  LivePlayerTest
//
//  Created by zhouhan on 2017/9/29.
//  Copyright © 2017年 zhouhan. All rights reserved.
//

#import "NELivePlayerViewController.h"

@interface NELivePlayerViewController ()

@property   (strong,nonatomic) UIView* playerView;

@end

@implementation NELivePlayerViewController

CGFloat screenWidth;
CGFloat screenHeight;
BOOL isHardware;

-(instancetype)initWithURL:(NSURL*)url andDecodeParam:(NSMutableArray*)decodeParam{
    self=[self initWithNibName:@"NELivePlayerViewController" bundle:nil];
    if (self) {
        self.url=url;
        self.decodeType=[decodeParam objectAtIndex:0];
        self.mediaType=[decodeParam objectAtIndex:1];
    }
    return  self;
}

-(instancetype)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil{
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
    
    self.playerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screenHeight, screenWidth)];
    
    [NELivePlayerController setLogLevel:NELP_LOG_DEFAULT];
    self.liveplayer=[[NELivePlayerController alloc] initWithContentURL:self.url];
    if (self.liveplayer == nil) {
        NSLog(@"player initilize failed, please tay again!");
    }
    self.liveplayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth| UIViewAutoresizingFlexibleHeight;
    self.liveplayer.view.frame=self.playerView.bounds;
    self.view.autoresizingMask=YES;
    if ([self.decodeType isEqualToString:@"hardware"]) {
        isHardware = YES;
    }
    else if ([self.decodeType isEqualToString:@"software"]) {
        isHardware = NO;
    }

    
    [self.view addSubview:self.liveplayer.view];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.mediaType isEqualToString:@"livestream"]) {
        [self.liveplayer setBufferStrategy:NELPLowDelay];
    }
    else{
        [self.liveplayer setBufferStrategy:NELPAntiJitter];
    }
    [self.liveplayer setScalingMode:NELPMovieScalingModeNone];
    [self.liveplayer setShouldAutoplay:YES];
    [self.liveplayer setHardwareDecoder:isHardware];
    [self.liveplayer setPauseInBackground:NO];
    [self.liveplayer setPlaybackTimeout:15*1000];
    
    [self.liveplayer  prepareToPlay];
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
