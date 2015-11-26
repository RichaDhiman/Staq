//
//  AlertController+Custom.m
//  gava
//
//  Created by RICHA on 11/23/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "AlertController+Custom.h"

@interface AlertController_Custom ()

@end

@implementation AlertController_Custom

//+(UIAlertController *)controllerWithTitle:(NSString *)title destButtontitle:(NSString *)destructiveTitle message:(NSString *)message buttons:(NSArray *)buttons keyIfDict:(NSString *)key style:(UIAlertControllerStyle)style success: (void (^) (id response))success failure: (void (^) (NSString *error))failure{
//    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
//    
//    if (key != nil) {
//        
//        for (int i=0; i<buttons.count; i++) {
//            NSDictionary *dict = [buttons objectAtIndex:i];
//            [alert addAction:[UIAlertAction actionWithTitle:[dict valueForKey:key] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                success(dict);
//            }]];
//        }
//        
//        [alert addAction:[UIAlertAction actionWithTitle:btnCancelText style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//            if (destructiveTitle.length==0)
//                failure(action.title);
//        }]];
//        
//        if (destructiveTitle.length!=0) {
//            [alert addAction:[UIAlertAction actionWithTitle:destructiveTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//                failure(action.title);
//            }]];
//            
//        }
//        
//        return alert;
//    }
//    else{
//        
//        for (int i=0; i<((style == UIAlertControllerStyleActionSheet) ? buttons.count:buttons.count-1); i++) {
//            NSString *str = [buttons objectAtIndex:i];
//            [alert addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                success(action.title);
//            }]];
//        }
//        
//        [alert addAction:[UIAlertAction actionWithTitle:(style == UIAlertControllerStyleActionSheet) ? btnCancelText :[buttons lastObject] style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//            if (destructiveTitle.length==0)
//                failure(action.title);
//        }]];
//        
//        if (destructiveTitle.length!=0) {
//            [alert addAction:[UIAlertAction actionWithTitle:destructiveTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//                failure(action.title);
//            }]];
//            
//        }
//        
//        
//        return alert;
//    }
//    
//}
//
//+(UIAlertController *)actionSheetWithTitle:(NSString *)title buttons:(NSArray *)buttons keyIfDict:(NSString *)key success: (void (^) (id response))success failure: (void (^) (NSString *error))failure{
//    
//    UIAlertController *alert = [UIAlertController controllerWithTitle:title destButtontitle:nil message:@"" buttons:buttons keyIfDict:key style:UIAlertControllerStyleActionSheet success:^(id response) {
//        success(response);
//    } failure:^(NSString *error) {
//        failure(error);
//    }];
//    return alert;
//}
//
//+(UIAlertController *)actionSheetWithTitle:(NSString *)title destButtontitle:(NSString *)destTitle buttons:(NSArray *)buttons keyIfDict:(NSString *)key success: (void (^) (id response))success failure: (void (^) (NSString *error))failure{
//    
//    UIAlertController *alert = [UIAlertController controllerWithTitle:title destButtontitle:destTitle message:@"" buttons:buttons keyIfDict:key style:UIAlertControllerStyleActionSheet success:^(id response) {
//        success(response);
//    } failure:^(NSString *error) {
//        failure(error);
//    }];
//    return alert;
//}

//+(UIAlertController *)controllerWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttons style:(UIAlertControllerStyle)style success: (void (^) (NSString *response))success failure: (void (^) (NSString *error))failure{
//    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
//    
//    for (int i=0; i<buttons.count-1; i++) {
//        NSString *str = [buttons objectAtIndex:i];
//        [alert addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            success(action.title);
//        }]];
//    }
//    
//    [alert addAction:[UIAlertAction actionWithTitle:[buttons lastObject] style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        failure(action.title);
//    }]];
//    
//    return alert;
//}

//+(UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttons TextField:(NSString *)placeholder success: (void (^) (NSString *response))success failure: (void (^) (NSString *error))failure{
//    UIAlertController *alert = [UIAlertController controllerWithTitle:title message:message buttons:buttons style:UIAlertControllerStyleAlert success:^(NSString *response) {
//        NSString *text = [[alert.textFields firstObject] text];
//        success(text);
//    } failure:^(NSString *error) {
//        failure(error);
//    }];
//    
//    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
//     {
//         textField.placeholder = placeholder;
//         if ([placeholder isEqualToString:signin_forgotPasswordFieldPlaceholder]) {
//             textField.keyboardType = UIKeyboardTypeEmailAddress;
//         }
//         
//     }];
//    
//    return alert;
//}
//
//+(UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttons success: (void (^) (NSString *response))success failure: (void (^) (NSString *error))failure{
//    UIAlertController *alert = [UIAlertController controllerWithTitle:title message:message buttons:buttons style:UIAlertControllerStyleAlert success:^(NSString *response) {
//        success(response);
//    } failure:^(NSString *error) {
//        failure(error);
//    }];
//    return alert;
//}
//
//+(UIAlertController *)actionSheetWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttons success: (void (^) (NSString *response))success failure: (void (^) (NSString *error))failure{
//    
//    UIAlertController *alert = [UIAlertController controllerWithTitle:title message:message buttons:buttons style:UIAlertControllerStyleActionSheet success:^(NSString *response) {
//        success(response);
//    } failure:^(NSString *error) {
//        failure(error);
//    }];
//    return alert;
//}
//
//+(UIAlertController *)alertWithTitle:(NSString *)title buttons:(NSArray *)buttons success: (void (^) (NSString *response))success failure: (void (^) (NSString *error))failure{
//    
//    UIAlertController *alert = [UIAlertController controllerWithTitle:title message:@"" buttons:buttons style:UIAlertControllerStyleAlert success:^(NSString *response) {
//        success(response);
//    } failure:^(NSString *error) {
//        failure(error);
//    }];
//    return alert;
//}
//
//+(UIAlertController *)successAlertWithTitle:(NSString *)title message:(NSString *)message completion: (void (^) (BOOL completed))success{
//    UIAlertController *alert = [UIAlertController controllerWithTitle:title message:message buttons:@[btnOkText] style:UIAlertControllerStyleAlert success:^(NSString *response) {
//        success(YES);
//    } failure:^(NSString *error) {
//        success(YES);
//    }];
//    return alert;
//}


//+(UIAlertController *)failureAlertWithTitle:(NSString *)title message:(NSString *)message completion: (void (^) (BOOL completed))success{
//    UIAlertController *alert = [UIAlertController controllerWithTitle:title message:message buttons:@[btnOkText] style:UIAlertControllerStyleAlert success:^(NSString *response) {
//        success(YES);
//    } failure:^(NSString *error) {
//        success(YES);
//    }];
//    return alert;
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
