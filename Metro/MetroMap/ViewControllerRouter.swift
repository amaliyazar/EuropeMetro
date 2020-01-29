//
//  ViewControllerRouter.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import UIKit

protocol ViewControllerRouterProtocol {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

class ViewControllerRouter: ViewControllerRouterProtocol {
    
    weak var viewController: ViewController!
    
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // show more table view and send data
        if let vc = segue.destination as? MoreTableView, segue.identifier == "MoreTableView"{
            vc.configurator.setData(data: viewController.presenter.data)
        }
    }
}
