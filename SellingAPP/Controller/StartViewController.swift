//
//  StartViewController.swift
//  SellingAPP
//
//  Created by Bùi Văn Thương on 3/31/18.
//  Copyright © 2018 Bùi Văn Thương. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

   
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    let defaultValue = UserDefaults.standard

   
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.borderWidth = 1.0
        loginButton.layer.cornerRadius = 5.0
        loginButton.layer.borderColor = UIColor.white.cgColor
        registerButton.layer.borderWidth = 1.0
        registerButton.layer.cornerRadius = 5.0
        registerButton.layer.borderColor = UIColor.white.cgColor
        if defaultValue.string(forKey: "emailKH") != nil{
            let profileTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabbarController") as! UITabBarController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = profileTabBarController
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
