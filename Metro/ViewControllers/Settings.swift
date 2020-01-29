//
//  Settings swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import UIKit

class Settings: BaseViewController {

    //@IBOutlet weak var AppInfoButton: UIButton!
    @IBOutlet var SupportBtn: UIButton!
    @IBOutlet var SettingLbl: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        LanguageLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Language_text", comment: "")
        //AppInfoButton.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "AppInfo", comment: ""), for: .normal)
        SupportBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Support", comment: ""), for: .normal)
        SettingLbl.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Settings", comment: "")
        
        
        // Do any additional setup after loading the view.
    }
        
    @IBAction func AppInfoButton(_ sender: Any) {
        self.performSegue(withIdentifier: "AppInfo", sender: self)
    }

    
    @IBAction func ChangeLanguage(_ sender: Any) {
        self.performSegue(withIdentifier: "LanguageChange", sender: self)
        self.openViewControllerBasedOnIdentifier("LanguageChange")
    }
    
    @IBOutlet var SettingsLabel: UINavigationItem!
    @IBOutlet var LanguageLabel: UILabel!
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
