//
//  AboutViewController.h
//  RealTimeCongress
//
//  Created by Tom Tsai on 5/24/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutViewController : UIViewController {
    UIWebView *webView;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;

@end
