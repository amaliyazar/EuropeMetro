//
//  ViewControllerConfigurator.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import Foundation

protocol ViewControllerConfiguratorProtocol {
    func configure(with viewController: ViewController)
}

class ViewControllerConfigurator: ViewControllerConfiguratorProtocol {
    
    func configure(with viewController: ViewController) {
        let presenter = ViewControllerPressenter(viewcontroller: viewController)
        let router = ViewControllerRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.router = router
    }
}
