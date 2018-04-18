//
//  postSellViewController.swift
//  SellingAPP
//
//  Created by Bùi Văn Thương on 4/15/18.
//  Copyright © 2018 Bùi Văn Thương. All rights reserved.
//

import UIKit
import Alamofire
struct khuvucs: Decodable {
    let TEN_KV:String
    let ID_KV: String
}
struct danhmuc:Decodable {
    let ID_DM:String
    let TEN_DM: String
    
}
var selectKV = ""
var selectDM = ""
let userdefaul = UserDefaults.standard

class postSellViewController: UIViewController {

    //url
    let urlKV =  URL(string: "http://localhost:8888/Webservice/api/getKHUVUC.php")
    let urlDM =  URL(string: "http://localhost:8888/Webservice/api/getDANHMUC.php")
    
    
    @IBOutlet weak var khuvucPickerView: UIPickerView!
    
    @IBOutlet weak var danhmucPickerView: UIPickerView!
    var khuvucss =  [khuvucs]()
    var danhmucss = [danhmuc]()
    let idUSER = userdefaul.value(forKey: "idKH")
    let nameUSER = userdefaul.value(forKey: "hotenKH")
    override func viewDidLoad() {
        super.viewDidLoad()
           self.getKV()
        self.getDM()
        self.khuvucPickerView.delegate = self
        self.khuvucPickerView.dataSource = self
        self.danhmucPickerView.delegate = self
        self.danhmucPickerView.dataSource = self
        print(idUSER!)
        print(nameUSER!)
        
    // self.view.addSubview(khuvucPickerView)
        
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
}
extension postSellViewController: UIPickerViewDelegate,UIPickerViewDataSource {
   
    func getKV() {
        URLSession.shared.dataTask (with: urlKV!) { (data, response, error) in
            if error == nil {
                do {
                    self.khuvucss = try JSONDecoder().decode([khuvucs].self, from: data!)
                    }catch let error{
                    print(error)
                }
                DispatchQueue.main.async {
                    self.khuvucPickerView.reloadComponent(0)
                }
            }
        }.resume()
    }
    func getDM() {
        URLSession.shared.dataTask (with: urlDM!) { (dataDM, responseDM, errorDM) in
            if errorDM == nil {
                do {
                    self.danhmucss = try JSONDecoder().decode([danhmuc].self, from: dataDM!)
                }catch let errorDM{
                    print(errorDM)
                }
                DispatchQueue.main.async {
                    self.danhmucPickerView.reloadComponent(0)
                }
            }
            }.resume()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var rowcount:Int = 0
        if pickerView == khuvucPickerView{
           rowcount = khuvucss.count
        }else if pickerView == danhmucPickerView{
             rowcount = danhmucss.count}
    return rowcount
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == khuvucPickerView{
          let  title_KV = khuvucss[row].TEN_KV
            return title_KV
        }else if pickerView == danhmucPickerView{
            let  title_DM  = danhmucss[row].TEN_DM
            return title_DM}
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == khuvucPickerView{
                selectKV = khuvucss[row].ID_KV
            print(selectKV)
    }else if pickerView == danhmucPickerView{
            selectDM = danhmucss[row].ID_DM
            print(selectDM)
       }
        
    }
}


