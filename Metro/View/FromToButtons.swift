//
//  FromToButtons.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import UIKit

enum FromToButtonsStyle {
    case from, to, old
}

protocol FromToButtonsDelegate {
    func pressToButton(sender: UIView)
    func pressFromButton(sender: UIView)
}


@IBDesignable
class FromToButtons: UIView {
    
    
    private let lightBlue = UIColor(displayP3Red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
    private var isSetup = false
    private let from = UIButton(type: .system)
    private let to = UIButton(type: .system)
    private let space:CGFloat = 5
    var currentStyle:FromToButtonsStyle = .to
    
    var delegate:FromToButtonsDelegate?
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        chageStyle(style: .to)
        buttonsInit()
        
        if isSetup { return }
        self.addSubview(to)
        self.addSubview(from)
        to.addTarget(self, action: #selector(pressToButton), for: .touchUpInside)
        to.addTarget(self, action: #selector(startToAnimate), for: [.touchDown,.touchDragInside])
        to.addTarget(self, action: #selector(endToAnimate), for: .touchDragOutside)
        from.addTarget(self, action: #selector(pressFromButton), for: .touchUpInside)
    }
    
    private func buttonsInit() {
        let width = self.frame.width
        let height = width / 6
        
        self.frame.size = CGSize(width: width, height: height)

        
        for elem in [from,to] {
            elem.layer.cornerRadius = height / 2
            elem.layer.borderWidth = height / 24
        }
        
        from.frame = CGRect(x: 0, y: 0, width: width / 2.1, height: height)
        to.frame = CGRect(x: width / 2 - width / 2.1 + self.frame.width / 2, y: from.frame.origin.y, width: width / 2.1, height: height)
        from.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "From", comment: ""), for: .normal)
        to.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "To", comment: ""), for: .normal)
        from.titleLabel?.font = UIFont(name: "Helvetica", size: height / 3)
        to.titleLabel?.font = UIFont(name: "Helvetica", size: height / 3)
    }
    
    func chageStyle(style: FromToButtonsStyle) {
        if style != .old {
            currentStyle = style
        }
        switch currentStyle {
        case .to:
            to.backgroundColor = lightBlue
            to.setTitleColor(.white, for: .normal)
            to.layer.borderColor = lightBlue.cgColor
            
            from.backgroundColor = .white
            from.setTitleColor(.lightGray, for: .normal)
            from.layer.borderColor = UIColor.lightGray.cgColor
        case .from:
            to.backgroundColor = .white
            to.setTitleColor(.lightGray, for: .normal)
            to.layer.borderColor = UIColor.lightGray.cgColor
            
            from.backgroundColor = lightBlue
            from.setTitleColor(.white, for: .normal)
            from.layer.borderColor = lightBlue.cgColor
        case .old:
            fatalError()
        }
    }
    

}

//Animation and press events
extension FromToButtons {
    
    @objc func startToAnimate() {
        if currentStyle == .to {
            to.backgroundColor = .white
            to.setTitleColor(lightBlue, for: .normal)
        }
        
    }
    
    @objc func endToAnimate() {
        switch currentStyle {
        case .from:
            UIView.animate(withDuration: 0.4, animations: {
                self.to.layer.borderColor = UIColor.lightGray.cgColor
            }, completion: { complite in
                self.to.layer.borderColor = UIColor.lightGray.cgColor
            })
        case .to:
            
            UIView.animate(withDuration: 0.4, animations: {
                self.to.backgroundColor = self.lightBlue
                self.to.setTitleColor(.white, for: .normal)
            }, completion: { complite in
                self.to.backgroundColor = self.lightBlue
                self.to.setTitleColor(.white, for: .normal)
            })
        case .old:
            fatalError()
        }
    }
    
    @objc func pressToButton() {
        endToAnimate()
        delegate?.pressToButton(sender: self)
    }
    
    @objc func startFromAnimate() {
        if currentStyle == .from {
            from.backgroundColor = .white
            from.setTitleColor(lightBlue, for: .normal)
        }
        
    }
    
    @objc func endFromAnimate() {
        switch currentStyle {
        case .to:
            UIView.animate(withDuration: 0.4, animations: {
                self.from.layer.borderColor = UIColor.lightGray.cgColor
            }, completion: { complite in
                self.from.layer.borderColor = UIColor.lightGray.cgColor
            })
        case .from:
            
            UIView.animate(withDuration: 0.4, animations: {
                self.from.backgroundColor = self.lightBlue
                self.from.setTitleColor(.white, for: .normal)
            }, completion: { complite in
                self.from.backgroundColor = self.lightBlue
                self.from.setTitleColor(.white, for: .normal)
            })
        case .old:
            fatalError()
        }
    }
    
    @objc func pressFromButton() {
        endFromAnimate()
        delegate?.pressFromButton(sender: self)
    }

    
}
