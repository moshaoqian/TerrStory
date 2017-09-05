//
//  LXAlertView.m
//  LXAlertViewDemo
//
//  Created by 刘鑫 on 16/4/15.
//  Copyright © 2016年 liuxin. All rights reserved.
//
#define MainScreenRect [UIScreen mainScreen].bounds
#define AlertView_W     (DEVICE_SIZE.width - 80.f)
#define MessageMin_H    20.0f       //messagelab的最小高度
#define MessageMAX_H    120.0f      //messagelab的最大高度，当超过时，文本会以...结尾
#define LXATitle_H      20.0f
#define LXABtn_H        30.0f
#define TitleBackViewHeight   56.f * autoLayoutY

#define SFQBlueColor        [UIColor colorWithRed:9/255.0 green:170/255.0 blue:238/255.0 alpha:1]
#define SFQRedColor         [UIColor colorWithRed:255/255.0 green:92/255.0 blue:79/255.0 alpha:1]
#define SFQLightGrayColor   [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1]

#define LXADTitleFont       [UIFont boldSystemFontOfSize:17];
#define LXADMessageFont     [UIFont systemFontOfSize:14];
#define LXADBtnTitleFont    [UIFont systemFontOfSize:15];



#import "LXAlertView.h"
#import "UILabel+LXAdd.h"
#import "UIImage+Add.h"

@interface LXAlertView()<UITextFieldDelegate>
@property (nonatomic,strong)UIWindow *alertWindow;
@property (nonatomic,strong)UIView *alertView;

@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UILabel *messageLab;
@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,strong)UIButton *otherBtn;

@property (nonatomic,strong)UILabel *title1;
@property (nonatomic,strong)UILabel *title2;
@property (nonatomic,strong)UILabel *title3;

@property (nonatomic,strong)UIView *titleBackView;
@property (nonatomic,strong)UIImageView * titleImageView;
@property (nonatomic,assign)CGFloat imageScale;
@end

