//
//  ProfileViewController.swift
//  SellingAPP
//
//  Created by Bùi Văn Thương on 4/3/18.
//  Copyright © 2018 Bùi Văn Thương. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    let defaultValue = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logoutButton(_ sender: Any) {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "startViewController")
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginViewController
        self.dismiss(animated: true, completion: nil)
        
    }
    

}
