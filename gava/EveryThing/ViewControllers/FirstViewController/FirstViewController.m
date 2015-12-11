//
//  FirstViewController.m
//  gava
//
//  Created by RICHA on 9/4/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property(nonatomic)CGPoint scrollOffset;
@property(nonatomic)BOOL reverseScroll;
@property(nonatomic)BOOL alreadytrans;
@property BOOL aniFirstTime;
@property BOOL ani;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.interactivePopGestureRecognizer setDelegate:self];
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"user"]!=nil)
    {
        UserProfile *up=[[UserProfile alloc]init];
        up=[UserProfile getProfile];
        
        if ([up.user_id isEqualToString:@""]||up.user_id!=nil)
        {
            UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MainViewController *controller=(MainViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"MainViewController"];
            
            [self.navigationController pushViewController:controller animated:NO];
        }
    }
    
    float height=(([UIScreen mainScreen].bounds.size.width-50)*247)/300;
    self.cnst_collectHt.constant=height+50;
    
}



-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    
    
    self.myPageControl.currentPage=0;
    [self viewHelper];
    
    //[self settingUpTut];
 }


-(void)settingUpTut
{
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
    
    if ([UIScreen mainScreen].bounds.size.height == 667) {
        
        _constraintHeightBottomView.constant = 200;
    }
    
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        
        _constraintHeightBottomView.constant = 100;
    }
    
    if ([UIScreen mainScreen].bounds.size.height == 736) {
        
        _constraintHeightBottomView.constant = 230;
    }
}

#pragma mark-setupui

/*!
 *  @brief  Did everything that i want to do before appearance of viewcontroller like initializaton of objects etc
 */
-(void)viewHelper
{
    self.myPageControl.currentPage=0;
    
    self.btn_fbSignUp.layer.cornerRadius=3;
    self.btn_fbSignUp.clipsToBounds=YES;
    self.btn_fbSignUp.layer.borderWidth=1;
    self.btn_fbSignUp.layer.borderColor=[[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.8] CGColor];
   
    
    self.btn_email.layer.cornerRadius=3;
    self.btn_email.clipsToBounds=YES;
    self.btn_email.layer.borderWidth=1;
    self.btn_email.layer.borderColor=[[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.8] CGColor];
}