@implementation LXAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//带背景图
-(instancetype)initWithImage:(UIImage *)image imageScale:(CGFloat)imageScale message:(NSString *)message isFromPaper:(BOOL)isFromPaper showGuide:(BOOL)showGuide cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle clickIndexBlock:(LXAlertClickIndexBlock)block {
    
    if(self=[super init]){
        self.frame=MainScreenRect;
        
        CGFloat imageH;
        CGFloat messageH;
        CGFloat lMargin = 20;
        CGFloat lMargun2 = 5;
        //背景色
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:MainScreenRect];
        imageView.image = [UIImage imageNamed:@"alertview_bg"];
        imageView.alpha = 0;
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundClick)];
        [imageView addGestureRecognizer:tap];
        
        [UIView animateWithDuration:0.3 animations:^{
            imageView.alpha = 1;
        }];
        
        _alertView=[[UIView alloc] init];
        _alertView.backgroundColor=[UIColor whiteColor];
        _alertView.layer.cornerRadius=10.0;
        _alertView.layer.masksToBounds=YES;
        _alertView.userInteractionEnabled=YES;
        [self addSubview:_alertView];

        if (imageScale) {
            _imageScale = imageScale;
        }
        
        if (image) {
            _titleBackView = [[UIView alloc]init];
            _titleBackView.backgroundColor = [UIColor clearColor];
            _titleBackView.layer.masksToBounds = YES;
            _titleImageView = [[UIImageView alloc] init];
            _titleImageView.image = image;
            [_titleBackView addSubview:_titleImageView];
            [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.left.mas_equalTo(0);
            }];
            imageH = AlertView_W* imageScale;
        }
        [_alertView addSubview:_titleBackView];
        [_titleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(imageH);
        }];
        
        CGFloat messageLabSpace = 20;
        _messageLab=[[UILabel alloc] init];
        _messageLab.backgroundColor=[UIColor clearColor];
        _messageLab.text=message;
        _messageLab.textColor=kTitleColor;
        _messageLab.font=kFont(16 * autoLayoutY);
        _messageLab.numberOfLines=0;
        _messageLab.textAlignment=NSTextAlignmentCenter;
        _messageLab.lineBreakMode=NSLineBreakByTruncatingTail;
        _messageLab.characterSpace=2;
        _messageLab.lineSpace=3;
        [_alertView addSubview:_messageLab];
        CGSize labSize = [_messageLab getLableRectWithMaxWidth:AlertView_W-messageLabSpace*2];
        CGFloat messageLabAotuH = labSize.height < MessageMin_H?MessageMin_H:labSize.height;
        CGFloat endMessageLabH = messageLabAotuH > MessageMAX_H?MessageMAX_H:messageLabAotuH;
        messageH = endMessageLabH;
        [_messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleBackView.mas_bottom).offset(0);
            make.left.mas_equalTo(lMargin);
            make.right.mas_equalTo(-lMargin);
            make.height.mas_equalTo(messageH);
        }];
        
        [self addSubview:_alertView];
        [_alertView addSubview:_titleBackView];
        //指引
        if (showGuide) {
            UIImageView* guide = [[UIImageView alloc] init];
            guide.image = [UIImage imageNamed:@"创建小组箭头指引"];
            [imageView addSubview:guide];
            [guide mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(23.5);
                make.right.mas_equalTo(-10);
                make.height.mas_equalTo(87);
                make.width.mas_equalTo(55);
            }];
            UIImageView* writeBGView =[[UIImageView alloc] init];
            writeBGView.backgroundColor = [UIColor whiteColor];
            [_alertView addSubview:writeBGView];
            if (otherBtnTitle) {
                [writeBGView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_titleBackView.mas_bottom);
                    make.left.mas_equalTo(0);
                    make.right.mas_equalTo(0);
                    make.height.mas_equalTo(messageH + lMargin + kCustonButtonHeight + 10);
                }];
            }
            if (cancelTitle) {
                [writeBGView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_titleBackView.mas_bottom);
                    make.left.mas_equalTo(0);
                    make.right.mas_equalTo(0);
                    make.height.mas_equalTo(messageH + lMargin + kCustonButtonHeight + lMargun2 + kCustonButtonHeight+ 10);
                }];
            }
            _alertView.backgroundColor=[UIColor clearColor];
        }
        [_alertView addSubview:_messageLab];
        
        if (otherBtnTitle) {
            _otherBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_otherBtn setTitle:otherBtnTitle forState:UIControlStateNormal];
            [_otherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_otherBtn setBackgroundImage:[UIImage imageWithColor:kGlobalColor] forState:UIControlStateNormal];
            [_otherBtn setBackgroundImage:[UIImage imageWithColor:kGlobalHighlightColor] forState:UIControlStateHighlighted];
            _otherBtn.layer.masksToBounds = YES;
            _otherBtn.layer.cornerRadius = kCustonButtonHeight/2;
            _otherBtn.titleLabel.font=kFont(16 * autoLayoutY);
            [_otherBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_otherBtn];
            [_otherBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_messageLab.mas_bottom).offset(lMargin);
                make.height.mas_equalTo(kCustonButtonHeight);
                make.width.mas_equalTo(kCustonButtonWidth);
                make.centerX.mas_equalTo(_alertView.mas_centerX);
            }];
            [_alertView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(AlertView_W);
                make.height.mas_equalTo(imageH + messageH + lMargin + kCustonButtonHeight + lMargin);
                make.centerX.mas_equalTo(self.mas_centerX);
                make.centerY.mas_equalTo(self.mas_centerY);
            }];
        }
        if (cancelTitle) {
            _cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
            [_cancelBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
            [_cancelBtn setTitleColor:kColor(143, 143, 152) forState:UIControlStateHighlighted];
            [_cancelBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [_cancelBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];

            _otherBtn.layer.masksToBounds = YES;
            _otherBtn.layer.cornerRadius = kCustonButtonHeight/2;
            
            _cancelBtn.titleLabel.font=kFont(16 * autoLayoutY);
            [_cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_cancelBtn];
            
            [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_otherBtn.mas_bottom).offset(lMargun2);
                make.height.mas_equalTo(kCustonButtonHeight);
                make.width.mas_equalTo(kCustonButtonWidth);
                make.centerX.mas_equalTo(_alertView.mas_centerX);
            }];
            [_alertView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(AlertView_W);
                make.height.mas_equalTo(imageH + messageH + lMargin + kCustonButtonHeight + lMargun2 + kCustonButtonHeight+ 10);
                make.centerX.mas_equalTo(self.mas_centerX);
                make.centerY.mas_equalTo(self.mas_centerY);
            }];
        }
        if (cancelTitle && !otherBtnTitle) {
            _cancelBtn.tag=0;
        }else if (!cancelTitle && otherBtnTitle){
            _otherBtn.tag=0;
        }else if (cancelTitle && otherBtnTitle){
            _cancelBtn.tag=0;
            _otherBtn.tag=1;
        }
        self.clickBlock=block;
    }
    return self;
}

