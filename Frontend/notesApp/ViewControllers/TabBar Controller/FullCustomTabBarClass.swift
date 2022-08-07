//
//  FullCustomTabBarClass.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 05/02/2022.
//

import UIKit


class FullCustomTabBarClass: UITabBar {
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        self.addShape()
    }

    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = Constants.secondaryColor.cgColor
        shapeLayer.lineWidth = 5.0
        shapeLayer.fillColor = Constants.backgroundColor.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOpacity = 0.3
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
        
    }
    
    
    private func createPath() -> CGPath {
        let topLineMidpoint: CGFloat = self.width/2
        
        let newY: CGFloat = -15
        
        let path = UIBezierPath()
        let sideValue: CGFloat = 80
        
        //get starting point
        path.move(to: CGPoint(x: 0, y: newY))
        
        //line from start point of straight line to start point of curve
        path.addLine(to: CGPoint(x: topLineMidpoint - sideValue, y: newY))
        
        //add dip curve
        path.addQuadCurve(to: CGPoint(x: topLineMidpoint + sideValue, y: newY), controlPoint: CGPoint(x: topLineMidpoint, y: 120))
        
        //add final line
        path.addLine(to: CGPoint(x: self.width, y: newY))
        
        //add side lines
        path.addLine(to: CGPoint(x: self.width, y: self.height ))
        path.addLine(to: CGPoint(x: 0, y: self.height ))

        
        
        path.close()
        
        return path.cgPath
    }
    
    

}




//private func createPath() -> CGPath {
//    let path = UIBezierPath()
//    let centerWidth = self.width/2
//
//    path.move(to: CGPoint(x: 0, y: -30))
//
//    path.addQuadCurve(to: CGPoint(x: self.width,      //to: is where we want the endpoint of the curve to be
//                                  y: -30),
//                      controlPoint: CGPoint(x: centerWidth,
//                                            y: -100))
//    path.addLine(to: CGPoint(x: self.width, y: self.height))
//    path.addLine(to: CGPoint(x: 0, y: self.height))
//    path.close()
//
//    return path.cgPath
//}