#pragma mark-collectionViewControler handling

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        FirstCell *cell = (FirstCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"FirstCell" forIndexPath:indexPath];
        cell.hasAnimated = NO;
        
        cell.cnst_firstimg_tr.constant=0;
        cell.cnst_secimg_tr.constant=0;
        cell.cnst_lastimg_tr.constant=0;
        cell.cnst_firstimg_ld.constant=0;
        cell.cnst_secimg_ld.constant=0;
        cell.cnst_lastimg_ld.constant=0;

        [cell configureCell:@"target_front" :@"nike_slider" :@"walmart_slider" :@"Store all your gift cards on your mobile device for easy accesss."];
        
        return cell;
    }
    else if(indexPath.section==1)
    {
        
        
        FamilyShareCell *cell = (FamilyShareCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"FamilyShareCell" forIndexPath:indexPath];
        cell.hasAnimated = NO;
        
        [cell configureCell:@"person_1" :@"person_2" :@"person_3" :@"Socially share your gift cards with family and friends."];
        // cell.img_familyShare.transform=CGAffineTransformMakeTranslation(+cell.img_familyShare.frame.size.width+30,0);
        
        
        
        return cell;
    }
    else if (indexPath.section==2)
    {
        imgCollectionCell *cell = (imgCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"imgCollectionCell" forIndexPath:indexPath];
        
        cell.hasAnimated = NO;
        [cell configureCell:@"map_slider-1" :@"map_popup-1" :@"Find nearby retailers for cards that you have stored in the Eventure wallet."];
        
        return cell;
        
    }
    else
    {
        ThirdCellCollectionViewCell *cell = (ThirdCellCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ThirdCellCollectionViewCell" forIndexPath:indexPath];
        
        
        cell.hasAnimated = NO;
        [cell configureCell:@"target_slider" :@"Scanner_Line" :@"Use your gift cards and make purchases right in the store from the Eventure wallet."];
        
        return cell;
    }
    
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        FirstCell *cell1 = (FirstCell *)cell;
        
        
        if (self.aniFirstTime==YES) {
            
            self.aniFirstTime=NO;
            cell1.first_img.hidden=YES;
            cell1.Sec_img.hidden=YES;
            cell1.last_img.hidden=YES;
        }
      
        
         if(!self.isAnim)
            {
            self.isAnim = YES;

        
        if (self.reverseScroll==YES) {
            
//            cell1.first_img.hidden=YES;
//            cell1.Sec_img.hidden=YES;
//            cell1.last_img.hidden=YES;
            
            cell1.lbl_title.hidden=NO;
            
//            if (self.alreadytrans==YES) {
//                self.alreadytrans=NO;
//            }
//            else
//            {
//                cell1.first_img.transform=CGAffineTransformMakeTranslation(-cell1.frame.size.width-30,0);
                cell1.Sec_img.transform=CGAffineTransformMakeTranslation(-cell1.frame.size.width-30,0);
                cell1.last_img.transform=CGAffineTransformMakeTranslation(-cell1.frame.size.width-30,0);
               // cell1.lbl_title.transform=CGAffineTransformMakeTranslation(-cell1.frame.size.width-30,0);
           
//            }
            [UIView animateWithDuration:0.40
                                  delay:0.0
                                options:UIViewAnimationOptionTransitionNone
                             animations:^{
                                 //first animation
//                                 cell1.first_img.transform=CGAffineTransformIdentity;
                                   //cell1.lbl_title.transform=CGAffineTransformIdentity;
                                 
                                 cell1.first_img.transform=CGAffineTransformMakeTranslation(+40, 0);
                                 
                             }
                             completion:^(BOOL finished) {
                                 
                                 [UIView animateWithDuration:0.40
                                                       delay:0.0
                                                     options:UIViewAnimationOptionTransitionNone
                                                  animations:^{
                                                      cell1.first_img.transform=CGAffineTransformIdentity;
                                          }
                                                  completion:nil];
                            
                          
                             }];
            
            
           
            
            [UIView animateWithDuration:0.45 animations:^{
                
                cell1.Sec_img.transform=CGAffineTransformMakeTranslation(+40, 0);
            } completion:^(BOOL finished) {
                
                
                [UIView animateWithDuration:0.45
                                      delay:0.0
                                    options:UIViewAnimationOptionTransitionNone
                                 animations:^{
                                        cell1.Sec_img.transform=CGAffineTransformIdentity;
                                 }
                                 completion:nil];
                

             

            }];
            
            [UIView animateWithDuration:0.50 animations:^{
                cell1.last_img.transform=CGAffineTransformMakeTranslation(+40, 0);
            } completion:^(BOOL finished) {
           
                [UIView animateWithDuration:0.50
                                      delay:0.0
                                    options:UIViewAnimationOptionTransitionNone
                                 animations:^{
                                        cell1.last_img.transform=CGAffineTransformIdentity;
                                 }
                                 completion:nil];

                
            }];
            
        
        }
        else
        {
            self.aniFirstTime=YES;
            
            cell1.first_img.transform=CGAffineTransformMakeTranslation(+cell1.frame.size.width+30,0);
            //cell1.lbl_title.transform=CGAffineTransformMakeTranslation(+cell1.frame.size.width+30,0);
            cell1.Sec_img.transform=CGAffineTransformMakeTranslation(+cell1.frame.size.width+30,0);
            cell1.last_img.transform=CGAffineTransformMakeTranslation(+cell1.frame.size.width+30,0);
            
  
            
            [UIView animateWithDuration:0.50
                                  delay:0.5
                                options:UIViewAnimationOptionTransitionNone
                             animations:^{
                                 //first animation
                                // cell1.first_img.transform=CGAffineTransformIdentity;
                                // cell1.lbl_title.transform=CGAffineTransformIdentity;
                                 
                                 cell1.first_img.transform=CGAffineTransformMakeTranslation(-40, 0);
                     
                             }
                             completion:^(BOOL finished) {
                                 
                                 [UIView animateWithDuration:0.50
                                                       delay:0.0
                                                     options:UIViewAnimationOptionTransitionNone
                                                  animations:^{
                                                      cell1.first_img.transform=CGAffineTransformIdentity;
                                                  }
                                                  completion:nil];
                                 
                             }];
            
            
            [UIView animateWithDuration:0.55 delay:0.5 options:UIViewAnimationOptionTransitionNone animations:^{
                cell1.Sec_img.transform=CGAffineTransformMakeTranslation(-40, 0);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.55
                                      delay:0.0
                                    options:UIViewAnimationOptionTransitionNone
                                 animations:^{
                                     cell1.Sec_img.transform=CGAffineTransformIdentity;                                 }
                                 completion:nil];
                

            }];
            
            
            [UIView animateWithDuration:0.60 delay:0.5 options:UIViewAnimationOptionTransitionNone animations:^{
                 cell1.last_img.transform=CGAffineTransformMakeTranslation(-40, 0);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.60
                                      delay:0.0
                                    options:UIViewAnimationOptionTransitionNone
                                 animations:^{
                                     cell1.last_img.transform=CGAffineTransformIdentity;                              }
                                 completion:nil];
                
                
                
            }];

            
        }
        
    }
    }
    
    
    else if(indexPath.section==1)
    {
        self.alreadytrans=NO;
        FamilyShareCell *cell2 = (FamilyShareCell*)cell;
       // NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
       // FirstCell *cell5 = (FirstCell*)[self.myCollectionView cellForItemAtIndexPath:newIndexPath];
        
        cell2.imgPer1.hidden=YES;
        cell2.imgPer2.hidden=YES;
        cell2.imgPer3.hidden=YES;
        cell2.lbl_title.hidden=YES;
        
//        [UIView animateWithDuration:0.40
//                              delay:0.0
//                            options:UIViewAnimationOptionTransitionNone
//                         animations:^{
//                             //first animation
//                             
//                             cell5.first_img.transform=CGAffineTransformMakeTranslation(-cell5.frame.size.width-30,0);
//                            // cell5.lbl_title.transform=CGAffineTransformMakeTranslation(-cell5.frame.size.width-30,0);
//                             
//                         }
//                         completion:nil];
//        
//        
//        [UIView animateWithDuration:0.45 animations:^{
//            cell5.Sec_img.transform=CGAffineTransformMakeTranslation(-cell5.frame.size.width-30,0);
//            
//            
//        }];
//        
//        [UIView animateWithDuration:0.50 animations:^{
//            cell5.last_img.transform=CGAffineTransformMakeTranslation(-cell5.frame.size.width-30,0);
//            
//            
//        }];
        
        
        
    }
    else if (indexPath.section==2)
    {
        imgCollectionCell *cell3 = (imgCollectionCell *)cell;
        
        //        cell3.img_logos.transform=CGAffineTransformMakeTranslation(+cell3.frame.size.width,0);
        cell3.img_popup.hidden=YES;
        //        cell3.img_logos.hidden=YES;
        //        cell3.lbl_title.hidden=YES;
        
        
    }
    else
    {
        ThirdCellCollectionViewCell *cell4 = (ThirdCellCollectionViewCell *)cell;
        
        //        cell4.img_card.transform=CGAffineTransformMakeTranslation(+cell4.frame.size.width,0);
        
        [cell4.lbl_first setText:@"2"];
        [cell4.lbl_second setText:@"5"];
        
        cell4.img_scannerLine.hidden=YES;
        
        
        cell4.lbl_first.transform=CGAffineTransformIdentity;
        cell4.lbl_second.transform=CGAffineTransformIdentity;
        
        
        
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.section==0) {
    
    NSIndexPath *indexPathVisi =  [collectionView indexPathForCell:[[collectionView visibleCells] lastObject]] ;
    NSLog(@"Previo %ld current %ld",indexPath.section,indexPathVisi.section);
    
    if([[[collectionView visibleCells] lastObject] isKindOfClass:[FirstCell class]])
    {
        FirstCell *cell1 = (FirstCell *)[[collectionView visibleCells] lastObject];
        
        
        cell1.first_img.hidden=NO;
        cell1.Sec_img.hidden=NO;
        cell1.last_img.hidden=NO;
        cell1.lbl_title.hidden=NO;
        
        

        if (indexPath.section >indexPathVisi.section) {
            
            self.aniFirstTime=YES;
            if (self.ani==NO) {
               
            }
            else
            {
                
                if(!cell1.hasAnimated)
                {
                    cell1.hasAnimated = YES;
                    cell1.first_img.transform=CGAffineTransformMakeTranslation(-cell1.frame.size.width-30,0);
                    cell1.Sec_img.transform=CGAffineTransformMakeTranslation(-cell1.frame.size.width-30,0);
                    cell1.last_img.transform=CGAffineTransformMakeTranslation(-cell1.frame.size.width-30,0);
                    // cell1.lbl_title.transform=CGAffineTransformMakeTranslation(-cell1.frame.size.width-30,0);
                    
                    //                             }
                    [UIView animateWithDuration:0.40
                                          delay:0.0
                                        options:UIViewAnimationOptionTransitionNone
                                     animations:^{
                                         //first animation
                                         // cell1.lbl_title.transform=CGAffineTransformIdentity;
                                         //cell1.first_img.transform=CGAffineTransformIdentity;
                                         
                                         cell1.first_img.transform=CGAffineTransformMakeTranslation(+40, 0);
                                     }
                                     completion:^(BOOL finished) {
                                         
                                         
                                         [UIView animateWithDuration:0.40
                                                               delay:0.0
                                                             options:UIViewAnimationOptionTransitionNone
                                                          animations:^{
                                                              cell1.first_img.transform=CGAffineTransformIdentity;                           }
                                                          completion:nil];
                                         
                                         
                                         
                                         
                                         
                                     }];
                    
                    
                    
                    [UIView animateWithDuration:0.45 animations:^{
                        
                        cell1.Sec_img.transform=CGAffineTransformMakeTranslation(+40, 0);
                    } completion:^(BOOL finished) {
                        
                        [UIView animateWithDuration:0.45
                                              delay:0.0
                                            options:UIViewAnimationOptionTransitionNone
                                         animations:^{
                                             cell1.Sec_img.transform=CGAffineTransformIdentity;                      }
                                         completion:nil];
                        
                        
                        
                    }];
                    
                    [UIView animateWithDuration:0.50 animations:^{
                        cell1.last_img.transform=CGAffineTransformMakeTranslation(+40, 0);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.50
                                              delay:0.0
                                            options:UIViewAnimationOptionTransitionNone
                                         animations:^{
                                             cell1.last_img.transform=CGAffineTransformIdentity;
                                         }
                                         completion:nil];
                        
                    }];

            }
            
            
        }
        }
        else
        {
            self.aniFirstTime=YES;
            cell1.first_img.transform=CGAffineTransformMakeTranslation(+cell1.frame.size.width+30,0);
            //cell1.lbl_title.transform=CGAffineTransformMakeTranslation(+cell1.frame.size.width+30,0);
            cell1.Sec_img.transform=CGAffineTransformMakeTranslation(+cell1.frame.size.width+30,0);
            cell1.last_img.transform=CGAffineTransformMakeTranslation(+cell1.frame.size.width+30,0);
            

            [UIView animateWithDuration:0.40
                                  delay:0.0
                                options:UIViewAnimationOptionTransitionNone
                             animations:^{
                                 //first animation
                                // cell1.first_img.transform=CGAffineTransformIdentity;
                                // cell1.lbl_title.transform=CGAffineTransformIdentity;
                                 
                                 cell1.first_img.transform=CGAffineTransformMakeTranslation(-40, 0);
                             }
                             completion:^(BOOL finished) {
                                 [UIView animateWithDuration:0.40
                                                       delay:0.0
                                                     options:UIViewAnimationOptionTransitionNone
                                                  animations:^{
                                                        cell1.first_img.transform=CGAffineTransformIdentity;                   }
                                                  completion:nil];
                                 

                               
                                 
                             }];

            
            
            [UIView animateWithDuration:0.45 animations:^{
                
                cell1.Sec_img.transform=CGAffineTransformMakeTranslation(-40, 0);
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.45
                                      delay:0.0
                                    options:UIViewAnimationOptionTransitionNone
                                 animations:^{
                                     cell1.Sec_img.transform=CGAffineTransformIdentity;                 }
                                 completion:nil];

               
                
            }];
            
            [UIView animateWithDuration:0.50 animations:^{
                cell1.last_img.transform=CGAffineTransformMakeTranslation(-40, 0);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.50
                                      delay:0.0
                                    options:UIViewAnimationOptionTransitionNone
                                 animations:^{
                                      cell1.last_img.transform=CGAffineTransformIdentity;               }
                                 completion:nil];
                

               
            }];
            
            
            
        }
        
        //        }
        
    }
    else if([[[collectionView visibleCells] lastObject] isKindOfClass:[FamilyShareCell class]])
    {
         self.ani=YES;
//        self.alreadytrans=NO;
        FamilyShareCell *cell2 = (FamilyShareCell *)[[collectionView visibleCells] lastObject];
        
        cell2.imgPer1.hidden=NO;
        cell2.imgPer2.hidden=NO;
        cell2.imgPer3.hidden=NO;
        cell2.lbl_title.hidden=NO;
        
        
        if(!cell2.hasAnimated)
        {
            cell2.hasAnimated = YES;
            
            if (indexPath.section >indexPathVisi.section) {
                
                cell2.imgPer2.transform=CGAffineTransformMakeTranslation(-cell2.frame.size.width,0);
                cell2.imgPer1.transform=CGAffineTransformMakeScale(0.0f, 0.0f);
                cell2.imgPer3.transform=CGAffineTransformMakeScale(0.0f, 0.0f);
                cell2.lbl_title.transform=CGAffineTransformMakeTranslation(-cell2.frame.size.width, 0);
                
                
                [UIView animateWithDuration:0.30
                                      delay:0.0
                                    options:UIViewAnimationOptionTransitionNone
                                 animations:^{
                                     //first animation
                                    
                                     [UIView animateWithDuration:0.30
                                                           delay:0.0
                                                         options:UIViewAnimationOptionTransitionNone
                                                      animations:^{
                                                          cell2.imgPer2.transform=CGAffineTransformMakeTranslation(+40,0);
                                                          cell2.lbl_title.transform=CGAffineTransformIdentity;
                                                                                      }
                                                      completion:^(BOOL finished) {
                                                          
                                                          [UIView animateWithDuration:0.30
                                                                                delay:0.0
                                                                              options:UIViewAnimationOptionTransitionNone
                                                                           animations:^{
                                                                                cell2.imgPer2.transform=CGAffineTransformIdentity;
                                                                               
                                                                           }
                                                                           completion:^(BOOL finished) {
                                                                               
                                                                               [UIView animateWithDuration:0.30
                                                                                                     delay:0.0
                                                                                                   options:UIViewAnimationOptionTransitionNone
                                                                                                animations:^{
                                                                                                    //second animation
                                                                                                    cell2.imgPer1.transform = CGAffineTransformMakeScale(1.1, 1.1);
                                                                                                    
                                                                                                }
                                                                                                completion:^(BOOL finished){//and so on..
                                                                                                    // cell2.imgPer1.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                                                                                    [UIView animateWithDuration:0.30 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
                                                                                                        cell2.imgPer1.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                                                                                        //cell2.imgPer3.transform = CGAffineTransformMakeScale(1.1, 1.1);
                                                                                                        
                                                                                                    } completion:nil];
                                                                                                    
                                                                                                }];
                                                                               
                                                                               [UIView animateWithDuration:0.30 delay:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
                                                                                   cell2.imgPer3.transform = CGAffineTransformMakeScale(1.1, 1.1);
                                                                                   
                                                                               } completion:^(BOOL finished) {
                                                                                   
                                                                                   [UIView animateWithDuration:0.30 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
                                                                                       cell2.imgPer3.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                                                                       
                                                                                   } completion:nil];
                                                                                   
                                                                                   
                                                                                   
                                                                               }];

                                                                               
                                                                               
                                                                           }];
                                                      }];
                                     

                                     
                                     
                                 }
                                 completion:^(BOOL finished){                                                                                                           }];
                

            }
            else
            {
                cell2.imgPer2.transform=CGAffineTransformMakeTranslation(+cell2.frame.size.width,0);
                cell2.imgPer1.transform=CGAffineTransformMakeScale(0.0f, 0.0f);
                cell2.imgPer3.transform=CGAffineTransformMakeScale(0.0f, 0.0f);
                cell2.lbl_title.transform=CGAffineTransformMakeTranslation(+cell2.frame.size.width, 0);
                
                
                // Second Cell Animation

                [UIView animateWithDuration:0.30
                                      delay:0.0
                                    options:UIViewAnimationOptionTransitionNone
                                 animations:^{
                                     //first animation
                                     
                                     [UIView animateWithDuration:0.30
                                                           delay:0.0
                                                         options:UIViewAnimationOptionTransitionNone
                                                      animations:^{
                                                          cell2.imgPer2.transform=CGAffineTransformMakeTranslation(-40,0);
                                                          cell2.lbl_title.transform=CGAffineTransformIdentity;
                                                      }
                                                      completion:^(BOOL finished) {
                                                          
                                                          [UIView animateWithDuration:0.30
                                                                                delay:0.0
                                                                              options:UIViewAnimationOptionTransitionNone
                                                                           animations:^{
                                                                               cell2.imgPer2.transform=CGAffineTransformIdentity;
                                                                           }
                                                                           completion:^(BOOL finished) {
                                                                               
                                                                               [UIView animateWithDuration:0.30
                                                                                                     delay:0.0
                                                                                                   options:UIViewAnimationOptionTransitionNone
                                                                                                animations:^{
                                                                                                    //second animation
                                                                                                    cell2.imgPer1.transform = CGAffineTransformMakeScale(1.1, 1.1);
                                                                                                    
                                                                                                }
                                                                                                completion:^(BOOL finished){//and so on..
                                                                                                    // cell2.imgPer1.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                                                                                    [UIView animateWithDuration:0.30 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
                                                                                                        cell2.imgPer1.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                                                                                        //cell2.imgPer3.transform = CGAffineTransformMakeScale(1.1, 1.1);
                                                                                                        
                                                                                                    } completion:nil];
                                                                                                    
                                                                                                }];
                                                                               [UIView animateWithDuration:0.30 delay:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
                                                                                   cell2.imgPer3.transform = CGAffineTransformMakeScale(1.1, 1.1);
                                                                                   
                                                                               } completion:^(BOOL finished) {
                                                                                   
                                                                                   [UIView animateWithDuration:0.30 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
                                                                                       cell2.imgPer3.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                                                                       
                                                                                   } completion:nil];
                                                                                   
                                                                                   
                                                                                   
                                                                               }];

                                                                               
                                                                           }];
                                                      }];
                                     

                                 }
                                 completion:^(BOOL finished){                                                                                                          }];
                

                
                
            }
            
            
            
        }
    }
    else if ([[[collectionView visibleCells] lastObject] isKindOfClass:[imgCollectionCell class]])
    {
        imgCollectionCell *cell3 = (imgCollectionCell *)[[collectionView visibleCells] lastObject];
        
        //        cell3.img_logos.hidden=NO;
        cell3.img_popup.hidden=NO;
        //        cell3.lbl_title.hidden=NO;
        
        if(!cell3.hasAnimated)
        {
            cell3.hasAnimated = YES;
            
            if (indexPath.section >indexPathVisi.section) {
                //            cell3.img_logos.transform=CGAffineTransformMakeTranslation(-cell3.frame.size.width,0);
                //            cell3.lbl_title.transform=CGAffineTransformMakeTranslation(-cell3.frame.size.width, 0);
                cell3.img_popup.transform = CGAffineTransformMakeScale(0.0f, 0.0f);
                
            }
            else
            {
                //            cell3.img_logos.transform=CGAffineTransformMakeTranslation(+cell3.frame.size.width,0);
                //            cell3.lbl_title.transform=CGAffineTransformMakeTranslation(+cell3.frame.size.width, 0);
                cell3.img_popup.transform = CGAffineTransformMakeScale(0.0f, 0.0f);
                
            }
            
            [UIView animateWithDuration:0.60
                                  delay:0.0
                                options:UIViewAnimationOptionTransitionNone
                             animations:^{
                                 //first animation
                                 cell3.img_logos.transform=CGAffineTransformIdentity;
                                 cell3.lbl_title.transform=CGAffineTransformIdentity;
                             }
                             completion:^(BOOL finished){[UIView animateWithDuration:0.40
                                                                               delay:0.0
                                                                             options:UIViewAnimationOptionTransitionNone
                                                                          animations:^{
                                                                              //second animation
                                                                              cell3.img_popup.transform = CGAffineTransformMakeScale(1.1, 1.1);
                                                                              
                                                                          }
                                                                          completion:^(BOOL finished){//and so on..
                                                                              [UIView animateWithDuration:0.20 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
                                                                                  cell3.img_popup.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                                                                  
                                                                              } completion:^(BOOL finished) {
                                                                                  //                                                                              cell3.img_popup.transform = CGAffineTransformMakeScale(0.0, 0.0);
                                                                              }];
                                                                              
                                                                              
                                                                          }];}];
            
            
            
        }
    }
    
    else if([[[collectionView visibleCells] lastObject] isKindOfClass:[ThirdCellCollectionViewCell class]])
    {
        ThirdCellCollectionViewCell *cell4 = (ThirdCellCollectionViewCell *)[[collectionView visibleCells] lastObject];
        
        // ThirdCellCollectionViewCell *cell4 = (ThirdCellCollectionViewCell *)cell;
        
        //        cell4.img_card.transform=CGAffineTransformMakeTranslation(+cell4.frame.size.width,0);
        
        if(!cell4.hasAnimated)
        {
            cell4.hasAnimated = YES;
            
            [cell4.lbl_first setText:@"2"];
            [cell4.lbl_second setText:@"5"];
            
            cell4.img_scannerLine.hidden=YES;
            
            cell4.lbl_first.transform=CGAffineTransformIdentity;
            cell4.lbl_second.transform=CGAffineTransformIdentity;
            
            
            
            [UIView animateWithDuration:4.0
                                  delay:1.0
                                options:UIViewAnimationOptionTransitionNone
                             animations:^{
                                 
                             }
                             completion:^(BOOL finished) {[UIView animateWithDuration:0.60
                                                                                delay:0.0
                                                                              options:UIViewAnimationOptionTransitionNone
                                                                           animations:^{
                                                                               //second animation
                                                                               cell4.img_scannerLine.hidden=NO;
                                                                               cell4.img_scannerLine.transform=CGAffineTransformMakeTranslation(0,+cell4.img_scannerLine.frame.size.height+10);
                                                                               
                                                                           }
                                                                           completion:^(BOOL finished){//and so on..
                                                                               
                                                                               [UIView animateWithDuration:0.60 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
                                                                                   
                                                                                   cell4.img_scannerLine.transform=CGAffineTransformIdentity;
                                                                               } completion:^(BOOL finished) {
                                                                                   cell4.img_scannerLine.hidden=YES;
                                                                                   
                                                                                   
                                                                                   
                                                                                   
                                                                                   [UIView animateWithDuration:0.60 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
                                                                                       
                                                                                       
                                                                                       CATransition *animation = [CATransition animation];
                                                                                       animation.startProgress = 0;
                                                                                       animation.endProgress = 1.0;
                                                                                       animation.duration = 1.0;
                                                                                       
                                                                                       animation.type=kCATransitionPush;
                                                                                       animation.subtype = kCATransitionFromBottom;
                                                                                       animation.delegate=self;
                                                                                       
                                                                                       [animation setValue:@"one" forKey:@"changeTextTransition"];
                                                                                       animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
                                                                                       
                                                                                       
                                                                                       [cell4.lbl_first.layer addAnimation:animation forKey:@"one"];
                                                                                       
                                                                                       
                                                                                       // Change the text
                                                                                       cell4.lbl_first.text = @"1";
                                                                                       
                                                                                       //
                                                                                       
                                                                                       
                                                                                   } completion:^(BOOL finished) {
                                                                                       
                                                                                       
                                                                                   }];
                                                                                   
                                                                                   
                                                                                   [self  performSelector:@selector(animation2:) withObject:cell4 afterDelay:0.60];
                                                                                   
                                                                                   
                                                                               }];
                                                                               
                                                                               
                                                                               
                                                                           }];}];
        }
    }
    
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.view.frame.size.width ,self.myCollectionView.frame.size.height);
}

