//
//  DummyData.swift
//  Alze
//
//  Created by Kevin  Sam Andaria on 13/06/22.
//

import Foundation
import UIKit
import SwiftUI


struct dummyData: Identifiable{
    let id =  UUID()
    let image: String
    let medecineName: String
    let time: String
    let afterBeforeEat: String
    let isCheck: Bool = false
}

struct MedicineList {
//    var arrMedicine: [dummyData] = []
    
    static let medicine = [
        dummyData(image: "tablet", medecineName: "Donepezil", time: "13.00", afterBeforeEat: "After Eat"),
        dummyData(image: "Pill", medecineName: "Rivastigmin", time: "15.00", afterBeforeEat: "After Eat"),
        dummyData(image: "Pill", medecineName: "Galantamin", time: "20.00", afterBeforeEat: "Before Eat")
    ]
}
