//
//  main.swift
//  OOP Train
//
//  Created by Tezcan on 27.06.2023.
//

import Foundation

let ahmet = studens(name: "Ahmet", surname: "Cakir", vize: 85, final: 78, type: .sayisal) //tek satirda hem init cagirildi hem veriler atandi

print(ahmet.name)
print(ahmet.surname)
print(ahmet.vize)
print(ahmet.final)
print(ahmet.type)

let bora = studens(name: "Bora", surname: "Kupcuk", vize: 15, final: 25, type: .sozel)

print(bora.name)
print(bora.surname)
print(bora.vize)
print(bora.final)
print(bora.type)

let ceren = studens(name: "Ceren", surname: "Ozcan", vize: 95, final: 60, type: .esitAgirlik)
print(ceren.name)
print(ceren.surname)
print(ceren.vize)
print(ceren.final)
print(ceren.type)



