//
//  class.swift
//  OOP Train
//
//  Created by Tezcan on 27.06.2023.
//

import Foundation
class ogrenciler {
    var name = ""
    var surname = ""
    var vize = 0
    var final = 0
    
    init(name: String, surname: String, vize: Int, final: Int) { //initializer (baslatici) ogrenciler sinifindaki degiskenlere veri atıyor
        print("init called") // komut satirinda kac defa baslayabildigini gormek icin
        self.name = name // class daki name e init deki name verisini atıyor benzer sekilde digerleri de
        self.surname = surname
        self.vize = vize
        self.final = final
        
        
    }
}
