//
//  VRGCalendarView.m
//  Vurig
//
//  Created by in 't Veen Tjeerd on 5/8/12.
//  Copyright (c) 2012 Vurig Media. All rights reserved.
//

#import "VRGCalendarView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSDate+convenience.h"
#import "NSMutableArray+convenience.h"
#import "UIView+convenience.h"

@interface VRGCalendarView ()

@property(nonatomic,strong)NSDictionary * dataDic;

@property(nonatomic,strong)NSArray * MonthDataArr;

@property(nonatomic,strong)NSMutableArray * imageArr;

@end

#define  riliBlue [UIColor colorWithRed:0.6353 green:0.8510 blue:0.9804 alpha:1].CGColor
#define  riliRed   [UIColor colorWithRed:0.9216 green:0.0431 blue:0.1451 alpha:1].CGColor
#define  riliYellow [UIColor colorWithRed:0.9765 green:0.9608 blue:0.1765 alpha:1].CGColor

@implementation VRGCalendarView
@synthesize currentMonth,delegate,labelCurrentMonth, animationView_A,animationView_B;
@synthesize markedDates,markedColors,calendarHeight,selectedDate;

#pragma mark - Select Date
-(void)selectDate:(int)date {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:self.currentMonth];
    [comps setDay:date];
    self.selectedDate = [gregorian dateFromComponents:comps];
    
    
    int selectedDateYear = [selectedDate year];
    int selectedDateMonth = [selectedDate month];
    int currentMonthYear = [currentMonth year];
    int currentMonthMonth = [currentMonth month];
    
    if (selectedDateYear < currentMonthYear) {
        [self showPreviousMonth];
    } else if (selectedDateYear > currentMonthYear) {
        [self showNextMonth];
    } else if (selectedDateMonth < currentMonthMonth) {
        [self showPreviousMonth];
    } else if (selectedDateMonth > currentMonthMonth) {
        [self showNextMonth];
    } else {
        [self setNeedsDisplay];
    }
    
    [self performSelector:@selector(selectDateDelegate) withObject:nil afterDelay:0.05];
    
}

-(void)selectDateDelegate
{
    if ([delegate respondsToSelector:@selector(calendarView:dateSelected:)]) [delegate calendarView:self dateSelected:self.selectedDate];
    
}

#pragma mark - Mark Dates
//NSArray can either contain NSDate objects or NSNumber objects with an int of the day.
-(void)markDates:(NSArray *)dates {
    self.markedDates = dates;
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<[dates count]; i++) {
        [colors addObject:[UIColor colorWithHexString:@"0x383838"]];
    }
    
    self.markedColors = [NSArray arrayWithArray:colors];
    [colors release];
    
    [self setNeedsDisplay];
}

//NSArray can either contain NSDate objects or NSNumber objects with an int of the day.
-(void)markDates:(NSArray *)dates withColors:(NSArray *)colors {
    self.markedDates = dates;
    self.markedColors = colors;
    
    [self setNeedsDisplay];
}

#pragma mark - Set date to now
-(void)reset {
    NSCalendar *gregorian = [[[NSCalendar alloc]
                              initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
    
    // gyc  add 中国区
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [gregorian setTimeZone:gmt];
    // gyc
    
    NSDateComponents *components =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                           NSDayCalendarUnit) fromDate: [NSDate date]];
    self.currentMonth = [gregorian dateFromComponents:components]; //clean month
    
    [self updateSize];
    [self setNeedsDisplay];
    [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:NO];
}