/*!
 *  @brief To set the pagecontrol page on scroll
 *
 *  @param scrollView scrollview Object
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth/2) / pageWidth)+1;
    self.myPageControl.currentPage = page;
    
    
    
    CGPoint newOffset = scrollView.contentOffset;
    
       if (newOffset.x < self.scrollOffset.x) {
        // scrolling to the left, reset offset
        //        [scrollView setContentOffset:offset];
        
        self.reverseScroll=YES;
    }
    else if(newOffset.x>self.scrollOffset.x)
    {
        //scrolling to the right
        self.reverseScroll=NO;
    }
    
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    FirstCell *cell5 = (FirstCell*)[self.myCollectionView cellForItemAtIndexPath:newIndexPath];
    
        if (self.myPageControl.currentPage==0) {
        
        if (newOffset.x < self.scrollOffset.x) {
            // scrolling to the left, reset offset
            //        [scrollView setContentOffset:offset];
//            cell5.cnst_firstimg_ld.constant=newOffset.x;
//            cell5.cnst_firstimg_tr.constant=newOffset.x;
//            
//            cell5.cnst_secimg_ld.constant=newOffset.x*2;
//            cell5.cnst_secimg_tr.constant=newOffset.x*3;
//            
//            cell5.cnst_lastimg_ld.constant=newOffset.x*3;
//            cell5.cnst_lastimg_tr.constant=newOffset.x*3;
            
            
        }
        else if(newOffset.x>self.scrollOffset.x)
        {
            //scrolling to the right
            cell5.cnst_lastimg_ld.constant=-newOffset.x*0.4;
            cell5.cnst_lastimg_tr.constant=newOffset.x*0.4;
            
            cell5.cnst_secimg_ld.constant=-newOffset.x*0.8;
            cell5.cnst_secimg_tr.constant=newOffset.x*0.8;
            
            cell5.cnst_firstimg_ld.constant=-newOffset.x*1.2;
            cell5.cnst_firstimg_tr.constant=newOffset.x*1.2;
            
           // cell5.first_img.transform=CGAffineTransformMakeTranslation(self.scrollOffset, 0);
            

        }

    }
    
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate)
    {
        if([[self.myCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] isKindOfClass:[FirstCell class]])
        {
            FirstCell *cell = (FirstCell*)[self.myCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.cnst_firstimg_tr.constant=0;
            cell.cnst_secimg_tr.constant=0;
            cell.cnst_lastimg_tr.constant=0;
            cell.cnst_firstimg_ld.constant=0;
            cell.cnst_secimg_ld.constant=0;
            cell.cnst_lastimg_ld.constant=0;
            [UIView animateWithDuration:0.25 animations:^{
                [self.view layoutIfNeeded];
            }];
        }
     
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    if([[self.myCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] isKindOfClass:[FirstCell class]])
//    {
//    FirstCell *cell = (FirstCell*)[self.myCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    cell.cnst_firstimg_tr.constant=0;
//    cell.cnst_secimg_tr.constant=0;
//    cell.cnst_lastimg_tr.constant=0;
//    cell.cnst_firstimg_ld.constant=0;
//    cell.cnst_secimg_ld.constant=0;
//    cell.cnst_lastimg_ld.constant=0;
//        [UIView animateWithDuration:0.25 animations:^{
//            [self.view layoutIfNeeded];
//        }];
//    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.scrollOffset = scrollView.contentOffset;
    
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView   // called on finger up as we are moving
{
    
}
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    if (self.myPageControl.currentPage==0) {
//
//        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        FirstCell *cell1 = (FirstCell*)[self.myCollectionView cellForItemAtIndexPath:newIndexPath];
//
//        if (self.reverseScroll==YES) {
//
//            if (self.alreadytrans==YES) {
//                self.alreadytrans=NO;
//            }
//            else
//            {
//                cell1.first_img.transform=CGAffineTransformMakeTranslation(-cell1.frame.size.width-30,0);
//                cell1.Sec_img.transform=CGAffineTransformMakeTranslation(-cell1.frame.size.width-30,0);
//                cell1.last_img.transform=CGAffineTransformMakeTranslation(-cell1.frame.size.width-30,0);
//                cell1.lbl_title.transform=CGAffineTransformMakeTranslation(-cell1.frame.size.width-30,0);
//
//            }
//            [UIView animateWithDuration:0.50
//                                  delay:0.0
//                                options:UIViewAnimationOptionTransitionNone
//                             animations:^{
//                                 //first animation
//                                 cell1.first_img.transform=CGAffineTransformIdentity;
//                                 cell1.lbl_title.transform=CGAffineTransformIdentity;
//                             }
//                             completion:nil];
//
//
//            [UIView animateWithDuration:0.60 animations:^{
//                cell1.Sec_img.transform=CGAffineTransformIdentity;
//            }];
//
//            [UIView animateWithDuration:0.70 animations:^{
//                cell1.last_img.transform=CGAffineTransformIdentity;
//            }];
//
//        }
//        else
//        {
//
//            cell1.first_img.transform=CGAffineTransformMakeTranslation(+cell1.frame.size.width+30,0);
//            cell1.lbl_title.transform=CGAffineTransformMakeTranslation(+cell1.frame.size.width+30,0);
//            cell1.Sec_img.transform=CGAffineTransformMakeTranslation(+cell1.frame.size.width+30,0);
//            cell1.last_img.transform=CGAffineTransformMakeTranslation(+cell1.frame.size.width+30,0);
//
//
//            [UIView animateWithDuration:0.50
//                                  delay:0.0
//                                options:UIViewAnimationOptionTransitionNone
//                             animations:^{
//                                 //first animation
//                                 cell1.first_img.transform=CGAffineTransformIdentity;
//                                 cell1.lbl_title.transform=CGAffineTransformIdentity;
//                             }
//                             completion:nil];
//
//
//            [UIView animateWithDuration:0.60 animations:^{
//                cell1.Sec_img.transform=CGAffineTransformIdentity;
//            }];
//
//            [UIView animateWithDuration:0.70 animations:^{
//                cell1.last_img.transform=CGAffineTransformIdentity;
//            }];
//
//
//        }
//
//
//
//    }
//    else if(self.myPageControl.currentPage==1)
//    {
//        self.alreadytrans=NO;
//
//        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
//        FamilyShareCell *cell2 = (FamilyShareCell*)[self.myCollectionView cellForItemAtIndexPath:newIndexPath];
//
//        NSIndexPath *newIndexPath2 = [NSIndexPath indexPathForRow:0 inSection:0];
//        FirstCell *cell5 = (FirstCell*)[self.myCollectionView cellForItemAtIndexPath:newIndexPath2];
//
//
//        if (self.reverseScroll==YES) {
//            cell2.imgPer2.transform=CGAffineTransformMakeTranslation(-cell2.frame.size.width,0);
//            cell2.imgPer1.transform=CGAffineTransformMakeScale(0.0f, 0.0f);
//            cell2.imgPer3.transform=CGAffineTransformMakeScale(0.0f, 0.0f);
//            cell2.lbl_title.transform=CGAffineTransformMakeTranslation(-cell2.frame.size.width, 0);
//
//        }
//        else
//        {
//            cell2.imgPer2.transform=CGAffineTransformMakeTranslation(+cell2.frame.size.width,0);
//            cell2.imgPer1.transform=CGAffineTransformMakeScale(0.0f, 0.0f);
//            cell2.imgPer3.transform=CGAffineTransformMakeScale(0.0f, 0.0f);
//            cell2.lbl_title.transform=CGAffineTransformMakeTranslation(+cell2.frame.size.width, 0);
//
//            self.alreadytrans=YES;
//
//            [UIView animateWithDuration:0.50
//                                  delay:0.0
//                                options:UIViewAnimationOptionTransitionNone
//                             animations:^{
//                                 //first animation
//
//                                 cell5.first_img.transform=CGAffineTransformMakeTranslation(-cell5.frame.size.width-30,0);
//                                 cell5.lbl_title.transform=CGAffineTransformMakeTranslation(-cell5.frame.size.width-30,0);
//
//                             }
//                             completion:nil];
//
//
//            [UIView animateWithDuration:0.60 animations:^{
//                cell5.Sec_img.transform=CGAffineTransformMakeTranslation(-cell5.frame.size.width-30,0);
//
//
//            }];
//
//            [UIView animateWithDuration:0.70 animations:^{
//                cell5.last_img.transform=CGAffineTransformMakeTranslation(-cell5.frame.size.width-30,0);
//
//
//            }];
//
//
//
//
//        }
//
//
//        [UIView animateWithDuration:0.30
//                              delay:0.3
//                            options:UIViewAnimationOptionTransitionNone
//                         animations:^{
//                             //first animation
//                             cell2.imgPer2.transform=CGAffineTransformIdentity;
//                             cell2.lbl_title.transform=CGAffineTransformIdentity;
//                         }
//                         completion:^(BOOL finished){[UIView animateWithDuration:0.30
//                                                                           delay:0.0
//                                                                         options:UIViewAnimationOptionTransitionNone
//                                                                      animations:^{
//                                                                          //second animation
//                                                                          cell2.imgPer1.transform = CGAffineTransformMakeScale(1.1, 1.1);
//
//                                                                      }
//                                                                      completion:^(BOOL finished){//and so on..
//                                                                          cell2.imgPer1.transform = CGAffineTransformMakeScale(1.0, 1.0);
//                                                                          [UIView animateWithDuration:0.30 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
//
//                                                                              //cell2.imgPer3.transform = CGAffineTransformMakeScale(1.1, 1.1);
//
//                                                                          } completion:nil];
//
//                                                                      }];
//
//                             [UIView animateWithDuration:0.30 delay:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
//                                 cell2.imgPer3.transform = CGAffineTransformMakeScale(1.1, 1.1);
//
//                             } completion:^(BOOL finished) {
//                                 cell2.imgPer3.transform = CGAffineTransformMakeScale(1.0, 1.0);
//
//                             }];
//                         }];
//
//
//
//    }
//    else if (self.myPageControl.currentPage==2)
//    {
//        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
//        imgCollectionCell *cell3 = (imgCollectionCell*)[self.myCollectionView cellForItemAtIndexPath:newIndexPath];
//
//        //        cell3.img_logos.transform=CGAffineTransformMakeTranslation(+cell3.frame.size.width,0);
//
//
//        cell3.img_popup.transform = CGAffineTransformMakeScale(0.0f, 0.0f);
//
//        [UIView animateWithDuration:0.85
//                              delay:0.0
//                            options:UIViewAnimationOptionTransitionNone
//                         animations:^{
//                             //first animation
//                             //                             cell3.img_logos.transform=CGAffineTransformIdentity;
//                         }
//                         completion:^(BOOL finished){[UIView animateWithDuration:0.85
//                                                                           delay:0.0
//                                                                         options:UIViewAnimationOptionTransitionNone
//                                                                      animations:^{
//                                                                          //second animation
//                                                                          cell3.img_popup.transform = CGAffineTransformMakeScale(1.1, 1.1);
//
//                                                                      }
//                                                                      completion:^(BOOL finished){//and so on..
//                                                                          [UIView animateWithDuration:0.40 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
//                                                                              cell3.img_popup.transform = CGAffineTransformMakeScale(1.0, 1.0);
//
//                                                                          } completion:^(BOOL finished) {
//                                                                              //                                                                              cell3.img_popup.transform = CGAffineTransformMakeScale(0.0, 0.0);
//                                                                          }];
//
//
//                                                                      }];}];
//
//
//
//    }
//    else
//    {
//        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:3 inSection:0];
//        ThirdCellCollectionViewCell *cell4 = (ThirdCellCollectionViewCell*)[self.myCollectionView cellForItemAtIndexPath:newIndexPath];
//
//        //        cell4.img_card.transform=CGAffineTransformMakeTranslation(+cell4.frame.size.width,0);
//
//        [cell4.lbl_first setText:@"2"];
//        [cell4.lbl_second setText:@"5"];
//
//        cell4.img_scannerLine.hidden=YES;
//
//        cell4.lbl_first.transform=CGAffineTransformIdentity;
//        cell4.lbl_second.transform=CGAffineTransformIdentity;
//
//
//
//        [UIView animateWithDuration:4.0
//                              delay:1.0
//                            options:UIViewAnimationOptionTransitionNone
//                         animations:^{
//
//                         }
//                         completion:^(BOOL finished) {[UIView animateWithDuration:0.85
//                                                                            delay:0.0
//                                                                          options:UIViewAnimationOptionTransitionNone
//                                                                       animations:^{
//                                                                           //second animation
//                                                                           cell4.img_scannerLine.hidden=NO;
//                                                                           cell4.img_scannerLine.transform=CGAffineTransformMakeTranslation(0,+cell4.img_scannerLine.frame.size.height+10);
//
//                                                                       }
//                                                                       completion:^(BOOL finished){//and so on..
//
//                                                                           [UIView animateWithDuration:0.85 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
//
//                                                                               cell4.img_scannerLine.transform=CGAffineTransformIdentity;
//                                                                           } completion:^(BOOL finished) {
//                                                                               cell4.img_scannerLine.hidden=YES;
//
//
//
//
//                                                                               [UIView animateWithDuration:0.85 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
//
//
//                                                                                   CATransition *animation = [CATransition animation];
//                                                                                   animation.startProgress = 0;
//                                                                                   animation.endProgress = 1.0;
//                                                                                   animation.duration = 1.0;
//
//                                                                                   animation.type=kCATransitionPush;
//                                                                                   animation.subtype = kCATransitionFromBottom;
//                                                                                   animation.delegate=self;
//
//                                                                                   [animation setValue:@"one" forKey:@"changeTextTransition"];
//                                                                                   animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//
//
//                                                                                   [cell4.lbl_first.layer addAnimation:animation forKey:@"one"];
//
//
//                                                                                   // Change the text
//                                                                                   cell4.lbl_first.text = @"1";
//
//                                                                                   //
//
//
//                                                                               } completion:^(BOOL finished) {
//
//
//                                                                               }];
//
//
//                                                                               [self  performSelector:@selector(animation2:) withObject:cell4 afterDelay:0.85];
//
//
//                                                                           }];
//
//
//
//                                                                       }];}];
//    }
//
//
//}


#pragma mark-Button Actions

/*!
 *  @brief  Action to Signup by email
 *
 *  @param sender  is btn_email
 */
