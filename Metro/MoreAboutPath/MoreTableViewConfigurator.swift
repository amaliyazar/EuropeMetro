//
//  MoreTableViewConfigurator.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import Foundation

protocol MoreTableViewConfiguratorProtocol {
    func configure(with viewController: MoreTableView)
    
    func setData(data: [Int])
}

class MoreTableViewConfigurator: MoreTableViewConfiguratorProtocol {
    
    private var data: [Int] = []
    
    func setData(data: [Int]) {
        self.data = data
    }
    
    func configure(with viewController: MoreTableView) {
        let presenter = MoreTableViewPresenter(viewcontroller: viewController, data: data)
        
        viewController.presenter = presenter
    }
}
