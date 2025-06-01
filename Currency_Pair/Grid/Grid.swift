//
//  Grid.swift
//  Currency_Pair
//
//  Created by Jonathan Brown on 01/06/2025.
//
import Foundation
import SwiftUI

class Grid_State : ObservableObject , P__WestX_Updatable{
    
    let coreUI : Core_UI
    @Published var lines : [Grid_Line_Store] = []
    
    init(coreUI: Core_UI,pair_Data : Pair_Data,intiialWestX:Int) {
        self.coreUI = coreUI
        let line0 = Grid_Line_Store(westX_: intiialWestX, coreUI_: coreUI)
        lines.append(line0)
    }
    
    func updateWestX(west_X_: Int,pair_Data_ : Pair_Data) {
        for line in lines {
            line.updateWestX(west_X_: west_X_, pair_Data_: pair_Data_)
        }
    }
    
}







class Grid_Line_Store : P__WestX_Updatable, Identifiable {
    var id = UUID()
    let coreUI : Core_UI
    
    @Published var cells = [Grid_Cell_Store]()
    
    init(westX_:Int,coreUI_:Core_UI){
        coreUI = coreUI_
        for x in 0..<coreUI.unitsPerLine {
            let newCell = Grid_Cell_Store(west_X: westX_, xIndex: x)
            cells.append(newCell)
        }
    }
    
    func updateWestX(west_X_: Int,pair_Data_ : Pair_Data){
        for cell in cells {
            cell.updateWestX(west_X_: west_X_, pair_Data_: pair_Data_)
        }
    }
    
}










class Grid_Cell_Store : ObservableObject , P__WestX_Updatable, Identifiable{
    var id = UUID()
    var cell_west_X : Int //
    var xIndex : Int
    @Published var pair_Info : Pair_Info?
    
    init(west_X: Int, xIndex: Int) {
        self.cell_west_X = west_X
        self.xIndex = xIndex
    }
    
    func updateWestX(west_X_: Int,pair_Data_ : Pair_Data){
        cell_west_X = west_X_
        
        let newData = pair_Data_.pair_Array[xIndex+west_X_]
        
        if let lclPair_Info = pair_Info{
        let replacement = lclPair_Info.copyWithNewVals(newTitle: newData.title
                                         , newValue: newData.value
                                         , newDate: newData.date
                                         , newIsIncrement: newData.isIncrement
                                         , newIndex_: newData.index)
            pair_Info = replacement
        }
        else if pair_Info == nil{
            pair_Info = newData
        }
    }
    
}



struct Grid_Cell_View : View {
    @ObservedObject var grid_Cell_Store : Grid_Cell_Store
    let coreUI : Core_UI
    var body: some View {
        return ZStack {
            if let lclGridCell = grid_Cell_Store.pair_Info{
                Rectangle().fill(lclGridCell.isIncrement ? Color.green : Color.red)
                .frame(width: coreUI.cellWidth, height: coreUI.cellHeight)
            }
        }
    }
}

protocol P__WestX_Updatable {
    func updateWestX(west_X_: Int,pair_Data_ : Pair_Data)
}
