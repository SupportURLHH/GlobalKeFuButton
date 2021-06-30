//
//  UIButton+Layout.swift
//  GlobalKeFuButton
//
//  Created by 范庆宇 on 2021/6/16.
//

import Foundation
import UIKit
enum FQYLayoutImagePosition {
    case normal //图左字右
    case imageRight
    case imageTop
    case imageBottom
}

extension UIButton {
    func layoutWithStatus(status: FQYLayoutImagePosition, and margin:CGFloat) {
        
        let imgWidth:CGFloat = self.imageView?.bounds.size.width ?? 0.0
        let imgHeight:CGFloat = self.imageView?.bounds.size.height ?? 0.0
        var labWidth:CGFloat = self.titleLabel?.bounds.size.width ?? 0.0
        let labHeight:CGFloat = self.titleLabel?.bounds.size.height ?? 0.0
        let text = (self.titleLabel?.text ?? "") as NSString
        let textSize:CGSize = text.size(withAttributes: [.font:self.titleLabel?.font as Any ])
        
        let frameSize = CGSize.init(width: ceil(textSize.width), height: ceil(textSize.height))
        
        if labWidth < frameSize.width {
            labWidth = frameSize.width
        }
        let kMargin:CGFloat = margin/2.0
        switch (status) {
            case .normal:
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -kMargin, bottom: 0, right: kMargin)
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: kMargin, bottom: 0, right: -kMargin)
                break
                
            case .imageRight://图右字左
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left:labWidth + kMargin, bottom: 0, right: -labWidth - kMargin)
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imgWidth - kMargin, bottom: 0, right: imgWidth + kMargin)
                break
                
            case .imageTop://图上字下
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left:0, bottom: labWidth + margin, right: -labWidth)
                self.titleEdgeInsets = UIEdgeInsets(top: imgHeight + margin, left: -imgWidth, bottom: 0, right: 0)
                break
                
            case .imageBottom://图下字上
                self.imageEdgeInsets = UIEdgeInsets(top: labHeight + margin, left:0, bottom: 0, right: -labWidth)
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imgWidth, bottom: imgHeight + margin, right: 0)
                break
                
        }
        
    }
}

