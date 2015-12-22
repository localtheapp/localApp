//
//  ViewController.m
//  LocalApp
//
//  Created by Nitin Sharma on 10/11/15.
//  Copyright © 2015 LocalApp. All rights reserved.
//

#import "RootViewController.h"
#import "WelcomeScreenViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  self.navigationController.navigationBarHidden = NO;
  self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255.0f/255.0f green:79.0f/255.0f blue:78.0/255.0f alpha:1.0f];
  self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
  self.navigationController.navigationBar.translucent = NO;
  [self.navigationController.navigationBar setTitleTextAttributes:
   @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
  
  // Set the background colour for the app
  self.view.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:79.0f/255.0f blue:78.0/255.0f alpha:1.0f];
  
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
  
}

- (IBAction)getStartedButton:(id)sender {
  UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  WelcomeScreenViewController *welcomeVC = [mystoryboard instantiateViewControllerWithIdentifier:@"WelcomeScreenViewController"];
  [self.navigationController pushViewController:welcomeVC animated:YES];
//  [self presentViewController:welcomeVC animated:YES completion:nil];
}
@end