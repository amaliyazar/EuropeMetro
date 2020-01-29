//
//  TransferCell.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import UIKit

class TransferCell: UITableViewHeaderFooterView {
    
    let name = UILabel()
    let time = UILabel()
    let imgView = UIImageView()
    let mainView = UIView()
    var isSetup = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

        // Configure the view for the selected st
    
    func setupTransfer(data: [[StationInfo]], section: Int) {
        setName(name:LocalizationSystem.sharedInstance.localizedStringForKey(key: "transit", comment: ""))
        let newData = data[section]
        let newData2 = data[section - 1]
        let timeEnd = newData.first!.time.timeIntervalSince1970
        let timeStart = newData2.last!.time.timeIntervalSince1970
        let finalTime = Int((timeEnd - timeStart) / 60)
        setTime(time: "\(finalTime) min")
    }
    
    func setupFullPath(data: [[StationInfo]]) {
        setName(name: LocalizationSystem.sharedInstance.localizedStringForKey(key: "time_path", comment: ""))
        let timeEnd = data.last!.last!.time.timeIntervalSince1970
        let timeStart = data.first!.first!.time.timeIntervalSince1970
        let finalTime = Int((timeEnd - timeStart) / 60)
        imgView.isHidden = true
        setTime(time: "\(finalTime) min")
    }
    
    
    
    override func didMoveToSuperview() {
        contentView.backgroundColor = (traitCollection.userInterfaceStyle == .dark) ? .black : .white
        time.font = UIFont(name: "Helvetica", size: 12)
        time.sizeToFit()
        time.frame.origin = CGPoint(x:self.frame.width / 2 - name.frame.width / 2 + name.frame.height + 3,
                                    y: self.frame.height / 4 - time.frame.height / 2 + self.frame.height / 2)
        
        name.font = UIFont(name: "Helvetica", size: 12)
        name.sizeToFit()
        name.frame.origin = CGPoint(x: self.frame.width / 2 - name.frame.width / 2,
                            y: self.frame.height / 4 - name.frame.height / 2)
        
        time.backgroundColor = (traitCollection.userInterfaceStyle == .dark) ? .black : .white
        name.backgroundColor = (traitCollection.userInterfaceStyle == .dark) ? .black : .white
        
        imgView.image = UIImage(named: "run")
        imgView.frame = CGRect(x: self.frame.width / 2 - name.frame.width / 2,
                               y: self.frame.height / 4 - time.frame.height / 2 + self.frame.height / 2,
                               width: name.frame.height,
                               height: name.frame.height)
        if isSetup { return }
        self.addSubview(mainView)
        self.addSubview(time)
        self.addSubview(name)
        self.addSubview(imgView)
        
        isSetup = true
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
        self.time.frame.origin = CGPoint(x:self.frame.width / 10, y: self.frame.height / 2 - self.time.frame.height / 2)
        layoutIfNeeded()
    }


}
