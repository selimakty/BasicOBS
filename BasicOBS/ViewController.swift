//
//  ViewController.swift
//  BasicOBS
//
//  Created by Selim on 30.11.2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var notList = [Notlar]()
    var dersList = [Dersler]()
    var dersDict:[Int:String] = [Int:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        copyDB()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indeks = sender as? Int
        
        if segue.identifier == "toUpdate" {
            let vc = segue.destination as! UpdateViewController
            vc.Not = notList[indeks!]
        }
        
        if segue.identifier == "toDetail" {
            let vc = segue.destination as! DetailViewController
            vc.not = notList[indeks!]
            vc.ders = dersDict[notList[indeks!].ders_id!]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllList()
    }

    func getAllList(){
        notList = Notlardao().getNotlar()
        dersList = Derslerdao().getDersler()
        
        for i in dersList {
            dersDict[i.ders_id!] = i.ders_adi!
        }
        
        tableView.reloadData()
    }
    
    func copyDB(){
        
        let bundleYolu = Bundle.main.path(forResource: "notlar", ofType: ".sqlite")
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("notlar.sqlite")
        
        if fileManager.fileExists(atPath: kopyalanacakYer.path) {
            print("Veritabanı zaten var.Kopyalamaya gerek yok")
        }else{
            do {
                
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
                
            }catch{
                print(error)
            }
        }
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let not = notList[indexPath.row]
        
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "lessonCell", for: indexPath) as! TableViewCell
        
        //TODO
        cell.dersLabel.text =  "\(dersDict[not.ders_id!]!)"
        cell.vizeLAbel.text =  "vize: \(not.vize!)"
        cell.finalLabel.text = "final: \(not.final!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { _, _, completionHandler in
            Notlardao().deleteNot(not_id: self.notList[indexPath.row].not_id!)
            self.getAllList()
            
            completionHandler(true)
         }
        
        let upgradeAction = UIContextualAction(style: .normal, title: "Güncelle") { _, _, completionHandler in
            self.performSegue(withIdentifier: "toUpdate", sender: indexPath.row)
            completionHandler(true)
         }
        
         let configuration = UISwipeActionsConfiguration(actions: [deleteAction,upgradeAction])
         configuration.performsFirstActionWithFullSwipe = false
         return configuration
    }
}
