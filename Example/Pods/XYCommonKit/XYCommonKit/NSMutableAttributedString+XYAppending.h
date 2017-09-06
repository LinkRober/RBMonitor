//
//  NSMutableAttributedString+XYAppending.h
//  Pods
//
//  Created by hongru qi on 2017/6/11.
//
//

#import <Foundation/Foundation.h>
#import "XYAttributedStringMaker.h"

@interface NSMutableAttributedString (XYAppending)

+ (NSMutableAttributedString *)xy_makeAttributedString:(void(^)(XYAttributedStringMaker *make))block;

- (NSMutableAttributedString *(^)(CGFloat size))xy_boldFontSize;
- (NSMutableAttributedString *(^)(CGFloat size))xy_fontSize;
- (NSMutableAttributedString *(^)(id param))xy_font; //NSFontAttributeName
- (NSMutableAttributedString *(^)(id param))xy_backgroundColor;//NSBackgroundColorAttributeName
- (NSMutableAttributedString *(^)(id param))xy_foregroundColor;//NSForegroundColorAttributeName

- (NSMutableAttributedString *(^)(id param))xy_paragraphStyle;//NSParagraphStyleAttributeName
- (NSMutableAttributedString *(^)(id param))xy_ligature;//NSLigatureAttributeName
- (NSMutableAttributedString *(^)(id param))xy_kern;//NSKernAttributeName
- (NSMutableAttributedString *(^)(id param))xy_strikethroughStyle;//NSStrikethroughStyleAttributeName
- (NSMutableAttributedString *(^)(id param))xy_underlineStyle;//NSUnderlineStyleAttributeName
- (NSMutableAttributedString *(^)(id param))xy_strokeColor;//NSStrokeColorAttributeName
- (NSMutableAttributedString *(^)(id param))xy_strokeWidth;//NSStrokeWidthAttributeName
- (NSMutableAttributedString *(^)(id param))xy_shadow;//NSShadowAttributeName
- (NSMutableAttributedString *(^)(id param))xy_textEffect;//NSTextEffectAttributeName
- (NSMutableAttributedString *(^)(id param))xy_attachment;//NSAttachmentAttributeName
- (NSMutableAttributedString *(^)(id param))xy_link;//NSLinkAttributeName
- (NSMutableAttributedString *(^)(id param))xy_baselineOffset;//NSBaselineOffsetAttributeName
- (NSMutableAttributedString *(^)(id param))xy_underlineColor;//NSUnderlineColorAttributeName
- (NSMutableAttributedString *(^)(id param))xy_strikethroughColor;//NSStrikethroughColorAttributeName
- (NSMutableAttributedString *(^)(id param))xy_obliqueness;//NSObliquenessAttributeName
- (NSMutableAttributedString *(^)(id param))xy_expansion;//NSExpansionAttributeName
- (NSMutableAttributedString *(^)(id param))xy_writingDirection;//NSWritingDirectionAttributeName
- (NSMutableAttributedString *(^)(id param))xy_verticalGlyphForm;//NSVerticalGlyphFormAttributeName

@end
