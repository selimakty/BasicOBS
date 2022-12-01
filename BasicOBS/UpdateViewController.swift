//
//  UpdateViewController.swift
//  BasicOBS
//
//  Created by Selim on 30.11.2022.
//

import UIKit

class UpdateViewController: UIViewController {

    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var vizeTextField: UITextField!
    @IBOutlet weak var finalTextField: UITextField!
    
    var dersList = [Dersler]()
    var Not:Notlar?
    var yeniNot:Notlar = Notlar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
        
        dersList = Derslerdao().getDersler()
        
        if let n = Not {
            vizeTextField.text = String(n.vize!)
            finalTextField.text = String(n.final!)
            yeniNot.ders_id = n.ders_id!
            yeniNot.not_id = n.not_id!
            pickerView.selectRow(n.ders_id!-1, inComponent: 0, animated: false)
        }
    }

    @IBAction func update(_ sender: Any) {
        yeniNot.vize = Int(vizeTextField.text!)
        yeniNot.final = Int(finalTextField.text!)
        
        print(String(yeniNot.vize!))
        
        Notlardao().updateNot(not: yeniNot)
        
        navigationController?.popViewController(animated: true)
    }
}

extension UpdateViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dersList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dersList[row].ders_adi!;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        yeniNot.ders_id = dersList[row].ders_id
    }
}
