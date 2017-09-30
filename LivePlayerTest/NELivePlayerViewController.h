//
//  NELivePlayerViewController.h
//  LivePlayerTest
//
//  Created by zhouhan on 2017/9/29.
//  Copyright © 2017年 zhouhan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <NELivePlayer.h>
#import <NELivePlayerController.h>

@interface NELivePlayerViewController : UIViewController

@property   (strong,nonatomic) NSURL* url;
@property   (strong,nonatomic) NSString* mediaType;
@property   (strong,nonatomic) NSString* decodeType;
@property   (strong,nonatomic) id<NELivePlayer> liveplayer;

-(instancetype)initWithURL:(NSURL*)url andDecodeParam:(NSMutableArray*)decodeParam;
@end
