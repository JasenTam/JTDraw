//
//  ViewController.swift
//  JTDraw
//
//  Created by 谭振杰 on 2017/9/11.
//  Copyright © 2017年 谭振杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tv: DrawView?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.view.isUserInteractionEnabled = true
        
        let screenSize = UIScreen.main.bounds.size
        tv = DrawView.init(frame: CGRect.init(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        tv?.backgroundColor = UIColor.black
        
        self.view.addSubview(tv!)
        
        let seg: UISegmentedControl = UISegmentedControl.init(items: "White Red Blue Green Yellow Clear".components(separatedBy: " "))
        seg.tintColor = UIColor.white
        seg.center = CGPoint.init(x: self.view.center.x, y: (self.view.bounds.size.height - seg.bounds.size.height))
        self.view.addSubview(seg)
        
        seg.addTarget(self, action: #selector(colorChange(seg:)), for: .valueChanged)
    }
    
    func colorChange(seg: UISegmentedControl) {
        switch seg.selectedSegmentIndex {
        case 0:
            tv?.paint_clr = UIColor.white
            break
        case 1:
            tv?.paint_clr = UIColor.red
            break
        case 2:
            tv?.paint_clr = UIColor.blue
            break
        case 3:
            tv?.paint_clr = UIColor.green
            break
        case 4:
            tv?.paint_clr = UIColor.yellow
            break
        case 5:
            tv?.paint_clr = UIColor.clear
            break
        default:
            
            break
        }
    }
}

