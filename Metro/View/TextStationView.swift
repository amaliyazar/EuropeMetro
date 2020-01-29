//
//  TextStationView.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import UIKit

protocol TextStationViewDelegate {
    func pressTextStation(sender: TextStationView)
}


@IBDesignable
class TextStationView: UIView,WitchId {
    
    var isSetup = false
    var text:String = "достоевсая"
    var delegate:TextStationViewDelegate?
    var style:UIControl.ContentHorizontalAlignment = .left
    var color:UIColor = .black
    var id:Int = 0
    
    private let button = UIButton()
    private let fontSize:CGFloat = 7
    private let fontStyle:String = "GillSans-Bold"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let font = UIFont(name: fontStyle, size: fontSize)!
        
        
        button.setTitle(text, for: .normal)
        if traitCollection.userInterfaceStyle == .dark && color == .black {
            color = .white
        }
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = font
        button.contentHorizontalAlignment = style
        button.frame = self.bounds
        button.sizeToFit()
        button.frame.origin = CGPoint(x: 0, y: 0)
        self.frame.size = button.frame.size
        
        
        if isSetup { return }
        self.addSubview(button)
        isSetup = true
        button.addTarget(self, action: #selector(pressText), for: .touchUpInside)
    }
    
    @objc func pressText() {
        delegate?.pressTextStation(sender: self)
    }

}

extension TextStationView: CanFading {
    func fading(_ fide: Bool) {
        if fide {
            UIView.animate(withDuration: 0.6, animations: {
                self.button.setTitleColor(self.color.withAlphaComponent(0.3), for: .normal)
                self.button.layoutIfNeeded()
            })
            
        }else{
            UIView.animate(withDuration: 0.6, animations: {
                self.button.setTitleColor(self.color.withAlphaComponent(1), for: .normal)
                self.button.layoutIfNeeded()
            })
        }
    }
}

extension TextStationView: MetroViewStyleAnim {
    func setStyle(style: MetroViewStyleAnimType) {
        switch style {
        case .route:
            self.fading(false)
        case .unroute:
            self.fading(true)
        default:
            self.fading(false)
            
        }
    }
    
    
}
