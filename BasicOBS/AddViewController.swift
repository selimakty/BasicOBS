//
//  AddViewController.swift
//  BasicOBS
//
//  Created by Selim on 30.11.2022.
//

import UIKit

class AddViewController: UIViewController {

    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var vizeTextField: UITextField!
    
    @IBOutlet weak var finalTextField: UITextField!
    
    var dersList = [Dersler]()
    
    var Not = Notlar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dersList = Derslerdao().getDersler()
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func addNote(_ sender: Any) {
        Not.vize = Int(vizeTextField.text!)
        Not.final = Int(finalTextField.text!)
        
        Notlardao().insertNot(not: Not)
        
        navigationController?.popViewController(animated: true)
    }
    
}

extension AddViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        Not.ders_id = dersList[0].ders_id
        
        return dersList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dersList[row].ders_adi!;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Not.ders_id = dersList[row].ders_id
    }
}
