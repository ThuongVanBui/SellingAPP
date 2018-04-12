//
//  LoginViewController.swift
//  SellingAPP
//
//  Created by Bùi Văn Thương on 3/31/18.
//  Copyright © 2018 Bùi Văn Thương. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AudioToolbox


class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var dangnhapButton: UIButton!
    
    
    
    let myUrl =  URL(string: "http://localhost:8888/Webservice/api/Login.php")

    let defaultValue = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        dangnhapButton.layer.borderWidth = 1.0
        dangnhapButton.layer.cornerRadius = 5.0
        dangnhapButton.layer.borderColor = UIColor.white.cgColor
        passwordTextField.isSecureTextEntry = true
        if defaultValue.string(forKey: "emailKH") != nil{
            let profileTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabbarController") as! UITabBarController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = profileTabBarController
            
        }
        
    }

    @IBAction func loginButton(_ sender: Any) {
        let userEmail = emailTextField.text
        let userPassword = passwordTextField.text
        if ((userEmail?.isEmpty)! || (userPassword?.isEmpty)!){
            let alert = UIAlertController(title: "Thông báo", message: "Bạn hãy nhập thông tin đăng nhập!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
        let param: Parameters = [
            "email":userEmail!,
            "pass":userPassword!]
        Alamofire.request(myUrl!, method: .post, parameters: param).responseJSON{ response in
            print(response)
            if let result = response.result.value{
                let jsonData = result as! NSDictionary
                
                    let khachhang = jsonData.value(forKey: "KHACHHANG") as! NSDictionary
                
                    let sdtKH = khachhang.value(forKey: "SDT") as! String
                    let diachiKH = khachhang.value(forKey: "DIACHI") as! String
                    let hinhanhKH = khachhang.value(forKey: "HINHANH") as? String
                    let emailKH = khachhang.value(forKey: "EMAIL") as! String
                    let idKH = khachhang.value(forKey: "ID_KH") as! String
                    let hotenKH = khachhang.value(forKey: "HOTEN") as! String
                
                    self.defaultValue.set(idKH, forKey: "idKH")
                    self.defaultValue.set(hotenKH, forKey: "hotenKH")
                    self.defaultValue.set(emailKH, forKey: "emailKH")
                    self.defaultValue.set(sdtKH, forKey: "sdtKH")
                self.defaultValue.set(diachiKH, forKey: "diachiKH")
                self.defaultValue.set(hinhanhKH, forKey: "hinhanhKH")
                    
                let profileTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabbarController") as! UITabBarController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = profileTabBarController
//                    self.navigationController?.pushViewController(profileViewController, animated: true)
//                    self.dismiss(animated: false, completion: nil)
                
                
            }else{
                let alert = UIAlertController(title: "Thông báo", message: "Sai thông tin đăng nhập! Bạn hãy kiểm tra lại thông tin!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
       
        }}
    

    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
