//
//  StationConnectionView.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import UIKit

@IBDesignable
class StationConnectionView: UIView {
    
    var coords:CoordsBetweenStationsWithColor
    var fromId:Int = 0
    var toId:Int = 0
    
    init(coords:CoordsBetweenStationsWithColor) {
        self.coords = coords
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: coords.fromCoords)
        path.addLine(to: coords.toCoords)
        path.close()
        path.lineWidth = 9.0
        coords.color.setStroke()
        path.stroke()
    }
    
    override func didMoveToSuperview() {
        self.frame.size = superview!.frame.size
        self.backgroundColor = UIColor.white.withAlphaComponent(0)
    }
    

}

extension StationConnectionView: CanFading {
    
    func fading(_ fide: Bool) {
        switch fide {
        case true:
            UIView.animate(withDuration: 0.6, animations: {
                self.layer.opacity = 0.3
                self.layoutIfNeeded()
            })
        case false:
            UIView.animate(withDuration: 0.6, animations: {
                self.layer.opacity = 1
                self.layoutIfNeeded()
            })
        }
    }
}

extension StationConnectionView: MetroViewStyleAnim {
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
