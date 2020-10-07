//
//  ProgressView.swift
//  testi
//
//  Created by Jawad Ali on 31/08/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

@IBDesignable open class SpinnerAnimation: UIView {
    
    private lazy var shape1 = CAShapeLayer()
    private lazy var shape2 = CAShapeLayer()
    private lazy var shape3 = CAShapeLayer()
    private lazy var shape4 = CAShapeLayer()
    
    private  var colors = [#colorLiteral(red: 0.01592958719, green: 0.6688914895, blue: 0.9993582368, alpha: 1),#colorLiteral(red: 0.9990312457, green: 0.3786585331, blue: 0.3868760467, alpha: 1),#colorLiteral(red: 0.8128160834, green: 0.427028507, blue: 0.9658054709, alpha: 1),#colorLiteral(red: 0.5919992328, green: 0.8080403209, blue: 0.1436572075, alpha: 1)] {
        didSet{
            layoutIfNeeded()
        }
    }
    
    private lazy var shapesCollection = [shape1, shape2, shape3, shape4]
    
    convenience init(colors: [UIColor]) {
        self.init(frame: .zero)
        
        if colors.count < 4 {  fatalError("Please provide four colors to progress view")  }
        self.colors = colors
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        controlDidLoad()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        controlDidLoad()
    }
    
    private func controlDidLoad(){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        shapesCollection.forEach { (shape) in
            layer.addSublayer(shape)
            shape.masksToBounds = true
        }
    }
    
    open override func layoutSubviews() {
        
        updatePaths()
        for (index, shape ) in shapesCollection.enumerated() {
            shape.fillColor = colors[index].cgColor
        }
    }
    
    private func updatePaths() {
        let size = bounds.width/2
        
        let p1bounds = CGRect(origin: .zero, size: CGSize(width: size, height: size ))
        
        let p2bounds = CGRect(origin: CGPoint(x:bounds.width/2  , y: 0), size: CGSize(width: size, height: size ))
        
        let p3bounds = CGRect(origin: CGPoint(x:0 , y:bounds.height/2  ), size: CGSize(width: size , height:size))
        
        let p4bounds = CGRect(origin: CGPoint(x:bounds.width/2  , y:bounds.height/2 ), size: CGSize(width: size , height: size ))
        
        let allBounds = [p1bounds, p2bounds, p3bounds, p4bounds]
        
        let bezierPath1 = UIBezierPath(arcCenter: CGPoint(x: size * 0.2, y: size * 0.2), radius: size * 0.1, startAngle: 0, endAngle: 2 * .pi, clockwise: true)

        let bezierPath2 = UIBezierPath(arcCenter: CGPoint(x:p2bounds.width - (size * 0.2), y: size * 0.2), radius: size * 0.1, startAngle: 0, endAngle: 2 * .pi, clockwise: true)

        let bezierPath3 = UIBezierPath(arcCenter: CGPoint(x:(size * 0.2), y: p3bounds.width - (size * 0.2)), radius: size * 0.1, startAngle: 0, endAngle: 2 * .pi, clockwise: true)

        let bezierPath4 = UIBezierPath(arcCenter: CGPoint(x:p4bounds.width - (size * 0.2), y:p4bounds.height - (size * 0.2)), radius: size * 0.1, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        
        let paths = [bezierPath1, bezierPath2, bezierPath3, bezierPath4]
        
        for (index, shape ) in shapesCollection.enumerated() {

            shape.path = paths[index].cgPath
            shape.frame = allBounds[index]
        }
    }
    
    public func stopAnimating() {
        shapesCollection.forEach { (shape) in
            shape.removeAllAnimations()
        }
        layer.removeAllAnimations()
        self.removeFromSuperview()
    }
    
    private func setUpConstraints(with view: UIView) {
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
    
    public func addAndStartAnimation(in view : UIView){
                view.addSubview(self)
                setUpConstraints(with: view)
                self.layoutIfNeeded()
                startAnimating()
    }
    
    public  func startAnimating() {
        
        let size = bounds.width/2
        
        let bezierPath1 = UIBezierPath(arcCenter: CGPoint(x:size - (size * 0.25), y:size - ( size * 0.25)), radius: size * 0.25, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        
        let bezierPath2 = UIBezierPath(arcCenter: CGPoint(x: (size * 0.3), y:size - ( size * 0.3)), radius: size * 0.25, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        
        let bezierPath3 = UIBezierPath(arcCenter: CGPoint(x:size - (size * 0.3), y: (size * 0.3)), radius: size * 0.15, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        
        let bezierPath4 = UIBezierPath(arcCenter: CGPoint(x: (size * 0.4), y: (size * 0.4)), radius: size * 0.4, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        
        let paths = [bezierPath1, bezierPath2, bezierPath3, bezierPath4].map { $0.cgPath }
        
        let duration = 0.75
        
        for (index, shape ) in shapesCollection.enumerated() {
            shape.animateShape(path: paths[index], duration: duration)
        }
        
        self.layer.rotationAnimation(angels: [0,180.degreesToRadians,360.degreesToRadians], duration: duration * 2)
    }
    
    
    
}
