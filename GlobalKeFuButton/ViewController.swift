//
//  ViewController.swift
//  GlobalKeFuButton
//
//  Created by 范庆宇 on 2021/6/16.
//

import UIKit

class ViewController: UIViewController {

    var show:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ZYKFloatAction.shared().show()
        ZYKFloatAction.shared().actionClickBlock = { (actionType) in
            if actionType == .normal {
                NSLog("点击客服头像")
                
            }else if actionType == .phone {
                NSLog("电话沟通")
                
            }else if actionType == .onlineChat {
                NSLog("在线沟通")
                
            }
            
        }
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        show = !show
//        if show {
//            ZYKFloatAction.shared().show()
//
//        }else {
//            ZYKFloatAction.shared().hide()
//
//        }
//
//    }
}

