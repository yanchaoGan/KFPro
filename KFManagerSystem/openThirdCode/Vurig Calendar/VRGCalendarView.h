//
//  VRGCalendarView.h
//  Vurig
//
//  Created by in 't Veen Tjeerd on 5/8/12.
//  Copyright (c) 2012 Vurig Media. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIColor+expanded.h"


#define kVRGCalendarViewTopBarHeight 60


//#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//#ifdef isPad  if(isPad){ \
//  #define kVRGCalendarViewWidth 320  \
//}els{
//    #define kVRGCalendarViewWidth 222\
//}  \
////
////#define kVRGCalendarViewWidth 222
//#endif
#define kVRGCalendarViewWidth   ([self getkVRGCalendarViewWidth])//(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad?320:224)   //gyc orign 320
#define kVRGCalendarViewDayWidth  ([self getkVRGCalendarViewDayWidth]) //(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad?44:42) //gyc orign 44
#define kVRGCalendarViewDayHeight   ([self getkVRGCalendarViewDayHeight])//(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad?44:42) //gyc orign 44

@protocol VRGCalendarViewDelegate;
@interface VRGCalendarView : UIView {
    id <VRGCalendarViewDelegate> delegate;
    
    NSDate *currentMonth;
    
    UILabel *labelCurrentMonth;
    
    BOOL isAnimating;
    BOOL prepAnimationPreviousMonth;
    BOOL prepAnimationNextMonth;
    
    UIImageView *animationView_A;
    UIImageView *animationView_B;
    
    NSArray *markedDates;
    NSArray *markedColors;
}

@property (nonatomic, retain) id <VRGCalendarViewDelegate> delegate;
@property (nonatomic, retain) NSDate *currentMonth;
@property (nonatomic, retain) UILabel *labelCurrentMonth;
@property (nonatomic, retain) UIImageView *animationView_A;
@property (nonatomic, retain) UIImageView *animationView_B;
@property (nonatomic, retain) NSArray *markedDates;
@property (nonatomic, retain) NSArray *markedColors;
@property (nonatomic, getter = calendarHeight) float calendarHeight;
@property (nonatomic, retain, getter = selectedDate) NSDate *selectedDate;

-(void)selectDate:(int)date;
-(void)reset;

-(void)markDates:(NSArray *)dates;
-(void)markDates:(NSArray *)dates withColors:(NSArray *)colors;

-(void)showNextMonth;
-(void)showPreviousMonth;

-(int)numRows;
-(void)updateSize;
-(UIImage *)drawCurrentState;


//gyc
-(void)reDisplayViewUse:(NSArray *)dataDic;



/**
 *  gyc 2014-11-19
 *
 *  @return 得到日历宽度 高度
 */
@property(nonatomic,assign)CGFloat KCanlendarWidthMax;
@property(nonatomic,assign)CGFloat KCanlendarHeightMax;

-(CGFloat)getkVRGCalendarViewWidth;
-(CGFloat)getkVRGCalendarViewDayWidth;
-(CGFloat)getkVRGCalendarViewDayHeight;

-(id)initWithMaxWAndHByBounds:(CGRect)otherbounds;
-(void)resetWithMaxWAndHByBounds:(CGRect)otherbounds;


@end

@protocol VRGCalendarViewDelegate <NSObject>
-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated;
-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date;
@end
