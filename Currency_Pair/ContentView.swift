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
    
    let offsetCalc : Offset_Calculator
    @ObservedObject var grid_State : Grid_State
   
    init(){
        grid_State = Grid_State(coreUI: coreUI, pair_Data: pairData, intiialWestX: 0)
        offsetCalc = Offset_Calculator(coreUI: coreUI)
        offsetCalc.responder = grid_State
//        for i in 0..<32{
//            let val = Double.random(in: 0.7...0.8)
//            print("let gb_p\(i.description) = Pair_Info(title_: \"usd/gbp\", value_: \(String(format: "%.3f", val)), date_: \"y'Day\", isIncrement_: .same, index_: \(i))")
//            print("gb.append(gb_p\(i.description))")
//        }
//        
//        for i in 0..<32{
//            let val = Double.random(in: 0.7...0.8)
//            print("let y_p\(i.description) = Pair_Info(title_: \"usd/gbp\", value_: \(String(format: "%.3f", val)), date_: \"y'Day\", isIncrement_: .same, index_: \(i))")
//            print("yen.append(y_p\(i.description))")
//        }

        grid_State.updateWestX(west_X_: 0)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading){
            ForEach(grid_State.lines){lineStore in
                ForEach(lineStore.cells){cellStore in
                    Grid_Cell_View(grid_Cell_Store: cellStore, coreUI: coreUI)
                        .offset(x:CGFloat(cellStore.xIndex)*coreUI.unitOffset_X,y:CGFloat(lineStore.lineNum)*coreUI.unitOffset_Y)
                }
            }
//            Button(action:{
//                if uiState.westX+1 < pairData.pair_Array[0].count{
//                    let newX = uiState.westX+1
//                    grid_State.updateWestX(west_X_: newX)
//                    uiState.westX = newX
//                }
//            }){
//                ZStack{
//                    Circle().fill(Color.blue)
//                    .frame(width: 50)
//                    Text("<").foregroundColor(.white)
//                }
//                
//            }.offset(x: 0, y: 200)
//            Button(action:{
//                if uiState.westX-1 >= 0{
//                    let newX = uiState.westX-1
//                    grid_State.updateWestX(west_X_: newX)
//                    uiState.westX = newX
//                }
//            }){
//                ZStack{
//                    Circle().fill(Color.blue)
//                    .frame(width: 50)
//                    Text(">").foregroundColor(.white)
//                }
//                
//            }.offset(x: 60, y: 200)
            
            
            
            
            CollectionView(coreUI: coreUI, intItems: pairData.scrollerInts, offsetCalc: offsetCalc)
            .frame(width:125,height: 25)
            .offset(x: 0, y: 75)
        }
    }
    
}

//struct WestBtn : View {
//    @State var westX: Int = 0
//    var body: some View {
//        Text("West")
//    }
//}

class UI_State{
    var westX: Int = 0
}
