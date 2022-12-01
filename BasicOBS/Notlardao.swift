//
//  Notlardao.swift
//  BasicOBS
//
//  Created by Selim on 30.11.2022.
//

import Foundation

class Notlardao{
    
    var db:FMDatabase?
    
    init(db: FMDatabase? = nil) {
        self.db = db
    }
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("notlar.sqlite")
        
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func getNotlar() -> [Notlar]{
        
        var retval = [Notlar]()
        
        db?.open()
        
        do{
            let q = try db!.executeQuery("Select * from notlar", values: nil)
            
            while q.next(){
                
                let not = Notlar(not_id: Int(q.string(forColumn: "not_id"))!, ders_id: Int(q.string(forColumn: "ders_id"))!, vize: Int(q.string(forColumn: "vize"))!, final: Int(q.string(forColumn: "final"))!)
                
                retval.append(not)
            }
        }
        catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        return retval
    }
    
    func insertNot(not:Notlar){
        db?.open()
        
        do{
            try db?.executeUpdate("Insert into notlar (ders_id,vize,final) values (?,?,?)", values: [not.ders_id!,not.vize!,not.final!])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func updateNot(not:Notlar){
        db?.open()
        
        print(String(not.vize!))
        
        do{
            try db?.executeUpdate("Update notlar set ders_id = ? , vize = ? , final = ? where not_id = ?", values: [not.ders_id!,not.vize!,not.final!,not.not_id!])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func deleteNot(not_id:Int){
        db?.open()
        
        do{
            try db?.executeUpdate("Delete from notlar where not_id = ?", values: [not_id])
        }
        catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
