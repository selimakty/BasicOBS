//
//  DetailViewController.swift
//  BasicOBS
//
//  Created by Selim on 30.11.2022.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var dersAdi: UILabel!
    @IBOutlet weak var vizeNotu: UILabel!
    @IBOutlet weak var finalNotu: UILabel!
    @IBOutlet weak var ortalama: UILabel!
    
    var not:Notlar?
    var ders:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let n = not {
            vizeNotu.text = "Vize:" + String(n.vize!)
            finalNotu.text = "Final:" + String(n.final!)
            
            let ort = (Double(n.vize!) * 0.40) + (Double(n.final!) * 0.60)
            ortalama.text = "Ortalama: " + String(ort)
            
            if ort > 50{
                ortalama.textColor = UIColor.systemGreen
            }
            else{
                ortalama.textColor = UIColor.systemRed
            }
        }
        
        if let ders = ders {
            dersAdi.text = ders
        }
    }

}
