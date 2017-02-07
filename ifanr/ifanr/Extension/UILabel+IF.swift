//
//  UILabel+IF.swift
//  ifanr
//
//  Created by sys on 16/7/7.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

extension UILabel {

    class func setAttributText(_ content: String?, lineSpcae: CGFloat) -> NSAttributedString {
        let attrs = NSMutableAttributedString(string: content!)
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = lineSpcae
        paragraphStyle.firstLineHeadIndent    = 0.0;
        paragraphStyle.hyphenationFactor      = 0.0;
        paragraphStyle.paragraphSpacingBefore = 0.0;
        
        attrs.addAttribute(NSParagraphStyleAttributeName,
                           value: paragraphStyle,
                           range: NSMakeRange(0, (content!.characters.count)))
        
        return attrs
    }
    
}
