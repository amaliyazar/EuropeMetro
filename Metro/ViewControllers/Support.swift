//
//  Support.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import UIKit
import MessageUI

class Support: UIViewController, MFMailComposeViewControllerDelegate {

    @IBAction func mailButtonTapped(_ sender: Any) {
        guard MFMailComposeViewController.canSendMail() else {
                //Show alert informing the user
                return
            }
            
            let composer = MFMailComposeViewController()
            composer.mailComposeDelegate = self
            composer.setToRecipients(["amaliyaozar@gmail.com"])
            composer.setSubject("EuroMetro")
                     //MFMailComposeViewControllerDelegate
            present(composer, animated: true, completion: nil)
                
        }
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
         
             controller.dismiss(animated: true, completion: nil)
         
    }
    
}

