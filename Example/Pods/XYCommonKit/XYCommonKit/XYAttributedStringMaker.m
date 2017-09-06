//
//  XYAttributedStringMaker.m
//  Pods
//
//  Created by hongru qi on 2017/6/11.
//
//

#import "XYAttributedStringMaker.h"

@interface XYAttributedStringMaker()

@property (nonatomic, strong) NSMutableArray *attributeStringArray;
@property (nonatomic, strong) NSMutableAttributedString *attr;
@end

@implementation XYAttributedStringMaker

+ (NSMutableAttributedString *)xy_makeAttributedString:(void (^)(XYAttributedStringMaker *))block
{
    XYAttributedStringMaker *constraintMaker = [[XYAttributedStringMaker alloc] init];
    block(constraintMaker);
    return [constraintMaker append];
}

- (NSMutableAttributedString *(^)(NSString *))text
{
    return ^NSMutableAttributedString *(id str){
        _attr = [[NSMutableAttributedString alloc] initWithString:str];
        [self.attributeStringArray addObject:_attr];
        return _attr;
    };
}

- (void (^)(NSAttributedString *))attributeText
{
    return ^void (id str){
        if (self) {
            [self.attributeStringArray addObject:str];
        }
    };
}

- (NSMutableAttributedString *(^)(id s))font
{
    return ^(UIFont *textFont) {
        if (textFont) {
            [self setCommonAttributes:@{NSFontAttributeName:textFont}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))boldFontSize
{
    return ^(CGFloat size) {
        if (size) {
            [self setCommonAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:size]}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))fontSize
{
    return ^(CGFloat size) {
        if (size) {
            [self setCommonAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))backgroundColor
{
    return ^(UIColor *backgroundColor){
        if (backgroundColor) {
            [self setCommonAttributes:@{NSBackgroundColorAttributeName:backgroundColor}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))foregroundColor
{
    return ^(UIColor *foregroundColor) {
        if (foregroundColor) {
            [self setCommonAttributes:@{NSForegroundColorAttributeName:foregroundColor}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))paragraphStyle
{
    return ^(id paragraphStyle) {
        if (paragraphStyle) {
            [self setCommonAttributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))ligature
{
    return ^(id ligature) {
        if (ligature) {
            [self setCommonAttributes:@{NSLigatureAttributeName:ligature}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))kern
{
    return ^(id kern) {
        if (kern) {
            [self setCommonAttributes:@{NSKernAttributeName:kern}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))strikethroughStyle
{
    return ^(id strikethroughStyle) {
        if (strikethroughStyle) {
            [self setCommonAttributes:@{NSStrikethroughStyleAttributeName:strikethroughStyle}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))underlineStyle
{
    return ^(id underlineStyle) {
        if (underlineStyle) {
            [self setCommonAttributes:@{NSUnderlineStyleAttributeName:underlineStyle}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))strokeColor
{
    return ^(id strokeColor) {
        if (strokeColor) {
            [self setCommonAttributes:@{NSStrokeColorAttributeName:strokeColor}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))strokeWidth
{
    return ^(id strokeWidth) {
        if (strokeWidth) {
            [self setCommonAttributes:@{NSStrokeWidthAttributeName:strokeWidth}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))shadow
{
    return ^(id shadow) {
        if (shadow) {
            [self setCommonAttributes:@{NSShadowAttributeName:shadow}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))textEffect
{
    return ^(id textEffect) {
        if (textEffect) {
            [self setCommonAttributes:@{NSTextEffectAttributeName:textEffect}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))attachment
{
    return ^(id attachment) {
        if (attachment) {
            [self setCommonAttributes:@{NSAttachmentAttributeName:attachment}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))link
{
    return ^(id link) {
        if (link) {
            [self setCommonAttributes:@{NSLinkAttributeName:link}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))baselineOffset
{
    return ^(id baselineOffset) {
        if (baselineOffset) {
            [self setCommonAttributes:@{NSBaselineOffsetAttributeName:baselineOffset}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))underlineColor
{
    return ^(id underlineColor) {
        if (underlineColor) {
            [self setCommonAttributes:@{NSUnderlineColorAttributeName:underlineColor}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))strikethroughColor
{
    return ^(id strikethroughColor) {
        if (strikethroughColor) {
            [self setCommonAttributes:@{NSStrikethroughColorAttributeName:strikethroughColor}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))obliqueness
{
    return ^(id obliqueness) {
        if (obliqueness) {
            [self setCommonAttributes:@{NSObliquenessAttributeName:obliqueness}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))expansion
{
    return ^(id expansion) {
        if (expansion) {
            [self setCommonAttributes:@{NSExpansionAttributeName:expansion}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))writingDirection
{
    return ^(id writingDirection) {
        if (writingDirection) {
            [self setCommonAttributes:@{NSWritingDirectionAttributeName:writingDirection}];
        }
        return self.attr;
    };
}

- (NSMutableAttributedString *(^)(id))verticalGlyphForm
{
    return ^(id verticalGlyphForm) {
        if (verticalGlyphForm) {
            [self setCommonAttributes:@{NSVerticalGlyphFormAttributeName:verticalGlyphForm}];
        }
        return self.attr;
    };
}

- (void)setCommonAttributes:(NSDictionary *)attributes
{
    [self.attr addAttributes:attributes range:NSMakeRange(0, self.attr.length)];
}

- (NSMutableAttributedString *)append
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    [self.attributeStringArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [attributedString appendAttributedString:obj];
    }];
    return attributedString;
}

- (NSMutableArray *)attributeStringArray
{
    if (!_attributeStringArray) {
        _attributeStringArray = [[NSMutableArray alloc] init];
    }
    return _attributeStringArray;
}
@end
