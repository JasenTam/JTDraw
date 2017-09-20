//
//  DrawView.swift
//  JTDraw
//
//  Created by 谭振杰 on 2017/9/11.
//  Copyright © 2017年 谭振杰. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var points: [CGPoint] = []
    var point_all: [Dictionary<String, AnyObject>] = []
    var context: CGContext?
    var paint_clr: UIColor?
    
    // MARK: - getter && setter
    override var isMultipleTouchEnabled: Bool {
        
        get {
            return false
        }
        
        set {
            super.isMultipleTouchEnabled = newValue
        }
    }
    
    // MARK: - 生命周期方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.paint_clr = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        // Drawing code
        if ((self.points.count) < 2)  {
            return
        }
        
        self.context = (self.context != nil) ? self.context : UIGraphicsGetCurrentContext()
        // 设置画笔粗细
//        context?.setLineWidth(5.0)
        context?.setLineCap(.round)
        
        // 画以前的轨迹
        for pointDic in self.point_all {
            
            let points = pointDic["points"]
            let color = pointDic["color"]
            
            let points_tmp = Array<CGPoint>.init(points as! Array)
            
            self._setStrokeColor(context: self.context!, color: color as! UIColor)
            for i in 0 ..< (points_tmp.count - 1) {
                
                let point1 = points_tmp[i]
                let point2 = points_tmp[i + 1]
                self.context?.move(to: point1)
                self.context?.addLine(to: point2)
                self.context?.strokePath()
            }
        }
        
        // 画这次
        self._setStrokeColor(context: self.context!, color: self.paint_clr!)
        for i in 0 ..< (self.points.count - 1) {
            let point1 = self.points[i]
            let point2 = self.points[i + 1]
            
            self.context?.move(to: point1)
            self.context?.addLine(to: point2)
            self.context?.strokePath()
        }
    }
    
    // 创建一个array，并且记录初始point
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.points = []
        let touch = touches.first
        let pt: CGPoint = (touch?.location(in: self))!
        self.points.append(pt)
    }
    
    // 移动过程中记录这些points
    // 调用setNeedsDisplay，会触发drawRect方法的调用
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let pt = touches.first?.location(in: self)
        self.points.append(NSValue.init(cgPoint: pt!) as! CGPoint)
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let points_tmp = Array.init(self.points)
        let pointDic = ["points": points_tmp, "color": self.paint_clr ?? UIColor.white] as [String : AnyObject]
        
        self.point_all.append(pointDic as [String : AnyObject])
    }
}

// MARK: - 公共方法
extension DrawView {
    
    /// 设置线条颜色方法，主要作用是实现消除方法
    ///
    /// - Parameters:
    ///   - context: context
    ///   - color: 颜色
    func _setStrokeColor(context: CGContext, color: UIColor) -> Void {
        
        var finalColor = color
        if color == UIColor.clear {
            finalColor = self.backgroundColor!
            context.setLineWidth(10.0)
        } else {
            context.setLineWidth(5.0)
        }
        
        context.setStrokeColor(finalColor.cgColor);
    }
}
