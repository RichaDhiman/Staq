//
//  AlertView.m
//  gava
//
//  Created by RICHA on 10/6/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)showStaticAlertWithTitle : (NSString *)title AndMessage : (NSString *)msg
{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)showAlertWithOptions : (NSString *)title AndMessage : (NSString *)msg :(NSArray*)options
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:[options firstObject], nil];
    [alert show];
}




@end