//摇一摇弹窗
-(instancetype)initWithImage:(UIImage *)image imageScale:(CGFloat)imageScale message:(NSString *)message title1:(NSString *)title1 title2:(NSString *)title2 title3:(NSString *)title3 btnTitle:(NSString *)btnTitle clickIndexBlock:(LXAlertClickIndexBlock)block
{

    if(self=[super init]){
        self.frame=MainScreenRect;
        
        CGFloat imageH = 0.0;
        CGFloat messageH;
        CGFloat lMargin = 20;
        //背景色
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:MainScreenRect];
        imageView.image = [UIImage imageNamed:@"alertview_bg"];
        imageView.alpha = 0;
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundClick)];
        [imageView addGestureRecognizer:tap];
        
        [UIView animateWithDuration:0.3 animations:^{
            imageView.alpha = 1;
        }];
        
        _alertView=[[UIView alloc] init];
        _alertView.backgroundColor=[UIColor whiteColor];
        _alertView.layer.cornerRadius=10.0;
        _alertView.layer.masksToBounds=YES;
        _alertView.userInteractionEnabled=YES;
        [self addSubview:_alertView];
        
        if (imageScale) {
            _imageScale = imageScale;
        }
        
        if (image) {
            
            _titleImageView = [[UIImageView alloc] init];
            _titleImageView.backgroundColor = [UIColor clearColor];
            _titleImageView.layer.masksToBounds = YES;
            _titleImageView.contentMode = UIViewContentModeScaleAspectFill;
            _titleImageView.image = image;
            
            [_alertView addSubview:_titleImageView];

            imageH = AlertView_W;
            [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.left.mas_equalTo(0);
                make.height.mas_equalTo(imageH);
            }];
        }

        if (title2) {
            _title2=[[UILabel alloc] init];
            _title2.text=title2;
            _title2.textColor=[UIColor whiteColor];
            _title2.font=kFont(16 * autoLayoutY);
            _title2.textAlignment = NSTextAlignmentCenter;
            [_titleImageView addSubview:_title2];
            
            [_title2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-lMargin*2);
                make.centerX.mas_equalTo(_titleImageView.mas_centerX);
                make.width.mas_equalTo(_titleImageView.mas_width).mas_offset(-20);
                make.height.mas_equalTo(18 * autoLayoutY);
            }];
        }
        
        if (title1) {
            _title1=[[UILabel alloc] init];
            _title1.text=title1;
            _title1.textColor=[UIColor whiteColor];
            _title1.font=kFont(24 * autoLayoutY);
            _title1.textAlignment = NSTextAlignmentCenter;
            [_titleImageView addSubview:_title1];
            
            [_title1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(_title2.mas_top).mas_offset(-10);
                make.centerX.mas_equalTo(_titleImageView.mas_centerX);
                make.width.mas_equalTo(_titleImageView.mas_width);
                make.height.mas_equalTo(26 * autoLayoutY);
            }];
        }
        
        CGFloat messageLabSpace = 20;
        _messageLab=[[UILabel alloc] init];
        _messageLab.backgroundColor=[UIColor clearColor];
        _messageLab.text=message;
        _messageLab.textColor=kTitleColor;
        _messageLab.font=kFont(16 * autoLayoutY);
        _messageLab.numberOfLines=0;
        _messageLab.textAlignment=NSTextAlignmentCenter;
        _messageLab.lineBreakMode=NSLineBreakByTruncatingTail;
        _messageLab.characterSpace=2;
        _messageLab.lineSpace=3;
        [_alertView addSubview:_messageLab];
        CGSize labSize = [_messageLab getLableRectWithMaxWidth:AlertView_W-messageLabSpace*2];
        CGFloat messageLabAotuH = labSize.height < MessageMin_H?MessageMin_H:labSize.height;
        CGFloat endMessageLabH = messageLabAotuH > MessageMAX_H?MessageMAX_H:messageLabAotuH;
        messageH = endMessageLabH;
        [_messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleImageView.mas_bottom).offset(0);
            make.left.mas_equalTo(lMargin);
            make.right.mas_equalTo(-lMargin);
            make.height.mas_equalTo(messageH);
        }];
        
        [self addSubview:_alertView];

        UIImageView* writeBGView =[[UIImageView alloc] init];
        writeBGView.backgroundColor = [UIColor whiteColor];
        [_alertView addSubview:writeBGView];
        if (btnTitle) {
            [writeBGView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_titleImageView.mas_bottom);
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.height.mas_equalTo(messageH + lMargin + kCustonButtonHeight + 14 * autoLayoutY + lMargin + lMargin);
            }];
        }
        _alertView.backgroundColor=[UIColor clearColor];

        [_alertView addSubview:_messageLab];
        
        if (title3) {
            _title3=[[UILabel alloc] init];
            _title3.text=title3;
            _title3.textColor=kGrayColor;
            _title3.font=kFont(12 * autoLayoutY);
            _title3.textAlignment = NSTextAlignmentCenter;
            [_alertView addSubview:_title3];
            
            [_title3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_messageLab.mas_bottom).mas_offset(10);
                make.centerX.mas_equalTo(self.mas_centerX);
                make.width.mas_equalTo(self.mas_width);
                make.height.mas_equalTo(14 * autoLayoutY);
            }];
        }
        
        
        if (btnTitle) {
            _otherBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_otherBtn setTitle:btnTitle forState:UIControlStateNormal];
            [_otherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_otherBtn setBackgroundImage:[UIImage imageWithColor:kGlobalColor] forState:UIControlStateNormal];
            [_otherBtn setBackgroundImage:[UIImage imageWithColor:kGlobalHighlightColor] forState:UIControlStateHighlighted];
            _otherBtn.layer.masksToBounds = YES;
            _otherBtn.layer.cornerRadius = kCustonButtonHeight/2;
            _otherBtn.titleLabel.font=kFont(16 * autoLayoutY);
            [_otherBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_otherBtn];
            [_otherBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_title3.mas_bottom).offset(lMargin);
                make.height.mas_equalTo(kCustonButtonHeight);
                make.width.mas_equalTo(kCustonButtonWidth);
                make.centerX.mas_equalTo(_alertView.mas_centerX);
            }];
            [_alertView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(AlertView_W);
                make.height.mas_equalTo(imageH + messageH + lMargin + kCustonButtonHeight + 14 * autoLayoutY + lMargin + lMargin);
                make.centerX.mas_equalTo(self.mas_centerX);
                make.centerY.mas_equalTo(self.mas_centerY);
            }];
        }
        _otherBtn.tag = 0;

        self.clickBlock=block;
    }
    return self;

}