- (IBAction)btn_email_pressed:(id)sender
{
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SignupViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"SignupViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

/*!
 *  @brief  Action to request for  read permissions like your public_profile,birthday,email
 *
 *  @param sender is Btn_fbSignup
 */
- (IBAction)btn_fbSignUp_pressed:(id)sender
{
    if ([[[FBSDKAccessToken currentAccessToken] permissions]allObjects])
    {
        [self performSelectorOnMainThread:@selector(fbLoginHandler) withObject:nil waitUntilDone:NO];
    }
    else
    {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithReadPermissions: @[@"public_profile",@"user_birthday",@"email"]
                                handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                    if (error) {
                                        NSLog(@"%@",[error description]);
                                    } else if (result.isCancelled) {
                                        NSLog(@"Cancelled");
                                    } else {
                                        NSLog(@"Logged in");
                                        [self performSelectorOnMainThread:@selector(fbLoginHandler) withObject:nil waitUntilDone:NO];
                                    }
                                }];
        
    }
}

/*!
 *  @brief  To fetch Facebook Account Details like id,name,email after taking permissions
 */
-(void)fbLoginHandler
{
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields":@"id,name,email"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"fetched user:%@", result);
             
             NSDictionary *UserData=(NSDictionary*)result;
             NSLog(@"%@",[UserData description]);
             self.fb_name=[UserData valueForKey:@"name"];
             
             self.fb_id=[UserData valueForKey:@"id"];
             // self.fb_email=[UserData valueForKey:@"email"];
             self.fb_email=([result valueForKey:@"email"] != nil) ?[UserData valueForKey:@"email"]:@"";
             
             [self performSelectorOnMainThread:@selector(performLogin) withObject:nil waitUntilDone:NO];
         }
         else{
             NSLog(@"%@",error);
             // An error occurred, we need to handle the error
             // See: https://developers.facebook.com/docs/ios/errors
         }
     }];
    
}

