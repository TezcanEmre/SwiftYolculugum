//
//  class.swift
//  OOP Train
//
//  Created by Tezcan on 27.06.2023.
//
//enum gruplandırma için kullanılıyor detaylı bilgi https://hasanalidev.medium.com/swift-enum-yapısı-c1d9b22b0d96

import Foundation
enum studentType {
    case sayisal
    case sozel
    case esitAgirlik
}
class studens {
    var name : String
    var surname : String
    var vize : Int
    var final : Int
    var type: studentType
    
    init(name: String, surname: String, vize: Int, final: Int, type: studentType) { //initializer (baslatici) ogrenciler sinifindaki degiskenlere veri atıyor
        print("init called") // komut satirinda kac defa baslayabildigini gormek icin
        self.name = name // class daki name e init deki name verisini atıyor benzer sekilde digerleri de
        self.surname = surname
        self.vize = vize
        self.final = final
        self.type = type 
        
    }
}
