//
//  Grid.swift
//  Currency_Pair
//
//  Created by Jonathan Brown on 01/06/2025.
//
import Foundation
import SwiftUI

class Grid_State : ObservableObject, P__Grid_West{
    
    let coreUI : Core_UI
    let pairData : Pair_Data
    @Published var lines : [Grid_Line_Store] = []
 
    
    init(coreUI: Core_UI,pair_Data : Pair_Data,intiialWestX:Int) {
        self.coreUI = coreUI
        pairData = pair_Data
        let lineGB = Grid_Line_Store(westX_: intiialWestX, coreUI_: coreUI, lineNum_: 0)
        let lineYen = Grid_Line_Store(westX_: intiialWestX, coreUI_: coreUI, lineNum_: 1)
        lines.append(lineGB)
        lines.append(lineYen)
    }
    
    func updateWestX(west_X_: Int) {
        for line in lines {
            line.updateWestX(west_X_: west_X_, pair_Data_: pairData, lineNumber_: line.lineNum)
        }
    }
    
}

protocol P__Grid_West{
    func updateWestX(west_X_: Int)
}






class Grid_Line_Store : P__WestX_Updatable, Identifiable {
    var id = UUID()
    let coreUI : Core_UI
    let lineNum : Int
    @Published var cells = [Grid_Cell_Store]()
    
    init(westX_:Int,coreUI_:Core_UI,lineNum_:Int){
        coreUI = coreUI_
        lineNum = lineNum_
        for x in 0..<coreUI.unitsPerLine {
            let newCell = Grid_Cell_Store(west_X: westX_, xIndex: x)
            cells.append(newCell)
        }
    }
    
    func updateWestX(west_X_: Int,pair_Data_ : Pair_Data,lineNumber_:Int){
        for cell in cells {
            cell.updateWestX(west_X_: west_X_, pair_Data_: pair_Data_, lineNumber_: lineNum)
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
    
    func updateWestX(west_X_: Int,pair_Data_ : Pair_Data,lineNumber_:Int){
        cell_west_X = west_X_
        
        let newIndex = xIndex+west_X_
        

        let newData = pair_Data_.pair_Array[lineNumber_][newIndex]
        
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
                
                if lclGridCell.isIncrement == .greater{
                    Rectangle().fill(.green).frame(width: coreUI.cellWidth, height: coreUI.cellHeight)
                }
                else if lclGridCell.isIncrement == .lessThan{
                    Rectangle().fill(.red).frame(width: coreUI.cellWidth, height: coreUI.cellHeight)
                }
                else if lclGridCell.isIncrement == .same{
                    Rectangle().fill(.gray).frame(width: coreUI.cellWidth, height: coreUI.cellHeight)
                }
            }
        }
    }
}

protocol P__WestX_Updatable {
    func updateWestX(west_X_: Int,pair_Data_ : Pair_Data,lineNumber_:Int)
}
