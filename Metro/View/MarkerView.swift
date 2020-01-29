//
//  MarkerView.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//
import UIKit

enum MarkerViewWord: String {
    case a = "A"
    case b = "B"
}

@IBDesignable
class MarkerView: UIView {

    private var isSetup = false
    
    private var circle = UIView()
    private var whiteCircle = UIView()
    private var angle = TriangleView()
    
    var color:UIColor = .red
    private var text = UILabel()
    var word: MarkerViewWord = .a
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isSetup {
            [angle,circle,text].forEach{ self.addSubview($0) }
        }
        
        constraintsInit()
        setViews()
        setText()
        self.clipsToBounds = true
    }
    
    override func didMoveToSuperview() {
        
    }
    
    func setText() {
        text.textAlignment = .center
        text.text = word.rawValue
        text.font = UIFont(name: "HelveticaNeue-Light" , size: round(self.frame.width) * 0.6)
        text.textColor = .white
    }

    func setViews() {
        angle.color = self.color
        angle.layoutIfNeeded()
        circle.backgroundColor = self.color
        circle.layer.cornerRadius = (self.frame.height - self.frame.height / 6) / 2
        angle.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi)
    }
    
    func constraintsInit() {
        [circle,angle,text].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            angle.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            angle.widthAnchor.constraint(equalTo: angle.heightAnchor),
            angle.topAnchor.constraint(equalTo: self.centerYAnchor, constant: self.frame.height / 6),
            angle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            circle.topAnchor.constraint(equalTo: self.topAnchor),
            circle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            circle.widthAnchor.constraint(equalTo: circle.heightAnchor),
            circle.bottomAnchor.constraint(equalTo: angle.bottomAnchor, constant: -(self.frame.height / 6)),
            text.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            text.leadingAnchor.constraint(equalTo: circle.leadingAnchor, constant: 5),
            text.bottomAnchor.constraint(equalTo: circle.bottomAnchor, constant: -10),
            text.trailingAnchor.constraint(equalTo: circle.trailingAnchor, constant: -5)
        ])
    }

}

