//
//  ContactsHeaderView.m
//  gava
//
//  Created by RICHA on 10/20/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "ContactsHeaderView.h"

@implementation ContactsHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:@"ContactsHeaderview" owner:self options:nil] lastObject];
        self.frame = [[UIScreen mainScreen] bounds];
        
        self.img_userPic.layer.cornerRadius=self.img_userPic.frame.size.width/2;
        self.img_userPic.clipsToBounds=YES;

    }
    return self;
  }


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)btn_AllOption_pressed:(id)sender {
    
    
}
@end
