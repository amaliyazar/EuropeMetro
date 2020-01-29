//
//  button.swift
//  Metro
//
//  Created by Амалия Зарывных on 28.01.2020.
//  Copyright © 2020 Mahutin Aleksei. All rights reserved.
//

import Foundation
import UIKit

struct ddat {
    var dataF:String
}
class button: UIViewController {

    static let share = button()
    
    /*required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func ss(_ sender: Any) {
        //ggMetro(res:"data")
        dataFile = "data"
        self.performSegue(withIdentifier: "segue2", sender: self)
    }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    /*var dataF = " "
    public func ggMetro(res: String)
    {
        dataF = res
    }*/
    //print(dataF[0])
}
 
public var dataFile = "dddd"




