//
//  XYAttributedStringMaker.h
//  Pods
//
//  Created by hongru qi on 2017/6/11.
//
//

#import <Foundation/Foundation.h>

@interface XYAttributedStringMaker : NSObject

+ (NSMutableAttributedString *)xy_makeAttributedString:(void(^)(XYAttributedStringMaker *make))block;

/**
 *  设置需要转为NSMutableAttributedString的text
 */
- (NSMutableAttributedString * (^)(NSString *str))text;

/**
 *  直接添加attributeText
 */
- (void (^)(NSAttributedString *attributeStr))attributeText;

/**
 *  拼接attributedstring
 *
 *  @return string
 */
- (NSMutableAttributedString *)append;

- (NSMutableAttributedString *(^)(CGFloat size))boldFontSize;
- (NSMutableAttributedString *(^)(CGFloat size))fontSize;
- (NSMutableAttributedString *(^)(id param))font; //NSFontAttributeName
- (NSMutableAttributedString *(^)(id param))backgroundColor;//NSBackgroundColorAttributeName
- (NSMutableAttributedString *(^)(id param))foregroundColor;//NSForegroundColorAttributeName

- (NSMutableAttributedString *(^)(id param))paragraphStyle;//NSParagraphStyleAttributeName
- (NSMutableAttributedString *(^)(id param))ligature;//NSLigatureAttributeName
- (NSMutableAttributedString *(^)(id param))kern;//NSKernAttributeName
- (NSMutableAttributedString *(^)(id param))strikethroughStyle;//NSStrikethroughStyleAttributeName
- (NSMutableAttributedString *(^)(id param))underlineStyle;//NSUnderlineStyleAttributeName
- (NSMutableAttributedString *(^)(id param))strokeColor;//NSStrokeColorAttributeName
- (NSMutableAttributedString *(^)(id param))strokeWidth;//NSStrokeWidthAttributeName
- (NSMutableAttributedString *(^)(id param))shadow;//NSShadowAttributeName
- (NSMutableAttributedString *(^)(id param))textEffect;//NSTextEffectAttributeName
- (NSMutableAttributedString *(^)(id param))attachment;//NSAttachmentAttributeName
- (NSMutableAttributedString *(^)(id param))link;//NSLinkAttributeName
- (NSMutableAttributedString *(^)(id param))baselineOffset;//NSBaselineOffsetAttributeName
- (NSMutableAttributedString *(^)(id param))underlineColor;//NSUnderlineColorAttributeName
- (NSMutableAttributedString *(^)(id param))strikethroughColor;//NSStrikethroughColorAttributeName
- (NSMutableAttributedString *(^)(id param))obliqueness;//NSObliquenessAttributeName
- (NSMutableAttributedString *(^)(id param))expansion;//NSExpansionAttributeName
- (NSMutableAttributedString *(^)(id param))writingDirection;//NSWritingDirectionAttributeName
- (NSMutableAttributedString *(^)(id param))verticalGlyphForm;//NSVerticalGlyphFormAttributeName

@end
