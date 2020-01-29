//
//  ForAboutPathView.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import UIKit

class ForAboutPathView: UIView {

    private var isSetup = false
    private var color: UIColor = .black
    private let line = UIView()
    private let donat = UIView()
    private var type: StationInfo.StationInfoConfig = .end
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
        if isSetup { return }
        self.addSubview(line)
        self.addSubview(donat)
        isSetup = true
    }
    
    private func setup() {
        line.backgroundColor = color
        switch type {
        case .end,.transfer:
            donat.backgroundColor = color
            line.frame = CGRect(x: self.frame.width / 4,
                                y: 0,
                                width: self.frame.width / 2,
                                height: self.frame.height / 2)
        case .start:
            donat.backgroundColor = color
            line.frame = CGRect(x: self.frame.width / 4,
                                y: self.frame.height / 2,
                                width: self.frame.width / 2,
                                height: self.frame.height / 2)
        case .normal:
            donat.backgroundColor = .white
            donat.layer.borderColor = color.cgColor
            donat.layer.borderWidth = self.frame.width / 8
            line.frame = CGRect(x: self.frame.width / 4,
                                y: 0,
                                width: self.frame.width / 2,
                                height: self.frame.height)
        }
        
        donat.frame = CGRect(x: 0, y: (self.frame.height / 2) - (line.frame.width / 2), width: line.frame.width * 2, height: line.frame.width * 2)
        donat.layer.cornerRadius = donat.frame.width / 2
    }
    
    func setLine(color: UIColor,type: StationInfo.StationInfoConfig) {
        self.color = color
        self.type = type
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