-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle clickIndexBlock:(LXAlertClickIndexBlock)block{
    if(self=[super init]){
        self.frame=MainScreenRect;
        
        //背景色
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:MainScreenRect];
        imageView.image = [UIImage imageNamed:@"alertview_bg"];
        imageView.alpha = 0;
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundClick)];
        [imageView addGestureRecognizer:tap];
        
        [UIView animateWithDuration:0.3 animations:^{
            imageView.alpha = 1;
        }];

        _alertView=[[UIView alloc] init];
        _alertView.backgroundColor=[UIColor whiteColor];
        _alertView.layer.cornerRadius=6.0;
        _alertView.layer.masksToBounds=YES;
        _alertView.userInteractionEnabled=YES;
        
        
        if (title) {
            _titleBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AlertView_W, 56 * autoLayoutY)];
            _titleBackView.backgroundColor = kGlobalColor;
            _titleBackView.layer.masksToBounds = YES;
            
            _titleLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 28 * autoLayoutY - LXATitle_H/2.0, AlertView_W, LXATitle_H)];
            _titleLab.text=title;
            _titleLab.textAlignment=NSTextAlignmentCenter;
            _titleLab.textColor=[UIColor whiteColor];
            _titleLab.font=kFont(18 * autoLayoutY);
            
        }
        
        CGFloat messageLabSpace = 20;
        _messageLab=[[UILabel alloc] init];
        _messageLab.backgroundColor=[UIColor clearColor];
        _messageLab.text=message;
        _messageLab.textColor=kTitleColor;
        _messageLab.font=kFont(16 * autoLayoutY);
        _messageLab.numberOfLines=0;
        _messageLab.textAlignment=NSTextAlignmentCenter;
        _messageLab.lineBreakMode=NSLineBreakByTruncatingTail;
        _messageLab.characterSpace=2;
        _messageLab.lineSpace=3;
        CGSize labSize = [_messageLab getLableRectWithMaxWidth:AlertView_W-messageLabSpace*2];
        CGFloat messageLabAotuH = labSize.height < MessageMin_H?MessageMin_H:labSize.height;
        CGFloat endMessageLabH = messageLabAotuH > MessageMAX_H?MessageMAX_H:messageLabAotuH;
        _messageLab.frame=CGRectMake(messageLabSpace, TitleBackViewHeight + 20 + 10, AlertView_W-messageLabSpace*2, endMessageLabH);
        
        //计算_alertView的高度
        _alertView.frame=CGRectMake(0, 0, AlertView_W, _messageLab.frame.size.height+LXATitle_H+LXABtn_H+40+60);
        
        _alertView.center=self.center;
        [self addSubview:_alertView];
        [_alertView addSubview:_titleBackView];
        [_alertView addSubview:_titleLab];
        [_alertView addSubview:_messageLab];
        
        if (cancelTitle) {
            _cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
            [_cancelBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
//            [_cancelBtn setBackgroundImage:[UIImage imageWithColor:SFQLightGrayColor] forState:UIControlStateNormal];
            _cancelBtn.titleLabel.font=kFont(16 * autoLayoutY);
            _cancelBtn.layer.cornerRadius=3;
            _cancelBtn.layer.masksToBounds=YES;
            [_cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_cancelBtn];
        }
        
        if (otherBtnTitle) {
            _otherBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_otherBtn setTitle:otherBtnTitle forState:UIControlStateNormal];
            [_otherBtn setTitleColor:kGlobalColor forState:UIControlStateNormal];
            _otherBtn.titleLabel.font=kFont(16 * autoLayoutY);
            _otherBtn.layer.cornerRadius=3;
            _otherBtn.layer.masksToBounds=YES;
//            [_otherBtn setBackgroundImage:[UIImage imageWithColor:SFQRedColor] forState:UIControlStateNormal];
            [_otherBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_otherBtn];
        }
        
        CGFloat btnLeftSpace = 40;//btn到左边距
        CGFloat btn_y = _alertView.frame.size.height-40-5;
        if (cancelTitle && !otherBtnTitle) {
            _cancelBtn.tag=0;
            _cancelBtn.frame=CGRectMake(btnLeftSpace, btn_y, AlertView_W-btnLeftSpace*2, LXABtn_H);
        }else if (!cancelTitle && otherBtnTitle){
            _otherBtn.tag=0;
            _otherBtn.frame=CGRectMake(btnLeftSpace, btn_y, AlertView_W-btnLeftSpace*2, LXABtn_H);
        }else if (cancelTitle && otherBtnTitle){
            _cancelBtn.tag=0;
            _otherBtn.tag=1;
            CGFloat btnSpace = 20;//两个btn之间的间距
            CGFloat btn_w =(AlertView_W-btnLeftSpace*2-btnSpace)/2;
            _cancelBtn.frame=CGRectMake(btnLeftSpace, btn_y, btn_w, LXABtn_H);
            _otherBtn.frame=CGRectMake(_alertView.frame.size.width-btn_w-btnLeftSpace, btn_y, btn_w, LXABtn_H);
        }
        
        self.clickBlock=block;
        
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle clickIndexBlock:(LXAlertClickIndexBlock)block and:(BOOL)isHasLongTittle and:(BOOL)isMessageCenter
{
    if(self=[super init]){
        self.frame=MainScreenRect;
        
        //背景色
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:MainScreenRect];
        imageView.image = [UIImage imageNamed:@"alertview_bg"];
        imageView.alpha = 0;
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundClick)];
        [imageView addGestureRecognizer:tap];
        
        [UIView animateWithDuration:0.3 animations:^{
            imageView.alpha = 1;
        }];
        
        _alertView=[[UIView alloc] init];
        _alertView.backgroundColor=[UIColor whiteColor];
        _alertView.layer.cornerRadius=6.0;
        _alertView.layer.masksToBounds=YES;
        _alertView.userInteractionEnabled=YES;
        
        if (title) {
            _titleBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AlertView_W, 56 * autoLayoutY)];
            _titleBackView.backgroundColor = kGlobalColor;
            _titleBackView.layer.masksToBounds = YES;
            
            _titleLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 28 * autoLayoutY - LXATitle_H/2.0, AlertView_W, LXATitle_H)];
            _titleLab.text=title;
            _titleLab.textAlignment=NSTextAlignmentCenter;
            _titleLab.textColor=[UIColor whiteColor];
            _titleLab.font=kFontBold(18 * autoLayoutY);
            
        }
        
        CGFloat messageLabSpace = 20;
        _messageLab=[[UILabel alloc] init];
        _messageLab.backgroundColor=[UIColor clearColor];
        _messageLab.text=message;
        self.message = message;
        _messageLab.textColor=kTitleColor;
        _messageLab.font=kFont(16 * autoLayoutY);
        _messageLab.numberOfLines=0;
        _messageLab.textAlignment = isMessageCenter == YES ? NSTextAlignmentCenter : NSTextAlignmentLeft;
        _messageLab.lineBreakMode=NSLineBreakByTruncatingTail;
        _messageLab.characterSpace=2;
        _messageLab.lineSpace=3;
        CGSize labSize = [_messageLab getLableRectWithMaxWidth:AlertView_W-messageLabSpace*2];
        CGFloat messageLabAotuH = labSize.height < MessageMin_H?MessageMin_H:labSize.height;
        CGFloat endMessageLabH = messageLabAotuH > MessageMAX_H?MessageMAX_H:messageLabAotuH;
        _messageLab.frame=CGRectMake(messageLabSpace, TitleBackViewHeight + 20 + 10, AlertView_W-messageLabSpace*2, endMessageLabH + 10);
        
        //计算_alertView的高度
        _alertView.frame=CGRectMake(0, 0, AlertView_W, _messageLab.frame.size.height+LXATitle_H+LXABtn_H+40+60);
        
        _alertView.center=self.center;
        [self addSubview:_alertView];
        [_alertView addSubview:_titleBackView];
        [_alertView addSubview:_titleLab];
        [_alertView addSubview:_messageLab];
        
        if (cancelTitle) {
            _cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
            [_cancelBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
            //            [_cancelBtn setBackgroundImage:[UIImage imageWithColor:SFQLightGrayColor] forState:UIControlStateNormal];
            _cancelBtn.titleLabel.font=kFontBold(16 * autoLayoutY);
            _cancelBtn.layer.cornerRadius=3;
            _cancelBtn.layer.masksToBounds=YES;
            [_cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_cancelBtn];
        }
        
        if (otherBtnTitle) {
            _otherBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_otherBtn setTitle:otherBtnTitle forState:UIControlStateNormal];
            [_otherBtn setTitleColor:kGlobalColor forState:UIControlStateNormal];
            _otherBtn.titleLabel.font=kFontBold(16 * autoLayoutY);
            _otherBtn.layer.cornerRadius=3;
            _otherBtn.layer.masksToBounds=YES;
            //            [_otherBtn setBackgroundImage:[UIImage imageWithColor:SFQRedColor] forState:UIControlStateNormal];
            [_otherBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_otherBtn];
        }
        
        CGFloat btnLeftSpace = 40;//btn到左边距
        CGFloat btn_y = _alertView.frame.size.height-40-5;
        if (cancelTitle && !otherBtnTitle) {
            _cancelBtn.tag=0;
            _cancelBtn.frame=CGRectMake(btnLeftSpace, btn_y, AlertView_W-btnLeftSpace*2, LXABtn_H);
        }else if (!cancelTitle && otherBtnTitle){
            _otherBtn.tag=0;
            _otherBtn.frame=CGRectMake(btnLeftSpace, btn_y, AlertView_W-btnLeftSpace*2, LXABtn_H);
        }else if (cancelTitle && otherBtnTitle){
            _cancelBtn.tag=0;
            _otherBtn.tag=1;
            CGFloat btnSpace = 20;//两个btn之间的间距
            CGFloat btn_w =(AlertView_W-btnLeftSpace*2-btnSpace)/2;
            _cancelBtn.frame=CGRectMake(btnLeftSpace, btn_y, btn_w, LXABtn_H);
            _otherBtn.frame=CGRectMake(_alertView.frame.size.width-btn_w-btnLeftSpace, btn_y, btn_w, LXABtn_H);
        }
        
        self.clickBlock=block;
        
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message isFromPaper:(BOOL)isFromPaper cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle clickIndexBlock:(LXAlertClickIndexBlock)block{
    if(self=[super init]){
        self.frame=MainScreenRect;
        
        if (isFromPaper) {
            self.backgroundColor=[UIColor clearColor];
        }
        _alertView=[[UIView alloc] init];
        _alertView.backgroundColor=[UIColor whiteColor];
        _alertView.layer.cornerRadius=6.0;
        _alertView.layer.masksToBounds=YES;
        _alertView.userInteractionEnabled=YES;
        
        
        if (title) {
            _titleBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AlertView_W, 56 * autoLayoutY)];
            _titleBackView.backgroundColor = kGlobalColor;
            _titleBackView.layer.masksToBounds = YES;
            
            _titleLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 28 * autoLayoutY - LXATitle_H/2.0, AlertView_W, LXATitle_H)];
            _titleLab.text=title;
            _titleLab.textAlignment=NSTextAlignmentCenter;
            _titleLab.textColor=[UIColor whiteColor];
            _titleLab.font=kFont(18 * autoLayoutY);
            
        }
        
        CGFloat messageLabSpace = 20;
        _messageLab=[[UILabel alloc] init];
        _messageLab.backgroundColor=[UIColor clearColor];
        _messageLab.text=message;
        _messageLab.textColor=kTitleColor;
        _messageLab.font=kFont(16 * autoLayoutY);
        _messageLab.numberOfLines=0;
        _messageLab.textAlignment=NSTextAlignmentCenter;
        _messageLab.lineBreakMode=NSLineBreakByTruncatingTail;
        _messageLab.characterSpace=2;
        _messageLab.lineSpace=3;
        CGSize labSize = [_messageLab getLableRectWithMaxWidth:AlertView_W-messageLabSpace*2];
        CGFloat messageLabAotuH = labSize.height < MessageMin_H?MessageMin_H:labSize.height;
        CGFloat endMessageLabH = messageLabAotuH > MessageMAX_H?MessageMAX_H:messageLabAotuH;
        _messageLab.frame=CGRectMake(messageLabSpace, TitleBackViewHeight + 20 + 10, AlertView_W-messageLabSpace*2, endMessageLabH);
        
        
        //计算_alertView的高度
        _alertView.frame=CGRectMake(0, 0, AlertView_W, _messageLab.frame.size.height+LXATitle_H+LXABtn_H+40+60);
        _alertView.center=self.center;
        [self addSubview:_alertView];
        [_alertView addSubview:_titleBackView];
        [_alertView addSubview:_titleLab];
        [_alertView addSubview:_messageLab];
        
        if (cancelTitle) {
            _cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
            [_cancelBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
            //            [_cancelBtn setBackgroundImage:[UIImage imageWithColor:SFQLightGrayColor] forState:UIControlStateNormal];
            _cancelBtn.titleLabel.font=kFont(16 * autoLayoutY);
            _cancelBtn.layer.cornerRadius=3;
            _cancelBtn.layer.masksToBounds=YES;
            [_cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_cancelBtn];
        }
        
        if (otherBtnTitle) {
            _otherBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_otherBtn setTitle:otherBtnTitle forState:UIControlStateNormal];
            [_otherBtn setTitleColor:kGlobalColor forState:UIControlStateNormal];
            _otherBtn.titleLabel.font=kFont(16 * autoLayoutY);
            _otherBtn.layer.cornerRadius=3;
            _otherBtn.layer.masksToBounds=YES;
            //            [_otherBtn setBackgroundImage:[UIImage imageWithColor:SFQRedColor] forState:UIControlStateNormal];
            [_otherBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_otherBtn];
        }
        
        CGFloat btnLeftSpace = 40;//btn到左边距
        CGFloat btn_y = _alertView.frame.size.height-40-5;
        if (cancelTitle && !otherBtnTitle) {
            _cancelBtn.tag=0;
            _cancelBtn.frame=CGRectMake(btnLeftSpace, btn_y, AlertView_W-btnLeftSpace*2, LXABtn_H);
        }else if (!cancelTitle && otherBtnTitle){
            _otherBtn.tag=0;
            _otherBtn.frame=CGRectMake(btnLeftSpace, btn_y, AlertView_W-btnLeftSpace*2, LXABtn_H);
        }else if (cancelTitle && otherBtnTitle){
            _cancelBtn.tag=0;
            _otherBtn.tag=1;
            CGFloat btnSpace = 20;//两个btn之间的间距
            CGFloat btn_w =(AlertView_W-btnLeftSpace*2-btnSpace)/2;
            _cancelBtn.frame=CGRectMake(btnLeftSpace, btn_y, btn_w, LXABtn_H);
            _otherBtn.frame=CGRectMake(_alertView.frame.size.width-btn_w-btnLeftSpace, btn_y, btn_w, LXABtn_H);
        }
        
        self.clickBlock=block;
        
    }
    return self;
}
//输入密码
-(instancetype)initWithPwdTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle clickPwdBlock:(LXAlertClickPwdBlock)pwdBlock{
    
    if(self=[super init]){
        self.frame=MainScreenRect;
        
        //背景色
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:MainScreenRect];
        imageView.image = [UIImage imageNamed:@"alertview_bg"];
        imageView.alpha = 0;
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundClick)];
        [imageView addGestureRecognizer:tap];
        
        [UIView animateWithDuration:0.3 animations:^{
            imageView.alpha = 1;
        }];

        _alertView=[[UIView alloc] init];
        _alertView.backgroundColor=[UIColor whiteColor];
        _alertView.layer.cornerRadius=6.0;
        _alertView.layer.masksToBounds=YES;
        _alertView.userInteractionEnabled=YES;
        
        CGSize titleLabSize;
        if (title) {

            _titleLab=[[UILabel alloc]init];
            _titleLab.text=title;
            _titleLab.textAlignment=NSTextAlignmentLeft;
            _titleLab.numberOfLines=0;
            _titleLab.textColor=kTitleColor;
            _titleLab.font=kFont(16 * autoLayoutY);
            titleLabSize = [_titleLab getLableRectWithMaxWidth:AlertView_W-20*2];
            _titleLab.frame = CGRectMake(20, 20, AlertView_W - 40, titleLabSize.height);
        }
        
        CGFloat messageLabSpace = 20;
        _messageLab=[[UILabel alloc] init];
        _messageLab.backgroundColor=[UIColor clearColor];
        _messageLab.text=message;
        _messageLab.textColor=kGlobalColor;
        _messageLab.font=kFont(14 * autoLayoutY);
        _messageLab.numberOfLines=0;
        _messageLab.textAlignment=NSTextAlignmentLeft;
        _messageLab.lineBreakMode=NSLineBreakByTruncatingTail;
        _messageLab.characterSpace=2;
        _messageLab.lineSpace=3;
        CGSize labSize = [_messageLab getLableRectWithMaxWidth:AlertView_W-messageLabSpace*2];
        CGFloat messageLabAotuH = labSize.height < MessageMin_H?MessageMin_H:labSize.height;
        CGFloat endMessageLabH = messageLabAotuH > MessageMAX_H?MessageMAX_H:messageLabAotuH;
        _messageLab.frame=CGRectMake(messageLabSpace, 20* 2 + titleLabSize.height, AlertView_W-messageLabSpace*2, endMessageLabH);
        
        _pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, _messageLab.frame.origin.y + labSize.height + 20, AlertView_W - 2* messageLabSpace, 40* autoLayoutY)];
        
        _pwdTextField.font = kFont(16* autoLayoutY);
        _pwdTextField.backgroundColor = [UIColor whiteColor];
        _pwdTextField.hidden = NO;
        [_pwdTextField becomeFirstResponder];
        _pwdTextField.textAlignment = NSTextAlignmentJustified;
        _pwdTextField.secureTextEntry = YES;
        _pwdTextField.tintColor = kGlobalColor;
        _pwdTextField.layer.masksToBounds = YES;
        _pwdTextField.layer.cornerRadius = 20* autoLayoutY;
        _pwdTextField.layer.borderWidth=0.5f;
        _pwdTextField.layer.borderColor=[kColor(169, 169, 179) CGColor];
        _pwdTextField.returnKeyType = UIReturnKeyDone;
        _pwdTextField.delegate = self;
        UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40* autoLayoutY)];
        leftView.backgroundColor = [UIColor whiteColor];
        _pwdTextField.leftView = leftView;
        _pwdTextField.leftViewMode = UITextFieldViewModeAlways;

        [_alertView addSubview:_pwdTextField];
        //计算_alertView的高度
        _alertView.frame=CGRectMake((DEVICE_SIZE.width - AlertView_W)/2, 64 + 32, AlertView_W, _messageLab.frame.size.height + _titleLab.frame.size.height + 40* autoLayoutY + 46* autoLayoutY* 2 + 80);
        [self addSubview:_alertView];