/*!
 *  @brief  To Sign up or Login(if already registered) by facebook
 */
-(void)performLogin
{
    AppDelegate *App = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [self.view endEditing:YES];
    [App StartAnimating];
    self.view.userInteractionEnabled=NO;
    
    NSArray *myArray = [self.fb_name componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
    NSString *str1=[myArray objectAtIndex:0];
    NSString*str2=[myArray lastObject];
    
    NSDictionary *dict = [NSDictionary dictionary];
    dict=[[NSDictionary alloc]initWithObjectsAndKeys:self.fb_id, @"facebook_id",str1,@"first_name",str2,@"last_name",self.fb_email,@"email",nil];
    
    [IOSRequest uploadData:Url_fbSignUp parameters:dict imageData:nil success:^(NSDictionary *responseStr)
     {
         [App StopAnimating];
         self.view.userInteractionEnabled=YES;
         
         if ([[responseStr valueForKey:@"success"]integerValue]==1)
         {
             [UserProfile saveProfile:[responseStr valueForKey:@"user"]];
             UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
             MainViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"MainViewController"];
             [self.navigationController pushViewController:controller animated:YES];
         }
         
     } failure:^(NSError *error)
     {
         self.view.userInteractionEnabled=YES;
         NSLog(@"%@",[error description]);
         [App StopAnimating];
     }];
    
}



