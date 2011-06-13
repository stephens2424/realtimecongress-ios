#import <UIKit/UIKit.h>

@interface RealTimeCongressAppDelegate : NSObject <UIApplicationDelegate> {
    NSUInteger openConnections;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
