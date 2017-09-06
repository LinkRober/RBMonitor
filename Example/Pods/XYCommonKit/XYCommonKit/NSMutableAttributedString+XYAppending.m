//
//  NSMutableAttributedString+XYAppending.m
//  Pods
//
//  Created by hongru qi on 2017/6/11.
//
//

#import "NSMutableAttributedString+XYAppending.h"

@implementation NSMutableAttributedString (XYAppending)

+ (NSMutableAttributedString *)xy_makeAttributedString:(void (^)(XYAttributedStringMaker *))block
{
    XYAttributedStringMaker *constraintMaker = [[XYAttributedStringMaker alloc] init];
    block(constraintMaker);
    return [constraintMaker append];
}

- (NSMutableAttributedString *(^)(id s))xy_font
{
    return ^(UIFont *textFont) {
        if (textFont) {
            [self xy_setCommonAttributes:@{NSFontAttributeName:textFont}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))xy_boldFontSize
{
    return ^(CGFloat size) {
        if (size) {
            [self xy_setCommonAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:size]}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))xy_fontSize
{
    return ^(CGFloat size) {
        if (size) {
            [self xy_setCommonAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_backgroundColor
{
    return ^(UIColor *backgroundColor){
        if (backgroundColor) {
            [self xy_setCommonAttributes:@{NSBackgroundColorAttributeName:backgroundColor}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_foregroundColor
{
    return ^(UIColor *foregroundColor) {
        if (foregroundColor) {
            [self xy_setCommonAttributes:@{NSForegroundColorAttributeName:foregroundColor}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_paragraphStyle
{
    return ^(id paragraphStyle) {
        if (paragraphStyle) {
            [self xy_setCommonAttributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_ligature
{
    return ^(id ligature) {
        if (ligature) {
            [self xy_setCommonAttributes:@{NSLigatureAttributeName:ligature}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_kern
{
    return ^(id kern) {
        if (kern) {
            [self xy_setCommonAttributes:@{NSKernAttributeName:kern}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_strikethroughStyle
{
    return ^(id strikethroughStyle) {
        if (strikethroughStyle) {
            [self xy_setCommonAttributes:@{NSStrikethroughStyleAttributeName:strikethroughStyle}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_underlineStyle
{
    return ^(id underlineStyle) {
        if (underlineStyle) {
            [self xy_setCommonAttributes:@{NSUnderlineStyleAttributeName:underlineStyle}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_strokeColor
{
    return ^(id strokeColor) {
        if (strokeColor) {
            [self xy_setCommonAttributes:@{NSStrokeColorAttributeName:strokeColor}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_strokeWidth
{
    return ^(id strokeWidth) {
        if (strokeWidth) {
            [self xy_setCommonAttributes:@{NSStrokeWidthAttributeName:strokeWidth}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_shadow
{
    return ^(id shadow) {
        if (shadow) {
            [self xy_setCommonAttributes:@{NSShadowAttributeName:shadow}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_textEffect
{
    return ^(id textEffect) {
        if (textEffect) {
            [self xy_setCommonAttributes:@{NSTextEffectAttributeName:textEffect}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_attachment
{
    return ^(id attachment) {
        if (attachment) {
            [self xy_setCommonAttributes:@{NSAttachmentAttributeName:attachment}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_link
{
    return ^(id link) {
        if (link) {
            [self xy_setCommonAttributes:@{NSLinkAttributeName:link}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_baselineOffset
{
    return ^(id baselineOffset) {
        if (baselineOffset) {
            [self xy_setCommonAttributes:@{NSBaselineOffsetAttributeName:baselineOffset}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_underlineColor
{
    return ^(id underlineColor) {
        if (underlineColor) {
            [self xy_setCommonAttributes:@{NSUnderlineColorAttributeName:underlineColor}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_strikethroughColor
{
    return ^(id strikethroughColor) {
        if (strikethroughColor) {
            [self xy_setCommonAttributes:@{NSStrikethroughColorAttributeName:strikethroughColor}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_obliqueness
{
    return ^(id obliqueness) {
        if (obliqueness) {
            [self xy_setCommonAttributes:@{NSObliquenessAttributeName:obliqueness}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_expansion
{
    return ^(id expansion) {
        if (expansion) {
            [self xy_setCommonAttributes:@{NSExpansionAttributeName:expansion}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_writingDirection
{
    return ^(id writingDirection) {
        if (writingDirection) {
            [self xy_setCommonAttributes:@{NSWritingDirectionAttributeName:writingDirection}];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(id))xy_verticalGlyphForm
{
    return ^(id verticalGlyphForm) {
        if (verticalGlyphForm) {
            [self xy_setCommonAttributes:@{NSVerticalGlyphFormAttributeName:verticalGlyphForm}];
        }
        return self;
    };
}

- (void)xy_setCommonAttributes:(NSDictionary *)attributes
{
    [self addAttributes:attributes range:NSMakeRange(0, self.length)];
}
@end