#pragma mark-unwind Function
/*!
 *  @brief  To Return back to this Controller from other Controller
 *
 *  @param unwindSegue <#unwindSegue description#>
 */
-(IBAction)unwindFirstViewController:(UIStoryboardSegue*)unwindSegue
{
    UIViewController* sourceViewController = unwindSegue.sourceViewController;
    if ([sourceViewController isKindOfClass:[MainViewController class]])
    {
        NSLog(@"Coming from MainViewController!");
    }
}

-(void)animation2:(ThirdCellCollectionViewCell*)cell5
{
    //            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    //            ThirdCellCollectionViewCell *cell5 = (ThirdCellCollectionViewCell*)[self.myCollectionView cellForItemAtIndexPath:newIndexPath];
    //
    
    CATransition *animation1 = [CATransition animation];
    animation1.duration = 1.0;
    animation1.startProgress = 0;
    animation1.endProgress = 1.0;
    
    animation1.type=kCATransitionPush;
    animation1.subtype = kCATransitionFromBottom;
    
    animation1.delegate=self;
    
    [animation1 setValue:@"second" forKey:@"changeTextTransition"];
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    [cell5.lbl_second.layer addAnimation:animation1 forKey:@"second"];
    
    
    // Change the text
    cell5.lbl_second.text=@"0";
    
    
    
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
    
    NSString* value = [theAnimation valueForKey:@"changeTextTransition"];
    if ([value isEqualToString:@"one"]&& flag==true)
    {
        //... Your code here ...
        return;
    }
    
    
    if ([value isEqualToString:@"second"]&& flag==true)
    {
        
        
        
        //... Your code here ...
        return;
    }
    
    //Add any future keyed animation operations when the animations are stopped.
}



