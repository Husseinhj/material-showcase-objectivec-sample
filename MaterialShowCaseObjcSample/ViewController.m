//
//  ViewController.m
//  MaterialShowCaseObjcSample
//
//  Created by Hussein Habibi Juybari on 2/7/20.
//  Copyright © 2020 aromajoin. All rights reserved.
//

#import "ViewController.h"
#import "MaterialShowcase-Swift.h"

@interface ViewController () <MaterialShowcaseDelegate>
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *viewButton;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // Do any additional setup after loading the view.
    
    NSInteger showcaseIndex = [NSUserDefaults.standardUserDefaults integerForKey:@"MTL_SHOWCASE_INDEX"];
    
    [self performSelector:@selector(viewShowCaseByIndex:) withObject:@(showcaseIndex) afterDelay:1];
}

-(void) viewShowCaseByIndex:(id) showcaseIndex {
    if (!showcaseIndex) {
        NSLog(@"showcaseIndex is empty for uknown reason.");
        return;
    }
    NSInteger index = [showcaseIndex integerValue];
    if (index == 0) {
        [self viewShowcaseOn:self.likeButton withDescription:@"Like button is indicated by a heart symbol, users can use the like button by double tapping on a post they like."];
    } else if (index == 1) {
        [self viewShowcaseOn:self.commentButton withDescription:@"You can comment on your own photos or any photos from users that you are following."];
    } else if (index == 2){
        [self viewShowcaseOn:self.viewButton withDescription:@"Your Instagram should switch to mobile view."];
    } else {
        NSLog(@"There isn't any showcase to user.");
    }
}

-(void) showCaseDidDismissWithShowcase:(MaterialShowcase *)showcase didTapTarget:(BOOL)didTapTarget {
    NSInteger index = 0;
    
    if ([showcase.primaryText isEqualToString:self.likeButton.titleLabel.text]) {
        index = 1;
    } else if ([showcase.primaryText isEqualToString:self.commentButton.titleLabel.text]){
        index = 2;
    } else {
        index = 3;
        NSLog(@"All showcases has been shown.");
    }
    
    [NSUserDefaults.standardUserDefaults setInteger:index
                                             forKey:@"MTL_SHOWCASE_INDEX"];
    [NSUserDefaults.standardUserDefaults synchronize];
    
    [self viewShowCaseByIndex:@(index)];
}
- (void) viewShowcaseOn:(UIButton *) button withDescription:(NSString *) desc {
    MaterialShowcase *showCase = [MaterialShowcase new];
    
    showCase.delegate = self;
    showCase.secondaryText = desc;
    showCase.primaryText = button.titleLabel.text;
    [showCase setTargetViewWithButton:button tapThrough:YES];
    
    [showCase showWithAnimated:YES completion:nil];
}

@end