//        [_alertView addSubview:_titleBackView];
        [_alertView addSubview:_titleLab];
        [_alertView addSubview:_messageLab];
        
        if (otherBtnTitle) {
            _otherBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_otherBtn setTitle:cancelTitle forState:UIControlStateNormal];
            [_otherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_otherBtn setBackgroundImage:[UIImage imageWithColor:kGlobalColor] forState:UIControlStateNormal];
            [_otherBtn setBackgroundImage:[UIImage imageWithColor:kGlobalHighlightColor] forState:UIControlStateHighlighted];
            _otherBtn.layer.masksToBounds = YES;
            _otherBtn.layer.cornerRadius = kCustonButtonHeight/2;

            _otherBtn.titleLabel.font=kFont(16 * autoLayoutY);
            [_otherBtn addTarget:self action:@selector(btnPwdClick:) forControlEvents:UIControlEventTouchUpInside];
            _otherBtn.frame = CGRectMake((AlertView_W - 180)/2, _alertView.frame.size.height - 46* autoLayoutY* 2, 180, kCustonButtonHeight);
            [_alertView addSubview:_otherBtn];
        }
        
        if (cancelTitle) {
            _cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_cancelBtn setTitle:otherBtnTitle forState:UIControlStateNormal];
            [_cancelBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
            [_cancelBtn setTitleColor:kColor(143, 143, 152) forState:UIControlStateHighlighted];
            [_cancelBtn setBackgroundColor:[UIColor whiteColor]];
            _cancelBtn.titleLabel.font=kFont(16 * autoLayoutY);
            [_cancelBtn addTarget:self action:@selector(btnPwdClick:) forControlEvents:UIControlEventTouchUpInside];
            _cancelBtn.frame = CGRectMake((AlertView_W - 180)/2, _alertView.frame.size.height - kCustonButtonHeight, 180, kCustonButtonHeight);
            [_alertView addSubview:_cancelBtn];
        }
        
        _cancelBtn.tag=0;
        _otherBtn.tag=1;
        
        self.pwdBlock = pwdBlock;
    }
    return self;
}

