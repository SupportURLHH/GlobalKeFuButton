//
//  CAGradientLayer+Extension.swift
//  GlobalKeFuButton
//
//  Created by 范庆宇 on 2021/6/16.
//

import Foundation
import UIKit

extension CAGradientLayer {
    
    static func createGradientLayerOnView(view:UIView, fromColor:UIColor, toColor:UIColor, fromPoint:CGPoint, toPoint:CGPoint) -> CAGradientLayer {
        
        // CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        // 创建渐变色数组，需要转换为CGColor颜色
        gradientLayer.colors = [fromColor.cgColor, toColor.cgColor]
        
        // 设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
        gradientLayer.startPoint = fromPoint
        gradientLayer.endPoint = toPoint
        
        // 设置颜色变化点，取值范围 0.0~1.0
        gradientLayer.locations = [NSNumber.init(value: 0),NSNumber.init(value: 1)]
        
        return gradientLayer
    }
}
