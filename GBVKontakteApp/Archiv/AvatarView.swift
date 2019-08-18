//
//  AvatarView.swift
//  
//
//  Created by Dmitry on 22/06/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

//@IBDesignable
//class CustomView: UIView {
//
//    let imageView = UIImageView()
//
//    @IBInspectable var image: UIImage? {
//        didSet {
//            addImage()
//        }
//    }
//
//    @IBOutlet weak var customView: UIImageView!
//
//    func addImage() {
//        imageView.image = image
//    }
//
//    //    var isFilled: Bool = true {
//    //        didSet{
//    //            setNeedsDisplay()
//    //        }
//    //    }
//
//    @IBInspectable var radius: CGFloat = 100
//
//    override class var layerClass: AnyClass {
//        return CAShapeLayer.self
//    }
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Рисование простых фигур
//        //    override func draw(_ rect: CGRect) {
//        //        super.draw(rect)
//        //        guard let context = UIGraphicsGetCurrentContext() else { return }
//        //        context.setFillColor(UIColor.green.cgColor)
//        //        context.fill(CGRect(x: 0, y: 0, width: 50, height: 50))
//        //        let testView = CustomView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        //        testView.backgroundColor = .white
//        //    }
//
//        // Рисование сложных фигур
//        // Круг
//        //        guard let context = UIGraphicsGetCurrentContext() else { return }
//        //        context.setFillColor(UIColor.blue.cgColor)
//        ////        context.setStrokeColor(UIColor.red.cgColor)
//        ////        context.setLineWidth(3)
//        //        context.fillEllipse(in: CGRect(x: rect.midX - radius,
//        //                                       y: rect.midY - radius,
//        //                                       width: radius * 2,
//        //                                       height: radius * 2))
//        //
//        //        context.closePath()
//        //        context.strokePath()
//        //        isFilled ? context.fill() : context.stroke()
//
//        //        let testView = UIView(frame: CGRect(x: rect.midX - radius,
//        //                                            y: rect.midY - radius,
//        //                                            width: radius * 2,
//        //                                            height: radius * 2))
//
//        //        context.setStrokeColor(UIColor.red.cgColor)
//        //
//        //        // Звезда
//
//        //        context.move(to: CGPoint(x: 40, y: 20))
//        //        context.addLine(to: CGPoint(x: 45, y: 40))
//        //        context.addLine(to: CGPoint(x: 65, y: 40))
//        //        context.addLine(to: CGPoint(x: 50, y: 50))
//        //        context.addLine(to: CGPoint(x: 60, y: 70))
//        //        context.addLine(to: CGPoint(x: 40, y: 55))
//        //        context.addLine(to: CGPoint(x: 20, y: 70))
//        //        context.addLine(to: CGPoint(x: 30, y: 50))
//        //        context.addLine(to: CGPoint(x: 15, y: 40))
//        //        context.addLine(to: CGPoint(x: 35, y: 40))
//        //        context.closePath()
//        //        context.strokePath()
//
//        //        let maskLayer = CAShapeLayer()
//        //        let path = UIBezierPath()
//        //        path.move(to: CGPoint(x: 40, y: 20))
//        //        path.addLine(to: CGPoint(x: 45, y: 40))
//        //        path.addLine(to: CGPoint(x: 65, y: 40))
//        //        path.addLine(to: CGPoint(x: 50, y: 50))
//        //        path.addLine(to: CGPoint(x: 60, y: 70))
//        //        path.addLine(to: CGPoint(x: 40, y: 55))
//        //        path.addLine(to: CGPoint(x: 20, y: 70))
//        //        path.addLine(to: CGPoint(x: 30, y: 50))
//        //        path.addLine(to: CGPoint(x: 15, y: 40))
//        //        path.addLine(to: CGPoint(x: 35, y: 40))
//        //        path.close()
//        //        path.stroke()
//        //        context.addPath(path.cgPath)
//        //        context.strokePath()
//
//
//        //        maskLayer.path = starPath.cgPath
//        //        testView.layer.mask = maskLayer
//
//        //        let starPath = UIBezierPath()
//        //        starPath.move(to: CGPoint(x: 40, y: 20))
//        //        starPath.addLine(to: CGPoint(x: 45, y: 40))
//        //        starPath.addLine(to: CGPoint(x: 65, y: 40))
//        //        starPath.addLine(to: CGPoint(x: 50, y: 50))
//        //        starPath.addLine(to: CGPoint(x: 60, y: 70))
//        //        starPath.addLine(to: CGPoint(x: 40, y: 55))
//        //        starPath.addLine(to: CGPoint(x: 20, y: 70))
//        //        starPath.addLine(to: CGPoint(x: 30, y: 50))
//        //        starPath.addLine(to: CGPoint(x: 15, y: 40))
//        //        starPath.addLine(to: CGPoint(x: 35, y: 40))
//        //        starPath.close()
//        //        starPath.stroke()
//
//        // Ромб
//        //        let rombPath = UIBezierPath()
//        //        rombPath.move(to: CGPoint(x: 100, y: 50))
//        //        rombPath.addLine(to: CGPoint(x: 150, y: 100))
//        //        rombPath.addLine(to: CGPoint(x: 100, y: 150))
//        //        rombPath.addLine(to: CGPoint(x: 50, y: 100))
//        //        rombPath.close()
//        //        UIColor.blue.setFill()
//        //        UIColor.red.setStroke()
//        //        isFilled ? rombPath.fill() : rombPath.stroke()
//
//        // Круг
//        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 103,y: 103), radius: CGFloat(98), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
//        //        let circlePath = UIBezierPath()
//        //        circlePath.addArc(withCenter: CGPoint(x: rect.midX, y: rect.midY), radius: radius, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
//        circlePath.close()
//        UIColor.blue.setFill()
//        UIColor.red.setStroke()
//        circlePath.fill()
//
//        //        isFilled ? circlePath.fill() : circlePath.stroke()
//        //        maskLayer.path = circlePath.cgPath
//        //        maskLayer.shadowRadius = 10
//        //        maskLayer.shadowOpacity = 0.7
//        //        maskLayer.shadowOffset = CGSize.zero
//        //
//        //        let shapeLayer = CAShapeLayer()
//        //        shapeLayer.path = circlePath.cgPath
//        //        shapeLayer.fillColor = UIColor.blue.cgColor
//        //        shapeLayer.strokeColor = UIColor.red.cgColor
//        //        shapeLayer.lineWidth = 3.0
//
//        //customView.layer.addSublayer(shapeLayer)
//
//        //        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
//        ////        imageView.frame = CGRect(x: rect.midX - radius,
//        ////                                 y: rect.midY - radius,
//        ////                                 width: radius * 2,
//        ////                                 height: radius * 2)
//        //        imageView.contentMode = .scaleAspectFit
//        //        addSubview(imageView)
//        //
//        //        imageView.layer.borderColor = UIColor.gray.cgColor
//        //        imageView.layer.borderWidth = 4.0
//        //
//        //        imageView.layer.cornerRadius = 100.0
//        //
//        //        imageView.layer.masksToBounds = true
//        setup()
//
//        //        customView.layer.shadowColor = UIColor.black.cgColor
//        //        customView.layer.shadowOpacity = 0.7
//        //        customView.layer.shadowRadius = 15
//        //        customView.layer.shadowOffset = CGSize.zero
//    }
//
//    override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//        setup()
//    }
//
//    func setup () {
//
//        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
//        imageView.contentMode = .scaleAspectFit
//        addSubview(imageView)
////        imageView.frame = CGRect(x: 1, y: 1, width: 200, height: 200)
////        addSubview(imageView)
//
//        // Граница вокруг картинки
//        imageView.layer.borderColor = UIColor.gray.cgColor
//        imageView.layer.borderWidth = 0.5
////        backgroudColor != .clear
//
//        // Углы
//        imageView.layer.cornerRadius = 100.0
//
//        // Поправим отображения слоя за его границами
//        imageView.layer.masksToBounds = true
//        imageView.clipsToBounds = true
////        imageView.backgroundColor = .clear
//
//    }
//
//}

