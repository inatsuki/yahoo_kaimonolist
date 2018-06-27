//
//  ParamViewController.swift
//  MySearchApp
//
//  Created by systena on 2018/06/27.
//  Copyright © 2018年 Mao Nishi. All rights reserved.
//

import UIKit

class ParamViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var from: UITextField!
    @IBOutlet weak var to: UITextField!
    @IBOutlet weak var sort: UIPickerView!
    var sort_array = ["金額昇順","金額降順","商品名昇順",
                      "商品名降順","スコア昇順","スコア降順", "レビュー数昇順", "レビュー数降順"]
    @IBOutlet weak var condition: UIPickerView!
    var condition_array = ["中古", "新品", "全て"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sort.dataSource      = self
        sort.delegate        = self
        sort.tag             = 1
        condition.dataSource = self
        condition.delegate   = self
        condition.tag        = 2
        // Do any additional setup after loading the view.
        let userDefaults = UserDefaults.standard
        from.text = userDefaults.string(forKey: "from")
        to.text = userDefaults.string(forKey: "to")
        if let sort_select = userDefaults.string(forKey: "sort"){
            sort.selectRow(sort_array.index(of: sort_select)!, inComponent: 0, animated: false)
        }
        if let condition_select = userDefaults.string(forKey: "condition"){
            condition.selectRow(condition_array.index(of: condition_select)!, inComponent: 0, animated: false)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return sort_array[row]
        } else {
            return condition_array[row]
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return sort_array.count
        } else {
            return condition_array.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            sort.selectRow(row, inComponent: 0, animated: false)
        } else {
            condition.selectRow(row, inComponent: 0, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func save(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        if let from = from.text{
            if Int(from) != nil{
                userDefaults.set(from, forKey: "from")
            }
            else{
                userDefaults.set(nil, forKey: "from")
            }
        }
        if let to = to.text{
            if Int(to) != nil{
                userDefaults.set(to, forKey: "to")
            }
            else{
                userDefaults.set(nil, forKey: "to")
            }
        }
        userDefaults.set(sort_array[sort.selectedRow(inComponent: 0)], forKey: "sort")
        userDefaults.set(condition_array[condition.selectedRow(inComponent: 0)], forKey: "condition")
        userDefaults.synchronize()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
