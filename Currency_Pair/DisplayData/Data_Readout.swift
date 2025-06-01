//
//  Data_Readout.swift
//  Currency_Pair
//
//  Created by Jonathan Brown on 01/06/2025.
//
import SwiftUI
import Foundation


struct DataReadoutView : View {
    @ObservedObject var dataReadoutStore : DataReadoutStore
    
    var body: some View {
        return ZStack{
            Rectangle().fill(Color.gray.opacity(0.2))
                .frame(width: 300,height: 400)
            VStack{
                Text("pair: \(dataReadoutStore.readoutTitle)")
                    .font(.largeTitle).foregroundColor(.gray)
                Text("val: \(dataReadoutStore.value, specifier: "%.2f")")
                    .font(.largeTitle).foregroundColor(.gray)
                Text("date: \(dataReadoutStore.date)")
                    .font(.largeTitle).foregroundColor(.gray)
                Text("up?: \(dataReadoutStore.isIncrement.rawValue)")
                    .font(.largeTitle).foregroundColor(.gray)
                Text("index: \(dataReadoutStore.index)")
                    .font(.largeTitle).foregroundColor(.gray)
            }
        }
        
    }
}
    
    
    
class DataReadoutStore : ObservableObject,P__Display_Update{
    
    @Published var readoutTitle : String = ""
    @Published var value: Double = 0.0
    @Published var date: String = ""
    @Published var isIncrement: E__Increment_Status = .same
    @Published var index : Int = 0
    
    func displayUpdate(incomingData:Pair_Info){
        readoutTitle = incomingData.title
        value = incomingData.value
        date = incomingData.date
        isIncrement = incomingData.isIncrement
        index = incomingData.index
    }
}

protocol P__Display_Update{
    func displayUpdate(incomingData:Pair_Info)
}