//@IBDesignable
class CustomView2: UIView {
    
    private var shadowLayer: CAShapeLayer!
    
    @IBInspectable
    var shadowColor: UIColor = UIColor.black
    @IBInspectable
    var shadowRadius: CGFloat = 4
    @IBInspectable
    var shadowOpacity: Float = 0.9
    
    @IBOutlet weak var customView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        customView.layer.cornerRadius = frame.height / 2
        customView.clipsToBounds = true
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: frame.size.height / 2).cgPath
            shadowLayer.shadowColor = shadowColor.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = .zero
            shadowLayer.shadowOpacity = shadowOpacity
            shadowLayer.shadowRadius = shadowRadius
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}


//class CustomView3: UIImageView {
//
//    @IBInspectable var radius: CGFloat = 100 {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        //        guard let context = UIGraphicsGetCurrentContext() else { return }
//        //        context.setStrokeColor(UIColor.red.cgColor)
//        //
//        //        // Круг
//        //        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 100,y: 100), radius: CGFloat(20), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
//        //        circlePath.close()
//        //        UIColor.clear.setFill()
//        //        UIColor.red.setStroke()
//        //        isFilled ? circlePath.fill() : circlePath.stroke()
//        //        //        let shapeLayer = CAShapeLayer()
//        //        //        shapeLayer.path = circlePath.cgPath
//        //        //        shapeLayer.fillColor = UIColor.blue.cgColor
//        //        //        shapeLayer.strokeColor = UIColor.red.cgColor
//        //        //        shapeLayer.lineWidth = 3.0
//        //
//        //        //customView.layer.addSublayer(shapeLayer)
//
//    }
//
//}

