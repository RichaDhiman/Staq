//
//  ContactsTableCell.h
//  gava
//
//  Created by RICHA on 10/19/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_emailOrPhnNo;
@property (strong, nonatomic) IBOutlet UIButton *btn_send;
- (IBAction)btn_send_pressed:(id)sender;

@end