-(void)backgroundClick
{
    if (!_dontDissmiss) {
        [self dismissAlertView];
        
        [self btnClick:_cancelBtn];
    }
}

-(void)btnClick:(UIButton *)btn{
    
    if (self.clickBlock) {
        self.clickBlock(btn.tag);
    }
    if (!_dontDissmiss) {
        [self dismissAlertView];
    }
    
}
- (void)btnPwdClick:(UIButton *)btn{
    
    if (self.pwdBlock) {
        self.pwdBlock(_pwdTextField.text,btn.tag);
    }
    if (!_dontDissmiss) {
        [self dismissAlertView];
    }
}
-(void)setDontDissmiss:(BOOL)dontDissmiss{
    _dontDissmiss=dontDissmiss;
}

-(void)showLXAlertView{
    
    _alertWindow=[[UIWindow alloc] initWithFrame:MainScreenRect];
    _alertWindow.windowLevel=UIWindowLevelAlert;
    [_alertWindow becomeKeyWindow];
    [_alertWindow makeKeyAndVisible];
    
    [_alertWindow addSubview:self];
    
    [self setShowAnimation];
    
}

-(void)dismissAlertView{
    [self removeFromSuperview];
    _alertWindow = nil;
    [_alertWindow resignKeyWindow];
}