#pragma mark - Next & Previous
-(void)showNextMonth {
    if (isAnimating) return;
    self.markedDates=nil;
    isAnimating=YES;
    prepAnimationNextMonth=YES;
    
    [self setNeedsDisplay];
    
    int lastBlock = [currentMonth firstWeekDayInMonth]+[currentMonth numDaysInMonth]-1;
    int numBlocks = [self numRows]*7;
    BOOL hasNextMonthDays = lastBlock<numBlocks;
    
    //Old month
    float oldSize = self.calendarHeight;
    UIImage *imageCurrentMonth = [self drawCurrentState];
    
    //New month
    self.currentMonth = [currentMonth offsetMonth:1];
    if ([delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight: animated:)]) [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:YES];
    prepAnimationNextMonth=NO;
    [self setNeedsDisplay];
    
    UIImage *imageNextMonth = [self drawCurrentState];
    float targetSize = fmaxf(oldSize, self.calendarHeight);
    UIView *animationHolder = [[UIView alloc] initWithFrame:CGRectMake(0, kVRGCalendarViewTopBarHeight, kVRGCalendarViewWidth, targetSize-kVRGCalendarViewTopBarHeight)];
    [animationHolder setClipsToBounds:YES];
    [self addSubview:animationHolder];
    [animationHolder release];
    
    //Animate
    self.animationView_A = [[[UIImageView alloc] initWithImage:imageCurrentMonth]autorelease];
    self.animationView_B = [[[UIImageView alloc] initWithImage:imageNextMonth]autorelease];
    [animationHolder addSubview:animationView_A];
    [animationHolder addSubview:animationView_B];
    
    if (hasNextMonthDays) {
        animationView_B.frameY = animationView_A.frameY + animationView_A.frameHeight - (kVRGCalendarViewDayHeight+3);
    } else {
        animationView_B.frameY = animationView_A.frameY + animationView_A.frameHeight -3;
    }
    
    //Animation
    __block VRGCalendarView *blockSafeSelf = self;
    [UIView animateWithDuration:.35
                     animations:^{
                         [self updateSize];
                         //blockSafeSelf.frameHeight = 100;
                         if (hasNextMonthDays) {
                             animationView_A.frameY = -animationView_A.frameHeight + kVRGCalendarViewDayHeight+3;
                         } else {
                             animationView_A.frameY = -animationView_A.frameHeight + 3;
                         }
                         animationView_B.frameY = 0;
                     }
                     completion:^(BOOL finished) {
                         [animationView_A removeFromSuperview];
                         [animationView_B removeFromSuperview];
                         blockSafeSelf.animationView_A=nil;
                         blockSafeSelf.animationView_B=nil;
                         isAnimating=NO;
                         [animationHolder removeFromSuperview];
                     }
     ];
}

-(void)showPreviousMonth {
    if (isAnimating) return;
    isAnimating=YES;
    self.markedDates=nil;
    //Prepare current screen
    prepAnimationPreviousMonth = YES;
    [self setNeedsDisplay];
    BOOL hasPreviousDays = [currentMonth firstWeekDayInMonth]>1;
    float oldSize = self.calendarHeight;
    UIImage *imageCurrentMonth = [self drawCurrentState];
    
    //Prepare next screen
    self.currentMonth = [currentMonth offsetMonth:-1];
    if ([delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight:animated:)]) [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:YES];
    prepAnimationPreviousMonth=NO;
    [self setNeedsDisplay];
    UIImage *imagePreviousMonth = [self drawCurrentState];
    
    float targetSize = fmaxf(oldSize, self.calendarHeight);
    UIView *animationHolder = [[UIView alloc] initWithFrame:CGRectMake(0, kVRGCalendarViewTopBarHeight, kVRGCalendarViewWidth, targetSize-kVRGCalendarViewTopBarHeight)];
    
    [animationHolder setClipsToBounds:YES];
    [self addSubview:animationHolder];
    [animationHolder release];
    
    self.animationView_A = [[[UIImageView alloc] initWithImage:imageCurrentMonth]autorelease];
    self.animationView_B = [[[UIImageView alloc] initWithImage:imagePreviousMonth]autorelease];
    [animationHolder addSubview:animationView_A];
    [animationHolder addSubview:animationView_B];
    
    if (hasPreviousDays) {
        animationView_B.frameY = animationView_A.frameY - (animationView_B.frameHeight-kVRGCalendarViewDayHeight) + 3;
    } else {
        animationView_B.frameY = animationView_A.frameY - animationView_B.frameHeight + 3;
    }
    
    __block VRGCalendarView *blockSafeSelf = self;
    [UIView animateWithDuration:.35
                     animations:^{
                         [self updateSize];
                         
                         if (hasPreviousDays) {
                             animationView_A.frameY = animationView_B.frameHeight-(kVRGCalendarViewDayHeight+3);
                             
                         } else {
                             animationView_A.frameY = animationView_B.frameHeight-3;
                         }
                         
                         animationView_B.frameY = 0;
                     }
                     completion:^(BOOL finished) {
                         [animationView_A removeFromSuperview];
                         [animationView_B removeFromSuperview];
                         blockSafeSelf.animationView_A=nil;
                         blockSafeSelf.animationView_B=nil;
                         isAnimating=NO;
                         [animationHolder removeFromSuperview];
                     }
     ];
}


