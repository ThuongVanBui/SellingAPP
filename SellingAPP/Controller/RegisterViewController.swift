//
//  RegisterViewController.swift
//  SellingAPP
//
//  Created by Bùi Văn Thương on 4/1/18.
//  Copyright © 2018 Bùi Văn Thương. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet weak var hotenTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var matkhauTextField: UITextField!
    @IBOutlet weak var nhaplaimatkhauTextField: UITextField!
    @IBOutlet weak var sdtTextField: UITextField!
    @IBOutlet weak var diachiTextField: UITextField!
    
    @IBOutlet weak var registerButtonOption: UIButton!
    
    
    let url_DangKy = "http://localhost:8888/Webservice/api/Register.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matkhauTextField.isSecureTextEntry = true
        nhaplaimatkhauTextField.isSecureTextEntry = true
        registerButtonOption.layer.borderWidth = 1.0
        registerButtonOption.layer.cornerRadius = 5.0
        registerButtonOption.layer.borderColor = UIColor.white.cgColor
        // Do any additional setup after loading the view.
    }

    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func dangkyButton(_ sender: Any) {
        let matkhau = matkhauTextField.text?.trimmingCharacters(in: .whitespaces)
        let nhaplaimatkhau = nhaplaimatkhauTextField.text?.trimmingCharacters(in: .whitespaces)
        let param: Parameters = [
            "HOTEN":hotenTextField.text!,
            "EMAIL":emailTextField.text!,
            "PASSWORD":nhaplaimatkhauTextField.text!,
            "SDT":sdtTextField.text!,
            "DIACHI":diachiTextField.text!
        ]
        if (!(hotenTextField.text?.isEmpty)! || !(emailTextField.text?.isEmpty)! || !(matkhauTextField.text?.isEmpty)! || !(nhaplaimatkhauTextField.text?.isEmpty)! || !(sdtTextField.text?.isEmpty)! || !(diachiTextField.text?.isEmpty)!){
            if((matkhau!).elementsEqual(nhaplaimatkhau!) == false)
            {
                let alert = UIAlertController(title: "Thông báo", message: "Bạn vui lòng kiểm tra lại mật khẩu! Mật khẩu không đúng!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                }else{
                
                Alamofire.request(url_DangKy, method: .post, parameters: param).responseJSON{response in
                    print(response)
                    if let result = response.result.value{
                        let jsonDATA = result as! NSDictionary
                        
                        let temp = jsonDATA.value(forKey: "message") as! String?
                        if (temp == "USER_EXISTS"){
                            let alert = UIAlertController(title: "Thông báo", message: "Người dùng đã tồn tại!", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }else if (temp == "SUCCESS"){
                            let alert = UIAlertController(title: "Thông báo", message: "Tạo tài khoản thành công!", preferredStyle: UIAlertControllerStyle.alert)
                            self.present(alert, animated: true, completion: nil)
                            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "startViewController")
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.window?.rootViewController = loginViewController
                            self.dismiss(animated: true, completion: nil)
                            
                        }else{
                            let alert = UIAlertController(title: "Thông báo", message: "Đã xảy ra lỗi trong quá trình tạo tài khoản!", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    }
                }
                
            }
        }else{
            let alert = UIAlertController(title: "Thông báo", message: "Bạn vui lòng điền đầy đủ thông tin!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            }
        
        
    }
    

    
}