-(void)setShowAnimation{
    
    switch (_animationStyle) {
            
        case LXASAnimationDefault:
        {
            [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [_alertView.layer setValue:@(0) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.16 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [_alertView.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.09 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        [_alertView.layer setValue:@(.98) forKeyPath:@"transform.scale"];
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.05 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            [_alertView.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }];
        }
            break;
            
        case LXASAnimationLeftShake:{
    
            CGPoint startPoint = CGPointMake(-AlertView_W, self.center.y);
            _alertView.layer.position=startPoint;
            
            //damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
            //velocity:弹性复位的速度
            [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                _alertView.layer.position=self.center;
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        case LXASAnimationTopShake:{
            
            CGPoint startPoint = CGPointMake(self.center.x, -_alertView.frame.size.height);
            _alertView.layer.position=startPoint;
            
            //damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
            //velocity:弹性复位的速度
            [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                _alertView.layer.position=self.center;
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        case LXASAnimationNO:{
            
        }
            
            break;
            
        default:
            break;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.pwdBlock) {
        self.pwdBlock(_pwdTextField.text,1);
    }
    if (!_dontDissmiss) {
        [self dismissAlertView];
    }
    return YES;
}

-(void)setAnimationStyle:(LXAShowAnimationStyle)animationStyle{
    _animationStyle=animationStyle;
}

@end


@implementation UIImage (Colorful)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
