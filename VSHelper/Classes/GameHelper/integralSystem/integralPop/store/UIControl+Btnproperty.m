//
//  UIControl+Btnproperty.m
//  VVSDK
//
//  Created by admin on 9/6/22.
//

#import "UIControl+Btnproperty.h"
#import "objc/runtime.h"

static const void * OrderTagsBy = &OrderTagsBy;
static const void * ChangeTypeBy = &ChangeTypeBy;

@implementation UIControl (Btnproperty)
@dynamic CodeTags;
@dynamic ChangeType;
 
- (void)setCodeTags:(NSString *)CodeTags{
    objc_setAssociatedObject(self, OrderTagsBy, CodeTags, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
 
-(NSString *)CodeTags {
  return objc_getAssociatedObject(self, OrderTagsBy);
}

- (void)setChangeType:(NSString *)ChangeType{
    objc_setAssociatedObject(self, ChangeTypeBy, ChangeType, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)ChangeType{
    return objc_getAssociatedObject(self, ChangeTypeBy);
}
@end