-(void)willdisplay
{
    //    if (indexPath.section==0) {
    //
    //        FirstCell *cell1 = (FirstCell *)cell;
    //        if (self.reverseScroll==YES) {
    //
    //            if (self.alreadytrans==YES) {
    //                self.alreadytrans=NO;
    //            }
    //            else
    //            {
    //                cell1.first_img.transform=CGAffineTransformMakeTranslation(-cell1.frame.size.width-30,0);
    //                cell1.Sec_img.transform=CGAffineTransformMakeTranslation(-cell1.frame.size.width-30,0);
    //                cell1.last_img.transform=CGAffineTransformMakeTranslation(-cell1.frame.size.width-30,0);
    //                cell1.lbl_title.transform=CGAffineTransformMakeTranslation(-cell1.frame.size.width-30,0);
    //
    //            }
    //            [UIView animateWithDuration:0.50
    //                                  delay:0.0
    //                                options:UIViewAnimationOptionTransitionNone
    //                             animations:^{
    //                                 //first animation
    //                                 cell1.first_img.transform=CGAffineTransformIdentity;
    //                                 cell1.lbl_title.transform=CGAffineTransformIdentity;
    //                             }
    //                             completion:nil];
    //
    //
    //            [UIView animateWithDuration:0.60 animations:^{
    //                cell1.Sec_img.transform=CGAffineTransformIdentity;
    //            }];
    //
    //            [UIView animateWithDuration:0.70 animations:^{
    //                cell1.last_img.transform=CGAffineTransformIdentity;
    //            }];
    //
    //        }
    //        else
    //        {
    //
    //            cell1.first_img.transform=CGAffineTransformMakeTranslation(+cell1.frame.size.width+30,0);
    //            cell1.lbl_title.transform=CGAffineTransformMakeTranslation(+cell1.frame.size.width+30,0);
    //            cell1.Sec_img.transform=CGAffineTransformMakeTranslation(+cell1.frame.size.width+30,0);
    //            cell1.last_img.transform=CGAffineTransformMakeTranslation(+cell1.frame.size.width+30,0);
    //
    //
    //            [UIView animateWithDuration:0.50
    //                                  delay:0.0
    //                                options:UIViewAnimationOptionTransitionNone
    //                             animations:^{
    //                                 //first animation
    //                                 cell1.first_img.transform=CGAffineTransformIdentity;
    //                                 cell1.lbl_title.transform=CGAffineTransformIdentity;
    //                             }
    //                             completion:nil];
    //
    //
    //            [UIView animateWithDuration:0.60 animations:^{
    //                cell1.Sec_img.transform=CGAffineTransformIdentity;
    //            }];
    //
    //            [UIView animateWithDuration:0.70 animations:^{
    //                cell1.last_img.transform=CGAffineTransformIdentity;
    //            }];
    //
    //
    //        }
    //
    //
    //
    //    }
    //    else if(indexPath.section==1)
    //    {
    //        self.alreadytrans=NO;
    //        FamilyShareCell *cell2 = (FamilyShareCell*)cell;
    //        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //        FirstCell *cell5 = (FirstCell*)[self.myCollectionView cellForItemAtIndexPath:newIndexPath];
    //
    //
    //        if (self.reverseScroll==YES) {
    //            cell2.imgPer2.transform=CGAffineTransformMakeTranslation(-cell2.frame.size.width,0);
    //            cell2.imgPer1.transform=CGAffineTransformMakeScale(0.0f, 0.0f);
    //            cell2.imgPer3.transform=CGAffineTransformMakeScale(0.0f, 0.0f);
    //            cell2.lbl_title.transform=CGAffineTransformMakeTranslation(-cell2.frame.size.width, 0);
    //
    //        }
    //        else
    //        {
    //            cell2.imgPer2.transform=CGAffineTransformMakeTranslation(+cell2.frame.size.width,0);
    //            cell2.imgPer1.transform=CGAffineTransformMakeScale(0.0f, 0.0f);
    //            cell2.imgPer3.transform=CGAffineTransformMakeScale(0.0f, 0.0f);
    //            cell2.lbl_title.transform=CGAffineTransformMakeTranslation(+cell2.frame.size.width, 0);
    //
    //            self.alreadytrans=YES;
    //
    //            [UIView animateWithDuration:0.50
    //                                  delay:0.0
    //                                options:UIViewAnimationOptionTransitionNone
    //                             animations:^{
    //                                 //first animation
    //
    //                                 cell5.first_img.transform=CGAffineTransformMakeTranslation(-cell5.frame.size.width-30,0);
    //                                 cell5.lbl_title.transform=CGAffineTransformMakeTranslation(-cell5.frame.size.width-30,0);
    //
    //                             }
    //                             completion:nil];
    //
    //
    //            [UIView animateWithDuration:0.60 animations:^{
    //                cell5.Sec_img.transform=CGAffineTransformMakeTranslation(-cell5.frame.size.width-30,0);
    //
    //
    //            }];
    //
    //            [UIView animateWithDuration:0.70 animations:^{
    //                cell5.last_img.transform=CGAffineTransformMakeTranslation(-cell5.frame.size.width-30,0);
    //
    //
    //            }];
    //
    //
    //
    //
    //        }
    //
    //
    //        [UIView animateWithDuration:0.30
    //                              delay:0.3
    //                            options:UIViewAnimationOptionTransitionNone
    //                         animations:^{
    //                             //first animation
    //                             cell2.imgPer2.transform=CGAffineTransformIdentity;
    //                             cell2.lbl_title.transform=CGAffineTransformIdentity;
    //                         }
    //                         completion:^(BOOL finished){[UIView animateWithDuration:0.30
    //                                                                           delay:0.0
    //                                                                         options:UIViewAnimationOptionTransitionNone
    //                                                                      animations:^{
    //                                                                          //second animation
    //                                                                          cell2.imgPer1.transform = CGAffineTransformMakeScale(1.1, 1.1);
    //
    //                                                                      }
    //                                                                      completion:^(BOOL finished){//and so on..
    //                                                                           cell2.imgPer1.transform = CGAffineTransformMakeScale(1.0, 1.0);
    //                                                                          [UIView animateWithDuration:0.30 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
    //
    //                                                                              //cell2.imgPer3.transform = CGAffineTransformMakeScale(1.1, 1.1);
    //
    //                                                                          } completion:nil];
    //
    //                                                                      }];
    //
    //                             [UIView animateWithDuration:0.30 delay:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
    //                                 cell2.imgPer3.transform = CGAffineTransformMakeScale(1.1, 1.1);
    //
    //                             } completion:^(BOOL finished) {
    //                                 cell2.imgPer3.transform = CGAffineTransformMakeScale(1.0, 1.0);
    //
    //                             }];
    //}];
    //
    //
    //
    //    }
    //    else if (indexPath.section==2)
    //    {
    //        imgCollectionCell *cell3 = (imgCollectionCell *)cell;
    //
    //        //        cell3.img_logos.transform=CGAffineTransformMakeTranslation(+cell3.frame.size.width,0);
    //
    //
    //        cell3.img_popup.transform = CGAffineTransformMakeScale(0.0f, 0.0f);
    //
    //        [UIView animateWithDuration:0.85
    //                              delay:0.0
    //                            options:UIViewAnimationOptionTransitionNone
    //                         animations:^{
    //                             //first animation
    //                             //                             cell3.img_logos.transform=CGAffineTransformIdentity;
    //                         }
    //                         completion:^(BOOL finished){[UIView animateWithDuration:0.85
    //                                                                           delay:0.0
    //                                                                         options:UIViewAnimationOptionTransitionNone
    //                                                                      animations:^{
    //                                                                          //second animation
    //                                                                          cell3.img_popup.transform = CGAffineTransformMakeScale(1.1, 1.1);
    //
    //                                                                      }
    //                                                                      completion:^(BOOL finished){//and so on..
    //                                                                          [UIView animateWithDuration:0.40 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
    //                                                                              cell3.img_popup.transform = CGAffineTransformMakeScale(1.0, 1.0);
    //
    //                                                                          } completion:^(BOOL finished) {
    //                                                                              //                                                                              cell3.img_popup.transform = CGAffineTransformMakeScale(0.0, 0.0);
    //                                                                          }];
    //
    //
    //                                                                      }];}];
    //
    //
    //
    //    }
    //    else
    //    {
    //        ThirdCellCollectionViewCell *cell4 = (ThirdCellCollectionViewCell *)cell;
    //
    //        //        cell4.img_card.transform=CGAffineTransformMakeTranslation(+cell4.frame.size.width,0);
    //
    //        [cell4.lbl_first setText:@"2"];
    //        [cell4.lbl_second setText:@"5"];
    //
    //        cell4.img_scannerLine.hidden=YES;
    //
    //        cell4.lbl_first.transform=CGAffineTransformIdentity;
    //        cell4.lbl_second.transform=CGAffineTransformIdentity;
    //
    //
    //
    //        [UIView animateWithDuration:4.0
    //                              delay:1.0
    //                            options:UIViewAnimationOptionTransitionNone
    //                         animations:^{
    //
    //                                                   }
    //                         completion:^(BOOL finished) {[UIView animateWithDuration:0.85
    //                                                                            delay:0.0
    //                                                                          options:UIViewAnimationOptionTransitionNone
    //                                                                       animations:^{
    //                                                                           //second animation
    //                                                                            cell4.img_scannerLine.hidden=NO;
    //                                                                           cell4.img_scannerLine.transform=CGAffineTransformMakeTranslation(0,+cell4.img_scannerLine.frame.size.height+10);
    //
    //                                                                       }
    //                                                                       completion:^(BOOL finished){//and so on..
    //
    //                                                                           [UIView animateWithDuration:0.85 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
    //
    //                                                                               cell4.img_scannerLine.transform=CGAffineTransformIdentity;
    //                                                                           } completion:^(BOOL finished) {
    //                                                                               cell4.img_scannerLine.hidden=YES;
    //
    //
    //
    //
    //                                                                               [UIView animateWithDuration:0.85 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
    //
    //
    //                                                                                   CATransition *animation = [CATransition animation];
    //                                                                                   animation.startProgress = 0;
    //                                                                                   animation.endProgress = 1.0;
    //                                                                                   animation.duration = 1.0;
    //
    //                                                                                   animation.type=kCATransitionPush;
    //                                                                                   animation.subtype = kCATransitionFromBottom;
    //                                                                                   animation.delegate=self;
    //
    //                                                                                   [animation setValue:@"one" forKey:@"changeTextTransition"];
    //                                                                                   animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    //
    //
    //                                                                                   [cell4.lbl_first.layer addAnimation:animation forKey:@"one"];
    //
    //
    //                                                                                   // Change the text
    //                                                                                   cell4.lbl_first.text = @"1";
    //
    ////
    //
    //
    //                                                                               } completion:^(BOOL finished) {
    //
    //
    //                                                                               }];
    //
    //
    //                                                                               [self  performSelector:@selector(animation2:) withObject:cell4 afterDelay:0.85];
    //
    //
    //                                                                           }];
    //
    //
    //
    //                                                                       }];}];
    //    }
    
    
}
//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    imgCollectionCell *cell1 =(imgCollectionCell*)cell;
//
//    [UIView animateWithDuration:0.8 animations:^{
//
//        cell1.img_logos.transform = CGAffineTransformMakeScale(-1, 1); //Flipped
//        cell1.img_logos.transform=CGAffineTransformMakeRotation(M_PI*2);
//
//    } completion:^(BOOL finished) {
//
//    }];
//
//
//}
//  //////////////animations

//                                                                               CATransition *animation = [CATransition animation];
//                                                                               animation.duration = 1.0;
//                                                                               animation.type = kCATruncationEnd;
//                                                                               animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//                                                                               [cell4.lbl_first.layer addAnimation:animation forKey:@"changeTextTransition"];
//
//
//                                                                               // Change the text
//                                                                               cell4.lbl_first.text = @"1";
//
//
//
//                                                                               CATransition *animation2 = [CATransition animation];
//                                                                               animation2.duration = 1.5;
//                                                                               animation2.type = kCATransitionFromTop;
//                                                                               animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//                                                                               [cell4.lbl_second.layer addAnimation:animation2 forKey:@"changeTextTransition"];
//
//                                                                               // Change the text
//                                                                               cell4.lbl_second.text = @"0";
//

@end
