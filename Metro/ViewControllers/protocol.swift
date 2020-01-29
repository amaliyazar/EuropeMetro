//
//  protocol.swift
//  AKSwiftSlideMenu
//
//  Created by Амалия Зарывных on 23.01.2020.
//  Copyright © 2020 Kode. All rights reserved.
//

import Foundation

protocol ScalledObjectView {
    func scale()
    func unScale()
}

protocol MakeHideObject {
    func hide(_ hide:Bool)
}
