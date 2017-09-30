//
//  NELIvePlayerLoginViewController.m
//  LivePlayerTest
//
//  Created by zhouhan on 2017/9/29.
//  Copyright © 2017年 zhouhan. All rights reserved.
//

#import "NELivePlayerLoginViewController.h"
#import "NELivePlayerViewController.h"

#define kVerMargin      64
#define kButtonHeight   43
#define kHorMargin      15


@interface NELivePlayerLoginViewController ()
{
    
}

@property (strong,nonatomic) UIButton* livestreamBtn;
@property (strong,nonatomic) UIButton* videoOnDemandBtn;
@property (strong,nonatomic) UIImageView* imageView;
@property  (strong,nonatomic) UIImageView* imageVieoSelector1;
@property (strong,nonatomic) UITextField* uriPath;
@property (strong,nonatomic) UIButton* qrScanBtn;
@property (strong,nonatomic) UIButton* software;
@property  (strong,nonatomic) UIButton* hardware;
@property   (strong,nonatomic) UILabel* softwareName;
@property   (strong,nonatomic) UILabel* hardwareName;
@property   (strong,nonatomic) UILabel* hardwareReminder;
@property   (strong,nonatomic) UIButton* playBtn;



@end

@implementation NELivePlayerLoginViewController

NSString* decodeType=@"software";
NSString* mediaType=@"livestream";
float width;

