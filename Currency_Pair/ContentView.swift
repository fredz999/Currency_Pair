//
//  ContentView.swift
//  Currency_Pair
//
//  Created by Jonathan Brown on 01/06/2025.
//
import Foundation
import SwiftUI

struct ContentView: View {
    let pairData = Pair_Data.shared
    let coreUI = Core_UI.Shared
    let uiState = UI_State()
    @ObservedObject var grid_State : Grid_State
   
    
    init(){
        grid_State = Grid_State(coreUI: coreUI, pair_Data: pairData, intiialWestX: 0)
        for i in 0..<32{
            let val = Double.random(in: 0.7...0.8)
            print("let p\(i.description) = Pair_Info(title_: \"usd/gbp\", value_: \(String(format: "%.3f", val)), date_: \"y'Day\", isIncrement_: false,index_: \(i))")
            print("pair_Array.append(p\(i.description))")
        }
        grid_State.updateWestX(west_X_: 0, pair_Data_: pairData)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading){
            ForEach(grid_State.lines){lineStore in
                ForEach(lineStore.cells){cellStore in
                    Grid_Cell_View(grid_Cell_Store: cellStore, coreUI: coreUI)
                    .offset(x:CGFloat(cellStore.xIndex)*coreUI.unitOffset_X)
                }
            }
            Button(action:{
                if uiState.westX+1 < pairData.pair_Array.count{
                    let newX = uiState.westX+1
                    grid_State.updateWestX(west_X_: newX, pair_Data_: pairData)
                    uiState.westX = newX
                }
            }){
                ZStack{
                    Circle().fill(Color.blue)
                    .frame(width: 50)
                    Text("<").foregroundColor(.white)
                }
                
            }.offset(x: 0, y: 200)
            Button(action:{
                if uiState.westX-1 >= 0{
                    let newX = uiState.westX-1
                    grid_State.updateWestX(west_X_: newX, pair_Data_: pairData)
                    uiState.westX = newX
                }
            }){
                ZStack{
                    Circle().fill(Color.blue)
                    .frame(width: 50)
                    Text(">").foregroundColor(.white)
                }
                
            }.offset(x: 60, y: 200)
        }
    }
    
}

struct WestBtn : View {
    @State var westX: Int = 0
    var body: some View {
        Text("West")
    }
}

class UI_State{
    var westX: Int = 0
}