#pragma mark - update size & row count
-(void)updateSize {
    self.frameHeight = self.calendarHeight;
    [self setNeedsDisplay];
}

-(float)calendarHeight {
    return kVRGCalendarViewTopBarHeight + [self numRows]*(kVRGCalendarViewDayHeight+2)+1;
}

-(int)numRows {
    float lastBlock = [self.currentMonth numDaysInMonth]+([self.currentMonth firstWeekDayInMonth]-1);
    return ceilf(lastBlock/7);
}

#pragma mark - Touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    self.selectedDate=nil;
    
    //Touch a specific day
    if (touchPoint.y > kVRGCalendarViewTopBarHeight) {
        float xLocation = touchPoint.x;
        float yLocation = touchPoint.y-kVRGCalendarViewTopBarHeight;
        
        int column = floorf(xLocation/(kVRGCalendarViewDayWidth+2));
        int row = floorf(yLocation/(kVRGCalendarViewDayHeight+2));
        
        int blockNr = (column+1)+row*7;
        int firstWeekDay = [self.currentMonth firstWeekDayInMonth]-1; //-1 because weekdays begin at 1, not 0
        int date = blockNr-firstWeekDay;
        [self selectDate:date];
        return;
    }
    
    self.markedDates=nil;
    self.markedColors=nil;
    
    CGRect rectArrowLeft = CGRectMake(0, 0, 50, 40);
    CGRect rectArrowRight = CGRectMake(self.frame.size.width-50, 0, 50, 40);
    
    //Touch either arrows or month in middle
    if (CGRectContainsPoint(rectArrowLeft, touchPoint)) {
        [self showPreviousMonth];
    } else if (CGRectContainsPoint(rectArrowRight, touchPoint)) {
        [self showNextMonth];
    } else if (CGRectContainsPoint(self.labelCurrentMonth.frame, touchPoint)) {
        //Detect touch in current month
        int currentMonthIndex = [self.currentMonth month];
        int todayMonth = [[NSDate date] month];
        [self reset];
        if ((todayMonth!=currentMonthIndex) && [delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight:animated:)]) [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:NO];
    }
}

#pragma mark - rilixianshi
-(void)reDisplayViewUse:(NSArray *)data{
   
    self.MonthDataArr = data;
    [self setNeedsDisplay];
}


