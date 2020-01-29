//
//  ViewControllerPressenter.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import Foundation

protocol ViewControllerPressenterProtocol {
    
    var data: [Int] { get set }
    var router: ViewControllerRouterProtocol! { get }
    
}
class ViewControllerPressenter: ViewControllerPressenterProtocol {
    
    weak var view: ViewController!
    var router: ViewControllerRouterProtocol!
    
    var data: [Int] = []
    
    init(viewcontroller: ViewController) {
        view = viewcontroller
    }
    
}
