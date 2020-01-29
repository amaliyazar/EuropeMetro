//
//  Language.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import Foundation
import UIKit

class Language: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        // Do any additional setup after loading the view.
    }
        
    @IBAction func EnglishLanguage(_ sender: Any) {
        LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LanguageChange") as! Language
        let appDlg = UIApplication.shared.delegate as? AppDelegate
        appDlg?.window?.rootViewController = vc
    }
    
    @IBAction func RussianLanguage(_ sender: Any) {
        LocalizationSystem.sharedInstance.setLanguage(languageCode: "ru")
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LanguageChange") as! Language
        let appDlg = UIApplication.shared.delegate as? AppDelegate
        appDlg?.window?.rootViewController = vc
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
