//
//  MultiStationView.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import UIKit



enum StationCountForMulti: Int {
    case two = 2, three = 3
}
@IBDesignable
class MultiStationView: UIView {
    
    var id:[Int] = []
    private var isSetup = false
    var stationCount: StationCountForMulti = .three
    var size:CGFloat = 20
    
    override func layoutSubviews() {
        
        
        super.layoutSubviews()
        
        if isSetup { return }
        
        self.backgroundColor = backgroundColor?.withAlphaComponent(0)
        switch stationCount {
        case .two:
            let view1Size = size + 4
            self.frame.size = CGSize(width: view1Size * 2, height: view1Size)
            self.layer.cornerRadius = self.frame.height / 2
            self.layer.borderColor = UIColor.gray.cgColor
            self.layer.borderWidth = 2
            self.backgroundColor = (traitCollection.userInterfaceStyle == .dark) ? .black : .white
        case .three:
            self.backgroundColor = .white
            let view1Size = size + 4
            self.frame.size = CGSize(width: view1Size * 2, height: view1Size * 2)
            self.layer.cornerRadius = self.frame.height / 2
            self.layer.borderColor = UIColor.gray.cgColor
            self.layer.borderWidth = 2
            self.backgroundColor = (traitCollection.userInterfaceStyle == .dark) ? .black : .white
        }
        
    }
}