-(void)loadView{
    self.view=[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor=[UIColor whiteColor];
    CGFloat screenWidth=CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGFloat screenHeight=CGRectGetHeight([[UIScreen mainScreen] bounds]);
    width=screenWidth;
    
    CGFloat btnWith=screenWidth/2;
    
    UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(5, 4, 120, 30)];
    label.font=[UIFont boldSystemFontOfSize:17.0];
    label.text=@"播放选项";
    label.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=label;
    
    
    //---------------------------
    self.livestreamBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.livestreamBtn.tag=1;
    self.livestreamBtn.frame=CGRectMake(8, kVerMargin, btnWith, kButtonHeight);
    [self.livestreamBtn setBackgroundColor:[UIColor whiteColor]];
    [self.livestreamBtn setTitle:@"网络直播" forState:UIControlStateNormal];
    self.livestreamBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    [self.livestreamBtn setTitleColor:[[UIColor alloc] initWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:255] forState:UIControlStateNormal];
    self.livestreamBtn.backgroundColor=[UIColor clearColor];
    [self.livestreamBtn addTarget:self action:@selector(mediaTypeButtonTouched:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.livestreamBtn];
    
    
    //---------------------------
    self.videoOnDemandBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.videoOnDemandBtn.tag=2;
    self.videoOnDemandBtn.frame=CGRectMake(btnWith, kVerMargin, btnWith, kButtonHeight);
    [self.videoOnDemandBtn setTitle:@"视频点播" forState:UIControlStateNormal];
    self.videoOnDemandBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    [self.videoOnDemandBtn setTitleColor:[[UIColor alloc] initWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:55] forState:51.0/255];
    [self.videoOnDemandBtn setBackgroundColor:[UIColor clearColor]];
    [self.videoOnDemandBtn addTarget:self action:@selector(mediaTypeButtonTouched:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.videoOnDemandBtn];
    
    //---------------------------
    self.imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 107, screenWidth, 1)];
    [self.imageView setImage:[UIImage imageNamed:@"tab_button"]];
    [self.view addSubview:self.imageView];
    
    self.imageVieoSelector1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 104, screenWidth/2, 4)];
    [self.imageVieoSelector1 setImage:[UIImage imageNamed:@"tab_top"]];
    [self.view addSubview:self.imageVieoSelector1];
    
    //---------------------------
    self.uriPath=[[UITextField alloc] initWithFrame:CGRectMake(kHorMargin, 123, screenWidth-5*kHorMargin, 38)];
    [self.uriPath setBackgroundColor:[UIColor whiteColor]];
    self.uriPath.placeholder=@"请输入直播流地址";
    self.uriPath.font=[UIFont boldSystemFontOfSize:12];
    self.uriPath.textColor=[[UIColor alloc] initWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1];
    self.uriPath.keyboardType=UIKeyboardTypeURL;
    self.uriPath.borderStyle=UITextBorderStyleRoundedRect;
    self.uriPath.autocorrectionType=UITextAutocorrectionTypeNo;
    self.uriPath.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.uriPath addTarget:self action:@selector(textFieldDon:) forControlEvents:UIControlEventEditingDidEndOnExit];
    self.uriPath.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    self.uriPath.text=@"rtmp://live.hkstv.hk.lxdns.com/live/hks";
    [self.view addSubview:self.uriPath];
    
    //---------------------------
    self.qrScanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.qrScanBtn setImage:[UIImage imageNamed:@"btn_qr_scan"] forState:UIControlStateNormal];
    self.qrScanBtn.frame=CGRectMake(screenWidth-49, 123, 38, 38);
    [self.qrScanBtn addTarget:self action:@selector(onClickQRScan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.qrScanBtn];
    
    //---------------------------
    self.software=[UIButton buttonWithType:UIButtonTypeCustom];
    self.software.frame=CGRectMake(screenWidth/2-110, 201, 22, 22);
    [self.software setImage:[UIImage imageNamed:@"btn_player_selected"] forState:UIControlStateNormal];
    [self.software addTarget:self action:@selector(setSofewareButtonStyle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.software];
    
    //---------------------------
    self.hardware=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.hardware setImage:[UIImage imageNamed:@"btn_player_unselected"] forState:UIControlStateNormal];
    self.hardware.frame=CGRectMake(screenWidth/2+32, 201, 22, 22);
    [self.hardware addTarget:self action:@selector(setHardwareButtonStyle:) forControlEvents:UIControlEventTouchUpInside ];
    [self.view addSubview:self.hardware];
    
    //---------------------------
    self.softwareName=[[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2-88, 201, 56, 22)];
    self.softwareName.text=@"软件解码";
    self.softwareName.textColor=[[UIColor alloc] initWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1];
    self.softwareName.font=[UIFont boldSystemFontOfSize:14];
    [self.view addSubview:self.softwareName];
    
    self.hardwareName=[[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2+54, 201, 56, 22)];
    self.hardwareName.textColor=[[UIColor alloc] initWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1 ];
    self.hardwareName.text=@"硬件解码";
    self.hardwareName.font=[UIFont boldSystemFontOfSize:14];
    [self.view addSubview:self.hardwareName];
    
    //---------------------------
    self.hardwareReminder=[[UILabel alloc] initWithFrame:CGRectMake(30, screenHeight-39, screenWidth-60, 14)];
    self.hardwareReminder.text=@"硬件解码在IOS 8。0以上才支持";
    self.hardwareReminder.textAlignment=NSTextAlignmentCenter;
    self.hardwareReminder.textColor=[[UIColor alloc] initWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1];
    self.hardwareReminder.font=[UIFont boldSystemFontOfSize:14];
    self.hardwareReminder.numberOfLines=0;
    [self.view addSubview:self.hardwareReminder];

    //---------------------------
    self.playBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.playBtn.tag=5;
    self.playBtn.frame=CGRectMake(kHorMargin, 241, screenWidth-2*kHorMargin, 40);
    [self.playBtn setBackgroundImage:[UIImage imageNamed:@"btn_player_start_play"] forState:UIControlStateNormal];
    [self.playBtn setTitle:@"播 放" forState:UIControlStateNormal];
    self.playBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    self.playBtn.titleLabel.textColor=[[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0  ];
    [self.playBtn addTarget:self action:@selector(playButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.playBtn];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)shouldAutorotate{
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)mediaTypeButtonTouched:(id)sender{
    UIButton* button=(UIButton*)sender;
    switch (button.tag) {
        case 1:
            self.uriPath.hidden=NO;
            self.imageVieoSelector1.frame=CGRectMake(0,104, width/2, 4);
            self.uriPath.placeholder=@"请输入直播流地址:URL";
            mediaType=@"livestream";
            self.software.frame=CGRectMake(width/2-110, 201, 22,22);
            self.hardware.frame=CGRectMake(width/2+32, 201, 22,22);
            self.softwareName.frame=CGRectMake(width/2-88, 201, 56,22);
            self.hardwareName.frame=CGRectMake(width/2+54, 201, 56,22);
            break;
        case 2:
            self.uriPath.hidden=NO;
            self.imageVieoSelector1.frame = CGRectMake(width/2, 104, width/2, 4);
            mediaType=@"videoOnDemand";
            self.software.frame=CGRectMake(width/2-110, 201, 22,22);
            self.hardware.frame=CGRectMake(width/2+32, 201, 22,22);
            self.softwareName.frame=CGRectMake(width/2-88, 201, 56,22);
            self.hardwareName.frame=CGRectMake(width/2+54, 201, 56,22);
            break;
        default:
            break;
    }
}
- (void)textFieldDon:(UITextField*)textField{
    [textField resignFirstResponder];
}
- (void)onClickQRScan:(id)sender{
    
}
- (void)setSofewareButtonStyle:(id)sender{
    decodeType=@"software";
    [self.hardware setSelected:NO];
    [self.software setSelected:YES];
    [self.software setImage:[UIImage imageNamed:@"btn_player_selected"] forState:UIControlStateSelected];
    [self.hardware setImage:[UIImage imageNamed:@"btn_player_unselected"] forState:UIControlStateNormal];
}
-(void)setHardwareButtonStyle:(id)sender{
    decodeType=@"hardware";
    [self.software setSelected:NO];
    [self.hardware setSelected:YES];
    [self.hardware setImage:[UIImage imageNamed:@"btn_player_selected"] forState:UIControlStateSelected];
    [self.software setImage:[UIImage imageNamed:@"btn_player_unselected"] forState:UIControlStateNormal];

}
-(void)playButtonPressed:(id)sender{
    NSURL* url= NULL;
    UIAlertController* alert=NULL;
    if ([mediaType isEqualToString:@"livestream"] || [mediaType isEqualToString:@"videoOnDemand"]) {
        if ([self.uriPath.text length]==0) {
            if([mediaType isEqualToString:@"livestream"])
            {
                alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"请输入直播流地址" preferredStyle:UIAlertControllerStyleAlert];
            }
            else if([mediaType isEqualToString:@"videoOnDemand"])
            {
                alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"请输入颠簸流地址"  preferredStyle:UIAlertControllerStyleAlert];
            }
            UIAlertAction* alertAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:alertAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        url=[[NSURL alloc] initWithString:self.uriPath.text];
    }
    NSMutableArray* decodeParam=[[NSMutableArray alloc] init];
    [decodeParam addObject:decodeType];
    [decodeParam addObject:mediaType];
    
    NELivePlayerViewController* nelpViewController=[[NELivePlayerViewController alloc] initWithURL:url andDecodeParam:decodeParam];
    [self presentViewController:nelpViewController animated:YES completion:nil];
}
@end
