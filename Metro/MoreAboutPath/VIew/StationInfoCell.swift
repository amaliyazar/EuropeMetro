//
//  StationInfoCell.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import UIKit

class StationInfoCell: UITableViewCell {
    
    let name = UILabel()
    let time = UILabel()
    var line = ForAboutPathView()
    var isSetup = false
    var type: StationInfo.StationInfoConfig = .normal
    
    override func didMoveToSuperview() {
        switch type {
        case .end,.start,.transfer:
            name.font = UIFont(name: "HelveticaNeue-Bold", size: 10)
        default:
            name.font = UIFont(name: "Helvetica", size: 10)
        }
    }
    
    override func layoutSubviews() {
        time.font = UIFont(name: "Helvetica", size: 10)
        time.sizeToFit()
        time.textAlignment = .right
        time.frame.origin = CGPoint(x:line.frame.origin.x - 10 - time.frame.width,
                                    y: self.frame.height / 2 - time.frame.height / 2)
        
        name.sizeToFit()
        name.frame.origin = CGPoint(x: line.frame.width + line.frame.origin.x + 10,
                                    y: self.frame.height / 2 - name.frame.height / 2)
        
        guard !isSetup else { return }
        for elem in [time,name] {
            self.addSubview(elem)
        }
        isSetup = true
    }
    
    func replaceLine() {
        line.removeFromSuperview()
        line = ForAboutPathView()
        line.frame = CGRect(x: 90 , y: 0, width: 10, height: self.frame.height)
        self.addSubview(line)
        
    }
    
    func setup(data:[[StationInfo]], indexPath: IndexPath) {
        let newdata = data[indexPath.section]
        let current = newdata[indexPath.row]
        type = current.type
        if type == .transfer {
            if indexPath.row == 0 {
                type = .start
            }
            else {
                type = .end
            }
        }
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "HH : mm"
        
        setName(name: current.name)
        setTime(time: dateFormater.string(from: current.time))
        
        replaceLine()
        line.setLine(color: current.color, type: type)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {

        // Configure the view for the selected state
    }
    
    private func setName(name: String) {
        self.name.font = UIFont(name: "Helvetica", size: 10)
        self.name.text = name
        self.name.sizeToFit()
        self.name.frame.origin = CGPoint(x: self.time.frame.origin.x + self.frame.width / 10 + 40,
                                         y: self.frame.height / 2 - self.name.frame.height / 2)
        layoutIfNeeded()
    }
    
    private func setTime(time: String) {
        self.time.font = UIFont(name: "Helvetica", size: 10)
        self.time.text = time
        self.time.sizeToFit()
        self.time.frame.origin = CGPoint(x:self.frame.width / 10,
                                         y: self.frame.height / 2 - self.time.frame.height / 2)
        layoutIfNeeded()
    }
    

}
