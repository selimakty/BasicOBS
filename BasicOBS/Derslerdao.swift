//
//  Derslerdao.swift
//  BasicOBS
//
//  Created by Selim on 30.11.2022.
//

import Foundation

class Derslerdao{
    
    var db:FMDatabase?
    
    init(db: FMDatabase? = nil) {
        self.db = db
    }
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("notlar.sqlite")
        
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func getDersler() -> [Dersler]{
        
        var retval = [Dersler]()
        
        db?.open()
        
        do{
            let q = try db!.executeQuery("Select * from dersler", values: nil)
            
            while q.next(){
                let ders = Dersler(ders_id: Int(q.string(forColumn: "ders_id")!)!, ders_adi: q.string(forColumn: "ders_adi")!)
                retval.append(ders)
            }
        }
        catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        return retval
    }
}