#pragma mark - Drawing
- (void)drawRect:(CGRect)rect
{
    
    
    
    int firstWeekDay = [self.currentMonth firstWeekDayInMonth]-1; //-1 because weekdays begin at 1, not 0
    
     [self setClearsContextBeforeDrawing: YES];
    
    for (UIView * subView in self.subviews) {
        if (subView == self.labelCurrentMonth || subView == self.animationView_A || subView == animationView_B) {
        }else{
        
            [subView removeFromSuperview];
        }
    }
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM yyyy"];
    labelCurrentMonth.text = [formatter stringFromDate:self.currentMonth];
    [labelCurrentMonth sizeToFit];
    labelCurrentMonth.frameX = roundf(self.frame.size.width/2 - labelCurrentMonth.frameWidth/2);
    labelCurrentMonth.frameY = 10;
    [formatter release];
    [currentMonth firstWeekDayInMonth];
    
    CGContextClearRect(UIGraphicsGetCurrentContext(),rect);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rectangle = CGRectMake(0,0,self.frame.size.width,kVRGCalendarViewTopBarHeight);
    CGContextAddRect(context, rectangle);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);  // gyc change 2014-11-24  white -> clear
    CGContextFillPath(context);
    
    //Arrows
    int arrowSize = 12;
    int xmargin = 20;
    int ymargin = 18;
    
    //Arrow Left
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, xmargin+arrowSize/1.5, ymargin);
    CGContextAddLineToPoint(context,xmargin+arrowSize/1.5,ymargin+arrowSize);
    CGContextAddLineToPoint(context,xmargin,ymargin+arrowSize/2);
    CGContextAddLineToPoint(context,xmargin+arrowSize/1.5, ymargin);
    
    CGContextSetFillColorWithColor(context,
                                   [UIColor blackColor].CGColor);
    CGContextFillPath(context);
    
    //Arrow right
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.frame.size.width-(xmargin+arrowSize/1.5), ymargin);
    CGContextAddLineToPoint(context,self.frame.size.width-xmargin,ymargin+arrowSize/2);
    CGContextAddLineToPoint(context,self.frame.size.width-(xmargin+arrowSize/1.5),ymargin+arrowSize);
    CGContextAddLineToPoint(context,self.frame.size.width-(xmargin+arrowSize/1.5), ymargin);
    
    CGContextSetFillColorWithColor(context,
                                   [UIColor blackColor].CGColor);
    CGContextFillPath(context);
    
   
    
    // gyc add  周几 背景色
    CGContextAddRect(context, (CGRect){0,kVRGCalendarViewTopBarHeight-25,kVRGCalendarViewWidth,25});
    CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0x00385d"].CGColor);
    CGContextFillPath(context);
    
    
    //Weekdays
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=@"EEE";
    //always assume gregorian with monday first
    NSMutableArray *weekdays = [[NSMutableArray alloc] initWithArray:[dateFormatter shortWeekdaySymbols]];
    [weekdays moveObjectFromIndex:0 toIndex:6];
    
    CGContextSetFillColorWithColor(context,
                                   [UIColor colorWithHexString:@"0xb7d9eb"].CGColor); // gyc change
    for (int i =0; i<[weekdays count]; i++) {
        NSString *weekdayValue = (NSString *)[weekdays objectAtIndex:i];
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [weekdayValue drawInRect:CGRectMake(i*(kVRGCalendarViewDayWidth+2), 40, kVRGCalendarViewDayWidth+2, 20) withFont:font lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
        
    }
    
    
    int numRows = [self numRows];
    
    CGContextSetAllowsAntialiasing(context, NO);
    
    //Grid background
    float gridHeight = numRows*(kVRGCalendarViewDayHeight+2)+1;
    CGRect rectangleGrid = CGRectMake(0,kVRGCalendarViewTopBarHeight,self.frame.size.width,gridHeight);
    CGContextAddRect(context, rectangleGrid);
    CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0xa9c6d7"].CGColor);  // gyc change 0xf3f3f3 -> 0xa9c6d7
    //CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0xff0000"].CGColor);
    CGContextFillPath(context);
    
    //Grid white lines
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, kVRGCalendarViewTopBarHeight+1);
    CGContextAddLineToPoint(context, kVRGCalendarViewWidth, kVRGCalendarViewTopBarHeight+1);
    for (int i = 1; i<7; i++) {
        CGContextMoveToPoint(context, i*(kVRGCalendarViewDayWidth+1)+i*1-1, kVRGCalendarViewTopBarHeight);
        CGContextAddLineToPoint(context, i*(kVRGCalendarViewDayWidth+1)+i*1-1, kVRGCalendarViewTopBarHeight+gridHeight);
        
        if (i>numRows-1) continue;
        //rows
        CGContextMoveToPoint(context, 0, kVRGCalendarViewTopBarHeight+i*(kVRGCalendarViewDayHeight+1)+i*1+1);
        CGContextAddLineToPoint(context, kVRGCalendarViewWidth, kVRGCalendarViewTopBarHeight+i*(kVRGCalendarViewDayHeight+1)+i*1+1);
    }
    
    CGContextStrokePath(context);
    
    //Grid dark lines
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"0xcfd4d8"].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, kVRGCalendarViewTopBarHeight);
    CGContextAddLineToPoint(context, kVRGCalendarViewWidth, kVRGCalendarViewTopBarHeight);
    for (int i = 1; i<7; i++) {
        //columns
        CGContextMoveToPoint(context, i*(kVRGCalendarViewDayWidth+1)+i*1, kVRGCalendarViewTopBarHeight);
        CGContextAddLineToPoint(context, i*(kVRGCalendarViewDayWidth+1)+i*1, kVRGCalendarViewTopBarHeight+gridHeight);
        
        if (i>numRows-1) continue;
        //rows
        CGContextMoveToPoint(context, 0, kVRGCalendarViewTopBarHeight+i*(kVRGCalendarViewDayHeight+1)+i*1);
        CGContextAddLineToPoint(context, kVRGCalendarViewWidth, kVRGCalendarViewTopBarHeight+i*(kVRGCalendarViewDayHeight+1)+i*1);
    }
    CGContextMoveToPoint(context, 0, gridHeight+kVRGCalendarViewTopBarHeight);
    CGContextAddLineToPoint(context, kVRGCalendarViewWidth, gridHeight+kVRGCalendarViewTopBarHeight);
    
    CGContextStrokePath(context);
    
    CGContextSetAllowsAntialiasing(context, YES);
    
    //Draw days
    CGContextSetFillColorWithColor(context,
                                   [UIColor colorWithHexString:@"0x383838"].CGColor);
    
    ////NSLog(@"currentMonth month = %i, first weekday in month = %i",[self.currentMonth month],[self.currentMonth firstWeekDayInMonth]);
    
    int numBlocks = numRows*7;
    NSDate *previousMonth = [self.currentMonth offsetMonth:-1];
    int currentMonthNumDays = [currentMonth numDaysInMonth];
    int prevMonthNumDays = [previousMonth numDaysInMonth];
    
    int selectedDateBlock = ([selectedDate day]-1)+firstWeekDay;
    
    //prepAnimationPreviousMonth nog wat mee doen
    
    //prev next month
    BOOL isSelectedDatePreviousMonth = prepAnimationPreviousMonth;
    BOOL isSelectedDateNextMonth = prepAnimationNextMonth;
    
    if (self.selectedDate!=nil) {
        isSelectedDatePreviousMonth = ([selectedDate year]==[currentMonth year] && [selectedDate month]<[currentMonth month]) || [selectedDate year] < [currentMonth year];
        
        if (!isSelectedDatePreviousMonth) {
            isSelectedDateNextMonth = ([selectedDate year]==[currentMonth year] && [selectedDate month]>[currentMonth month]) || [selectedDate year] > [currentMonth year];
        }
    }
    
    if (isSelectedDatePreviousMonth) {
        int lastPositionPreviousMonth = firstWeekDay-1;
        selectedDateBlock=lastPositionPreviousMonth-([selectedDate numDaysInMonth]-[selectedDate day]);
    } else if (isSelectedDateNextMonth) {
        selectedDateBlock = [currentMonth numDaysInMonth] + (firstWeekDay-1) + [selectedDate day];
    }
    
    
    NSDate *todayDate = [NSDate date];
    int todayBlock = -1;
    
    //    //NSLog(@"currentMonth month = %i day = %i, todaydate day = %i",[currentMonth month],[currentMonth day],[todayDate month]);
    
    if ([todayDate month] == [currentMonth month] && [todayDate year] == [currentMonth year]) {
        todayBlock = [todayDate day] + firstWeekDay - 1;
    }
    
    NSDateFormatter* monthdateFormatter=[[NSDateFormatter alloc] init];
    [monthdateFormatter setDateFormat:@"yyyy-MM"];
    
    
    // gyc change add
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);

    BOOL  isCurrentMonth = [KFSBHelper isCurrentMonthByDate:self.currentMonth]; // 是否是当前月份
    BOOL  isWeekend; // 是否周末 一个 日期字符串
    int  isEarly;
    UIColor * drawColor = nil;
    UIColor * textDrawColor;
    NSString * everyDay;
    NSString * surestart;
    NSString * planstart;
    UIImageView * sureImageView;
    UIImageView * planImageView;
    CGFloat  minWH = (( kVRGCalendarViewDayWidth > kVRGCalendarViewDayHeight )? kVRGCalendarViewDayHeight : kVRGCalendarViewDayWidth);

    for (int i=0; i<numBlocks; i++) {
        int targetDate = i;
        int targetColumn = i%7;
        int targetRow = i/7;
        int targetX = targetColumn * (kVRGCalendarViewDayWidth+2) ;
        int targetY = kVRGCalendarViewTopBarHeight + targetRow * (kVRGCalendarViewDayHeight+2) +2;// gyc add +2
        
        //draw selected date
        if (selectedDate && i==selectedDateBlock) {
            CGRect rectangleGrid = CGRectMake(targetX,targetY,kVRGCalendarViewDayWidth+2,kVRGCalendarViewDayHeight+2);
            CGContextAddRect(context, rectangleGrid);
            CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0x00385e"].CGColor); // gyc change  // 选中背景色
            CGContextFillPath(context);
            
            CGContextSetFillColorWithColor(context,
                                           [UIColor whiteColor].CGColor); // 文字颜色
        } else if (todayBlock==i) {
            CGRect rectangleGrid = CGRectMake(targetX,targetY,kVRGCalendarViewDayWidth+2,kVRGCalendarViewDayHeight+2);
            CGContextAddRect(context, rectangleGrid);
            CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.6549 green:0.0392 blue:0.2353 alpha:1].CGColor);  // gyc change 当天的 背景色
            CGContextFillPath(context);
            
            CGContextSetFillColorWithColor(context,
                                           [UIColor whiteColor].CGColor); // 文字颜色
        }
        
        // BOOL isCurrentMonth = NO;
        if (i<firstWeekDay) { //previous month
            targetDate = (prevMonthNumDays-firstWeekDay)+(i+1);
            
            NSDate* previousMonth = [currentMonth offsetMonth:-1];
            NSString* previousmonth=[monthdateFormatter stringFromDate:previousMonth];
            NSString* previousMonthDayString=[previousmonth stringByAppendingFormat:@"-%02d",targetDate];
            
            
            NSString *hex = (isSelectedDatePreviousMonth) ? @"0x7e9cb4" : @"aaaaaa";//(isSelectedDatePreviousMonth) ? @"0x383838" : @"aaaaaa";
            CGContextSetFillColorWithColor(context,
                                           [UIColor colorWithHexString:hex].CGColor);
            
            
        } else if (i>=(firstWeekDay+currentMonthNumDays)) { //next month
            targetDate = (i+1) - (firstWeekDay+currentMonthNumDays);
            
            
            NSDate* nextMonth = [currentMonth offsetMonth:+1];
            NSString* nextmonth=[monthdateFormatter stringFromDate:nextMonth];
            NSString* nextMonthDayString=[nextmonth stringByAppendingFormat:@"-%02d",targetDate];
            
            
            NSString *hex = (isSelectedDateNextMonth) ? @"0x7e9cb4" : @"aaaaaa";
            CGContextSetFillColorWithColor(context,
                                           [UIColor colorWithHexString:hex].CGColor);
            
        } else { //current month
            // isCurrentMonth = YES;
            targetDate = (i-firstWeekDay)+1;
            
            NSString* month=[monthdateFormatter stringFromDate:self.currentMonth];
            //NSLog(@"month is %@",month);
            NSString* currentMonthDayString=[month stringByAppendingFormat:@"-%02d",targetDate];
            
            NSLog(@"currentMonthDay is %@",currentMonthDayString);
            
            // gyc add 当前月份的 每一天
            if (todayBlock == i  || (selectedDate && i==selectedDateBlock)){
            
            }else
            {
                
                // logic  判断当前日期是否是星期6 /7
                isWeekend = [KFSBHelper isWeedendByString:currentMonthDayString];
           
                
                isEarly = [KFSBHelper isEarlyThanNowByString:currentMonthDayString];
                
                if (isEarly == 0) {
                    
                    drawColor = [UIColor colorWithRed:0.6549 green:0.0392 blue:0.2353 alpha:1];
                    
                }else if (isEarly == 1){
                    
                    if (isWeekend) {
                        drawColor = [UIColor colorWithHexString:@"0x8197a9"];
                        
                    }else{
                        
                        drawColor = [UIColor colorWithHexString:@"0xa9c6d7"];
                    }
                    
                }else{
                    
                    if (isWeekend) {
                        
                        drawColor = [UIColor colorWithHexString:@"0x2c718d"];
                    }else{
                        
                        drawColor = [UIColor colorWithRed:0.8980 green:0.9647 blue:0.9882 alpha:1];
                    }
    
                }
              
                
                CGRect rectangleGrid = CGRectMake(targetX,targetY,kVRGCalendarViewDayWidth+1,kVRGCalendarViewDayHeight+1);
                CGContextAddRect(context, rectangleGrid);
                CGContextSetFillColorWithColor(context, drawColor.CGColor);
                CGContextFillPath(context);
                
                
                //  原先 添加图片位置
                
            }
            // 添加图片
            for (NSDictionary * obj in self.MonthDataArr) {
                everyDay = [obj objectForKey:@"date"];
                if ([everyDay isEqualToString:currentMonthDayString]) {
                    
                    surestart = [obj objectForKey:@"surestart"];
                    planstart = [obj objectForKey:@"planstart"];
                    if ([surestart isEqualToString:@"1"]) {
                        
                        if ([planstart isEqualToString:@"1"]) {
                            sureImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"k.png"]] autorelease];
                            planImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xin.png"]] autorelease];
                            sureImageView.contentMode = UIViewContentModeScaleAspectFit;
                            planImageView.contentMode = UIViewContentModeScaleAspectFit;
                            planImageView.transform = CGAffineTransformMakeRotation(M_PI);
                            sureImageView.frame = (CGRect){targetX,targetY,floor(minWH/3),floor(minWH/3)};
                            planImageView.frame = (CGRect){targetX + floor(minWH/3*2) ,targetY,floor(minWH/3),floor(minWH/3)};
                            
                            
                            [self addSubview:sureImageView];
                            [self addSubview:planImageView];
                            
                            
                        }else{
                            
                            sureImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"k.png"]] autorelease];
                            sureImageView.contentMode = UIViewContentModeScaleAspectFit;
                            sureImageView.frame = (CGRect){targetX,targetY,floor(minWH/3),floor(minWH/3)};
                            [self addSubview:sureImageView];
                            
                        }
                        
                    }else{
                        
                        if ([planstart isEqualToString:@"1"]) {
                            
                            planImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xin.png"]] autorelease];
                            planImageView.contentMode = UIViewContentModeScaleAspectFit;
                            planImageView.frame = (CGRect){targetX ,targetY,floor(minWH/3),floor(minWH/3)};
                            [self addSubview:planImageView];
                            
                        }else{
                            
                            
                        }
                    }
                }
            }

   
            // 设置文字颜色
            NSString *hex = (isSelectedDatePreviousMonth || isSelectedDateNextMonth) ? @"0x27c4ea" : @"0x7e9cb4";
            CGContextSetFillColorWithColor(context,
                                           [UIColor colorWithHexString:hex].CGColor);
            
        }
        
        
        NSString *date = [NSString stringWithFormat:@"%i",targetDate];
        [date drawInRect:CGRectMake(targetX, targetY + kVRGCalendarViewDayHeight/3.0, kVRGCalendarViewDayWidth, kVRGCalendarViewDayHeight) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
    }
    
    CGContextClosePath(context);
    
    //Draw markings
    if (!self.markedDates || isSelectedDatePreviousMonth || isSelectedDateNextMonth) return;
    
    for (int i = 0; i<[self.markedDates count]; i++) {
        id markedDateObj = [self.markedDates objectAtIndex:i];
        
        int targetDate;
        if ([markedDateObj isKindOfClass:[NSNumber class]]) {
            targetDate = [(NSNumber *)markedDateObj intValue];
        } else if ([markedDateObj isKindOfClass:[NSDate class]]) {
            NSDate *date = (NSDate *)markedDateObj;
            targetDate = [date day];
        } else {
            continue;
        }
        
        
        int targetBlock = firstWeekDay + (targetDate-1);
        int targetColumn = targetBlock%7;
        int targetRow = targetBlock/7;
        
        int targetX = targetColumn * (kVRGCalendarViewDayWidth+2) + 7;
        int targetY = kVRGCalendarViewTopBarHeight + targetRow * (kVRGCalendarViewDayHeight+2) + 38;
        
        CGRect rectangle = CGRectMake(targetX,targetY,32,2);
        CGContextAddRect(context, rectangle);
        
        UIColor *color;
        if (selectedDate && selectedDateBlock==targetBlock) {
            color = [UIColor whiteColor];
        }  else if (todayBlock==targetBlock) {
            color = [UIColor whiteColor];
        } else {
            color  = (UIColor *)[markedColors objectAtIndex:i];
        }
        
        
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillPath(context);
    }
    
    
    [monthdateFormatter release];
}

