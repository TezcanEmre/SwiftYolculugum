//
//  class.swift
//  OOP Train
//
//  Created by Tezcan on 27.06.2023.
//
//enum using for make groups, for more detail(Turkish): https://hasanalidev.medium.com/swift-enum-yapısı-c1d9b22b0d96

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
    
    init(name: String, surname: String, vize: Int, final: Int, type: studentType) { //initializer (baslatici) gives values for varriables in students class
        print("init called") // printing how many times initializer called (its always called creating every object)
        self.name = name // gives values itself every varriable in init (same as other varriables)
        self.surname = surname
        self.vize = vize
        self.final = final
        self.type = type 
        
    }
}
