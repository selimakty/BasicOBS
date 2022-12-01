//
//  Notlar.swift
//  BasicOBS
//
//  Created by Selim on 30.11.2022.
//

import Foundation

class Notlar {
    var not_id:Int?
    var ders_id:Int?
    var vize:Int?
    var final:Int?
    
    init(){
        
    }
    
    init(not_id:Int,ders_id:Int,vize:Int,final:Int){
        self.ders_id = ders_id
        self.not_id = not_id
        self.vize = vize
        self.final = final
    }
    
//    static func == (lhs: Dersler, rhs: Notlar) -> Bool {
//        return lhs.ders_id == rhs.not_id
//    }
//
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(ders_id?.hashValue)
//    }
}
