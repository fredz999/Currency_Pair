//
//  Pair_Data.swift
//  Currency_Pair
//
//  Created by Jonathan Brown on 01/06/2025.
//
import Foundation
import SwiftUI
class Pair_Data : ObservableObject {
    static let shared = Pair_Data()
    var pair_Array : [Pair_Info] = []
    init() {
        let p0 = Pair_Info(title_: "usd/gbp", value_: 0.750, date_: "y'Day", isIncrement_: false,index_: 0)
        pair_Array.append(p0)
        let p1 = Pair_Info(title_: "usd/gbp", value_: 0.746, date_: "y'Day", isIncrement_: false,index_: 1)
        pair_Array.append(p1)
        let p2 = Pair_Info(title_: "usd/gbp", value_: 0.788, date_: "y'Day", isIncrement_: true,index_: 2)
        pair_Array.append(p2)
        let p3 = Pair_Info(title_: "usd/gbp", value_: 0.798, date_: "y'Day", isIncrement_: true,index_: 3)
        pair_Array.append(p3)
        
        let p4 = Pair_Info(title_: "usd/gbp", value_: 0.799, date_: "y'Day", isIncrement_: true,index_: 4)
        pair_Array.append(p4)
        let p5 = Pair_Info(title_: "usd/gbp", value_: 0.765, date_: "y'Day", isIncrement_: false,index_: 5)
        pair_Array.append(p5)
        let p6 = Pair_Info(title_: "usd/gbp", value_: 0.791, date_: "y'Day", isIncrement_: true,index_: 6)
        pair_Array.append(p6)
        let p7 = Pair_Info(title_: "usd/gbp", value_: 0.752, date_: "y'Day", isIncrement_: false,index_: 7)
        pair_Array.append(p7)
        
        let p8 = Pair_Info(title_: "usd/gbp", value_: 0.794, date_: "y'Day", isIncrement_: true,index_: 8)
        pair_Array.append(p8)
        let p9 = Pair_Info(title_: "usd/gbp", value_: 0.714, date_: "y'Day", isIncrement_: false,index_: 9)
        pair_Array.append(p9)
        let p10 = Pair_Info(title_: "usd/gbp", value_: 0.706, date_: "y'Day", isIncrement_: false,index_: 10)
        pair_Array.append(p10)
        let p11 = Pair_Info(title_: "usd/gbp", value_: 0.709, date_: "y'Day", isIncrement_: true,index_: 11)
        pair_Array.append(p11)
        
        let p12 = Pair_Info(title_: "usd/gbp", value_: 0.734, date_: "y'Day", isIncrement_: true,index_: 12)
        pair_Array.append(p12)
        let p13 = Pair_Info(title_: "usd/gbp", value_: 0.712, date_: "y'Day", isIncrement_: false,index_: 13)
        pair_Array.append(p13)
        let p14 = Pair_Info(title_: "usd/gbp", value_: 0.705, date_: "y'Day", isIncrement_: false,index_: 14)
        pair_Array.append(p14)
        let p15 = Pair_Info(title_: "usd/gbp", value_: 0.788, date_: "y'Day", isIncrement_: true,index_: 15)
        pair_Array.append(p15)
        
        let p16 = Pair_Info(title_: "usd/gbp", value_: 0.797, date_: "y'Day", isIncrement_: true,index_: 16)
        pair_Array.append(p16)
        let p17 = Pair_Info(title_: "usd/gbp", value_: 0.786, date_: "y'Day", isIncrement_: false,index_: 17)
        pair_Array.append(p17)
        let p18 = Pair_Info(title_: "usd/gbp", value_: 0.742, date_: "y'Day", isIncrement_: false,index_: 18)
        pair_Array.append(p18)
        let p19 = Pair_Info(title_: "usd/gbp", value_: 0.773, date_: "y'Day", isIncrement_: true,index_: 19)
        pair_Array.append(p19)
        
        let p20 = Pair_Info(title_: "usd/gbp", value_: 0.774, date_: "y'Day", isIncrement_: true,index_: 20)
        pair_Array.append(p20)
        let p21 = Pair_Info(title_: "usd/gbp", value_: 0.752, date_: "y'Day", isIncrement_: true,index_: 21)
        pair_Array.append(p21)
        let p22 = Pair_Info(title_: "usd/gbp", value_: 0.701, date_: "y'Day", isIncrement_: false,index_: 22)
        pair_Array.append(p22)
        let p23 = Pair_Info(title_: "usd/gbp", value_: 0.775, date_: "y'Day", isIncrement_: true,index_: 23)
        pair_Array.append(p23)
        
        let p24 = Pair_Info(title_: "usd/gbp", value_: 0.748, date_: "y'Day", isIncrement_: false,index_: 24)
        pair_Array.append(p24)
        let p25 = Pair_Info(title_: "usd/gbp", value_: 0.721, date_: "y'Day", isIncrement_: false,index_: 25)
        pair_Array.append(p25)
        let p26 = Pair_Info(title_: "usd/gbp", value_: 0.743, date_: "y'Day", isIncrement_: true,index_: 26)
        pair_Array.append(p26)
        let p27 = Pair_Info(title_: "usd/gbp", value_: 0.766, date_: "y'Day", isIncrement_: true,index_: 27)
        pair_Array.append(p27)
        
        let p28 = Pair_Info(title_: "usd/gbp", value_: 0.706, date_: "y'Day", isIncrement_: false,index_: 28)
        pair_Array.append(p28)
        let p29 = Pair_Info(title_: "usd/gbp", value_: 0.724, date_: "y'Day", isIncrement_: true,index_: 29)
        pair_Array.append(p29)
        let p30 = Pair_Info(title_: "usd/gbp", value_: 0.716, date_: "y'Day", isIncrement_: false,index_: 30)
        pair_Array.append(p30)
        let p31 = Pair_Info(title_: "usd/gbp", value_: 0.740, date_: "y'Day", isIncrement_: true,index_: 31)
        pair_Array.append(p31)
    }
}
