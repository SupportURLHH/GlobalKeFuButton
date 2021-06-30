//
//  FloatActionBtn.swift
//  zyk_ios
//
//  Created by 范庆宇 on 2020/5/28.
//  Copyright © 2020 com.miaoxinren.inc. All rights reserved.
//

import UIKit
import Foundation

enum ZYKFloatActionType {
    case normal
    case phone
    case onlineChat
}

struct SharedFloatStatic {
    static var instance: ZYKFloatAction? = nil
}

class ZYKFloatAction: UIImageView {
    class func shared()->ZYKFloatAction {
        _ = ZYKFloatAction.__once
        return SharedFloatStatic.instance!
    }
    
    private static var __once: () = {
        let floatAction = ZYKFloatAction.init(frame: CGRect.init(x: UIScreen.main.bounds.size.width-255, y: UIScreen.main.bounds.size.height - 49 - 100, width: 240, height: 50))
        SharedFloatStatic.instance = floatAction
    }()
    
    var isOpen:Bool = false
    
    var actionClickBlock:((ZYKFloatActionType)->())?
    
    private var startTouchPoint:CGPoint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        
    }
    
    func show() {
        hide()
        UIApplication.shared.windows.first?.addSubview(self)
        
    }
    
    func hide() {
        self.removeFromSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func setUI() {
        self.isUserInteractionEnabled = true
        // v: 切割试图使用
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 240, height: 50))
        v.layer.cornerRadius = 25
        v.layer.masksToBounds = true
        
        self.addSubview(v)
        self.addSubview(customerTextImg)
        v.addSubview(backGroundV)
        v.addSubview(customerAvatar)
        
        customerAvatar.isUserInteractionEnabled = true
        // 添加优先级更高的 tapGesture，可识别 点击和滑动
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapGesture))
        customerAvatar.addGestureRecognizer(tapGestureRecognizer)
        
        customerChat.isHidden = true
        customerPhone.isHidden = true
        backGroundV.frame = CGRect.init(x: 190, y: 0, width: 50, height: 50)
    }
    
    func animation() {
        if customerChat.isHidden {
            customerChat.isHidden = false
            customerPhone.isHidden = false
            customerChat.alpha = 0
            customerPhone.alpha = 0
            UIView.animate(withDuration: 0.4, animations: {
                self.customerChat.alpha = 0.2
                self.customerPhone.alpha = 0.2
                self.backGroundV.frame = CGRect.init(x: 0, y: 0, width: 240, height: 50)
            }){ (finished) in
                self.customerChat.alpha = 1.0
                self.customerPhone.alpha = 1.0
            }
        }else {
            self.customerChat.isHidden = true
            self.customerPhone.isHidden = true
            UIView.animate(withDuration: 0.4, animations: {
                self.backGroundV.frame = CGRect.init(x: 190, y: 0, width: 50, height: 50)
                
            }) { (finished) in
                
            }
        }
    }

    private lazy var backGroundV: UIView = {
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 240, height: 50))
        let layer = CAGradientLayer.createGradientLayerOnView(view: v, fromColor: UIColor.init(red: 250.0/255.0, green: 157.0/255.0, blue: 10.0/255.0, alpha: 1.0), toColor: UIColor.init(red: 255.0/255.0, green: 132.0/255.0, blue: 37.0/255.0, alpha: 1.0), fromPoint: CGPoint(x: 0.5, y: 0), toPoint: CGPoint(x: 0.5, y: 1))
        layer.cornerRadius = 25
        v.layer.insertSublayer(layer, at: 0)
        v.addSubview(customerChat)
        let line = UIView.init(frame: CGRect.init(x: 102, y: 15, width: 1, height: 20))
        line.backgroundColor = .white
        v.addSubview(line)
        v.addSubview(customerPhone)
        return v
        
    }()
    
    private lazy var customerAvatar:UIImageView = {
        let v = UIImageView.init(frame: CGRect.init(x: 194, y: 4, width: 42, height: 42))
        v.isUserInteractionEnabled = true
        v.image = UIImage(named: "cs_avatar")
        return v
        
    }()
    
    private lazy var customerTextImg:UIImageView = {
        let v = UIImageView.init(frame: CGRect.init(x: 190, y: 50, width: 52, height: 23))
        v.image = UIImage(named: "cs_text")
        return v
        
    }()
    
    private lazy var customerChat:UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: 15, y: 15, width: 80, height: 20))
        btn.setImage(UIImage(named: "cs_chat"), for: .normal)
        btn.imageView?.isUserInteractionEnabled = false
        btn.setTitle("在线沟通", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.addTarget(self, action: #selector(chat), for: .touchUpInside)
        btn.layoutWithStatus(status: .normal, and: 9)
        return btn
        
    }()
    
    @objc func chat() {
        actionClickBlock?(.onlineChat)
        
    }
    
    private lazy var customerPhone:UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: 110, y: 15, width: 80, height: 20))
        btn.setImage(UIImage(named: "cs_phone"), for: .normal)
        btn.imageView?.isUserInteractionEnabled = false
        btn.setTitle("电话咨询", for: .normal)
        btn.addTarget(self, action: #selector(phone), for: .primaryActionTriggered)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.layoutWithStatus(status: .normal, and: 9)
        return btn
        
    }()
    
    @objc func phone() {
        actionClickBlock?(.phone)
    }
    
    @objc func tapGesture() {
        animation()
        actionClickBlock?(.normal)
        
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard self.point(inside: point, with: event) else { return nil }
        
        if customerAvatar.point(inside: convert(point, to: customerAvatar), with: event) {
            return customerAvatar
            
        }else if customerPhone.point(inside: convert(point, to: customerPhone), with: event) {
            return customerPhone
            
        }else if customerChat.point(inside: convert(point, to: customerChat), with: event) {
            return customerChat
            
        }else {
            return nil
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.randomElement()?.location(in: self)
        startTouchPoint = point
        if startTouchPoint?.x ?? 0.0 > 180.0 {
            self.superview?.bringSubviewToFront(self)
            super.touchesBegan(touches, with: event)
        }
        
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.randomElement()?.location(in: self)
        let dx = (point?.x ?? 0.0) - (startTouchPoint?.x ?? 0.0)
        let dy = (point?.y ?? 0.0) - (startTouchPoint?.y ?? 0.0)
        
        var newCenter = CGPoint.init(x: self.center.x + dx, y: self.center.y + dy)
        //
        let halfX = self.bounds.midX
        newCenter.x = CGFloat(fmaxf(Float(halfX), Float(newCenter.x)))
        newCenter.x = CGFloat(fminf(Float((self.superview?.bounds.size.width)! - halfX),Float(newCenter.x)))
        
        //
        let halfY = self.bounds.midY
        newCenter.y = CGFloat(fmaxf(Float(halfY), Float(newCenter.y)))
        newCenter.y = CGFloat(fminf(Float((self.superview?.bounds.size.height)! - halfY), Float(newCenter.y)))
        
        self.center = newCenter
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.2, animations: {
            var originalFrame = self.frame
            originalFrame = CGRect.init(x: UIScreen.main.bounds.size.width - 255, y: originalFrame.origin.y, width: originalFrame.size.width, height: originalFrame.size.height)
            self.frame = originalFrame
            
        }, completion: nil)
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

}




