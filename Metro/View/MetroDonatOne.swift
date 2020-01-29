//
//  MetroDonatOneDelegate.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import UIKit

protocol MetroDonatOneDelegate {
    func tapOnDonat(sender: MetroDonatOne)
}

@IBDesignable
class MetroDonatOne: UIView,WitchId {
    
    private var isSetup = false
    
    var id: Int = 0
    var scaled = false
    var donatColor: UIColor = .red
    private let stroke: CGFloat = 10
    private let donat = UIView()
    var delegate: MetroDonatOneDelegate?

    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = (traitCollection.userInterfaceStyle == .dark) ? .black : .white
        self.layer.cornerRadius = self.frame.width / 2
        
        donat.frame = CGRect(x: stroke / 2, y: stroke / 2, width: self.frame.width - stroke , height: self.frame.height - stroke)
        donat.layer.cornerRadius = donat.frame.width / 2
        donat.backgroundColor = donatColor
        
        if isSetup { return }
        let TapGeasture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(TapGeasture)
        self.addSubview(donat)
    }
    
    @objc func handleTap() {
        delegate?.tapOnDonat(sender: self)
    }
    
    
    private func updateColor() {
        donat.backgroundColor = donatColor
        donat.layoutIfNeeded()
    }
}

extension MetroDonatOne: ScalledObjectView {
    
    func scale() {
        if self.scaled{
            let scaleValue:CGFloat = 5
            let cX = self.frame.midX
            let cY = self.frame.midY
            UIView.animate(withDuration: 0.6, animations: {
                self.frame.size = CGSize(width: self.frame.size.width + scaleValue,
                                         height: self.frame.size.height + scaleValue)
                self.center = CGPoint(x: cX, y: cY)
                self.layoutIfNeeded()
            })
            self.scaled = false
        }
    }
    
    func unScale() {
        if !self.scaled {
            let cX = self.frame.midX
            let cY = self.frame.midY
            let scaleValue:CGFloat = 5
            UIView.animate(withDuration: 0.6, animations: {
                self.frame.size = CGSize(width: self.frame.size.width - scaleValue,
                                         height: self.frame.size.height - scaleValue)
                self.center = CGPoint(x: cX, y: cY)
                self.layoutIfNeeded()
            })
            self.scaled = true
        }
        
    }

}

extension MetroDonatOne: CanFading {
    
    func fading(_ fide: Bool) {
        if fide {
            UIView.animate(withDuration: 0.6, animations: {
                self.donatColor = self.donatColor.withAlphaComponent(0.3)
                self.updateColor()
            })
        }else{
            UIView.animate(withDuration: 0.6, animations: {
                self.donatColor = self.donatColor.withAlphaComponent(1)
                self.updateColor()
            })
        }
    }
    
}

extension MetroDonatOne: MetroViewStyleAnim {
    
    func setStyle(style: MetroViewStyleAnimType) {
        switch style {
        case .tap:
            self.unScale()
        case .untap:
            self.scale()
        case .route:
            self.fading(false)
            self.scale()
        case .unroute:
            self.fading(true)
            self.unScale()
        case .normal:
            self.fading(false)
            self.scale()
        }
    }
    
    
}