#pragma mark - Draw image for animation
-(UIImage *)drawCurrentState {
    float targetHeight = kVRGCalendarViewTopBarHeight + [self numRows]*(kVRGCalendarViewDayHeight+2)+1;
    
    UIGraphicsBeginImageContext(CGSizeMake(kVRGCalendarViewWidth, targetHeight-kVRGCalendarViewTopBarHeight));
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(c, 0, -kVRGCalendarViewTopBarHeight);    // <-- shift everything up by 40px when drawing.
    [self.layer renderInContext:c];
    UIImage* viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

#pragma mark - Init
-(id)init {
    self = [super initWithFrame:CGRectMake(0, 0, kVRGCalendarViewWidth, 0)];
    if (self) {
        self.contentMode = UIViewContentModeTop;
        self.clipsToBounds=YES;
        self.backgroundColor = [UIColor clearColor]; // gyc add 2014-11-24
        
        isAnimating=NO;
        self.labelCurrentMonth = [[[UILabel alloc] initWithFrame:CGRectMake(34, 0, kVRGCalendarViewWidth-68, 40)]autorelease];
        [self addSubview:labelCurrentMonth];
        labelCurrentMonth.backgroundColor=[UIColor whiteColor];
        labelCurrentMonth.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
        labelCurrentMonth.textColor = [UIColor colorWithHexString:@"0x00385d"];// gyc change
        labelCurrentMonth.textAlignment = UITextAlignmentCenter;
        
        labelCurrentMonth.backgroundColor = [UIColor clearColor]; // gyc add 2014-11-24
        self.imageArr = [NSMutableArray array];
        
        [self performSelector:@selector(reset) withObject:nil afterDelay:0.1]; //so delegate can be set after init and still get called on init
        //        [self reset];
    }
    return self;
}


-(void)dealloc {
    
    self.delegate=nil;
    self.currentMonth=nil;
    self.labelCurrentMonth=nil;
    
    self.markedDates=nil;
    self.markedColors=nil;
    
    [super dealloc];
}


#pragma mark - gyc add 2014-11-19 
#pragma mark - fit pass bounds
-(CGFloat)getkVRGCalendarViewWidth{
    
    if (self.KCanlendarWidthMax  > 0) {
        return self.KCanlendarWidthMax;
    }else{
    
        return (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad?320:224);
    }
}
-(CGFloat)getkVRGCalendarViewHeight{

    if (self.KCanlendarHeightMax > 0) {
        return self.KCanlendarHeightMax;
    }else{
    
        return (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad?320:224);
    }
}

-(CGFloat)getkVRGCalendarViewDayWidth{
    
    return  floor(([self getkVRGCalendarViewWidth]/7.0 -2));
}
-(CGFloat)getkVRGCalendarViewDayHeight{

 return   floor((([self getkVRGCalendarViewHeight] - kVRGCalendarViewTopBarHeight - 1) / ([self numRows]) - 2));
}

-(id)initWithMaxWAndHByBounds:(CGRect)otherbounds{
    
    self.KCanlendarWidthMax = otherbounds.size.width;
    self.KCanlendarHeightMax = otherbounds.size.height;
    
   self = [self init];

    return self;
}

-(void)resetWithMaxWAndHByBounds:(CGRect)otherbounds{

    self.KCanlendarWidthMax = otherbounds.size.width;
    self.KCanlendarHeightMax = otherbounds.size.height;
    
    [self reset];
}





@end
