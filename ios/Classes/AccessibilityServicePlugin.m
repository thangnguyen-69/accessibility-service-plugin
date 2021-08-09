#import "AccessibilityServicePlugin.h"
#if __has_include(<accessibility_service/accessibility_service-Swift.h>)
#import <accessibility_service/accessibility_service-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "accessibility_service-Swift.h"
#endif

@implementation AccessibilityServicePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAccessibilityServicePlugin registerWithRegistrar:registrar];
}
@end
