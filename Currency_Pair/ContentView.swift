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

    let offsetCalc : Offset_Calculator
    @ObservedObject var grid_State : Grid_State
    var dataReadoutStore : DataReadoutStore
   
    
    var grid_y : CGFloat = 450
    var buttonLine_y : CGFloat = 500
    var collectionView_y : CGFloat = 550
    var btnWid : CGFloat = 30
    var btnSpace : CGFloat = 30
    
    init(){
        grid_State = Grid_State(coreUI: coreUI, pair_Data: pairData, intiialWestX: 0)
        
        offsetCalc = Offset_Calculator(coreUI: coreUI)
        
        dataReadoutStore = DataReadoutStore()
        
        grid_State.displayUpdate = dataReadoutStore
        
        offsetCalc.responder = grid_State

        grid_State.updateSelected()
    }
    
    var body: some View {

        ZStack(alignment: .topLeading){
                GeometryReader { geometry in
                Rectangle()
                .fill(Color.clear)
                .frame(width: geometry.size.width, height: geometry.size.height)

                ZStack{
                    DataReadoutView(dataReadoutStore: dataReadoutStore)
                }.offset(x: btnWid*1.5)
                    
                ZStack{
                    ForEach(grid_State.lines){lineStore in
                        ForEach(lineStore.cells){cellStore in
                            Grid_Cell_View(grid_Cell_Store: cellStore, coreUI: coreUI)
                                .offset(x:CGFloat(cellStore.xIndex)*coreUI.unitOffset_X,y:CGFloat(lineStore.lineNum)*coreUI.unitOffset_Y)
                        }
                    }
                }.offset(x: btnWid*4, y: grid_y)
                
                ZStack{
                    Button(action:{
                        if grid_State.currentSelectedCell + 1 < coreUI.unitsPerLine{
                            grid_State.currentSelectedCell += 1
                            grid_State.updateSelected()
                        }
                    }){
                        ZStack{
                            Circle().fill(Color.gray)
                                .frame(width: btnWid)
                            Text(">").foregroundColor(.white)
                        }
                        
                    }.offset(x: btnSpace, y: buttonLine_y)
                    //--------------------------------------------------------
                    Button(action:{
                        if grid_State.currentSelectedCell - 1 >= 0{
                            grid_State.currentSelectedCell -= 1
                            grid_State.updateSelected()
                        }
                    }){
                        ZStack{
                            Circle().fill(Color.gray)
                            .frame(width: btnWid)
                            Text("<").foregroundColor(.white)
                        }
                        
                    }.offset(x: 0, y: buttonLine_y)
                    //--------------------------------------------------------
                    Button(action:{
                        if grid_State.currentSelectedLine + 1 <= 1{
                            grid_State.currentSelectedLine += 1
                            grid_State.updateSelected()
                        }
                    }){
                        ZStack{
                            Circle().fill(Color.gray)
                            .frame(width: btnWid)
                            Text("↓").foregroundColor(.white)
                        }
                        
                    }.offset(x: btnSpace*2, y: buttonLine_y)
                    //--------------------------------------------------------
                    Button(action:{
                        if grid_State.currentSelectedLine - 1 >= 0{
                            grid_State.currentSelectedLine -= 1
                            grid_State.updateSelected()
                        }
                    }){
                        ZStack{
                            Circle().fill(Color.gray)
                            .frame(width: btnWid)
                            Text("↑").foregroundColor(.white)
                        }
                        
                    }.offset(x: btnSpace*3, y: buttonLine_y)
                    //--------------------------------------------------------
                }
                .offset(x: btnWid*4)
                
                
                ZStack{
                    CollectionView(coreUI: coreUI, intItems: pairData.scrollerInts, offsetCalc: offsetCalc)
                    .frame(width:125,height: 25)
                    .offset(x: 0, y: collectionView_y)
                }.offset(x: btnWid*4)
                
            }
        }
        
    }
    
}


//class UI_State{
//    var westX: Int = 0
//}



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
