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
 
    var currentSelectedLine : Int = 0
    var currentSelectedCell : Int = 0
    var currentWestX : Int = 0
    
    var displayUpdate : P__Display_Update?
    var currentlySelectedCellStore : Grid_Cell_Store?
    
    init(coreUI: Core_UI,pair_Data : Pair_Data,intiialWestX:Int) {
        self.coreUI = coreUI
        pairData = pair_Data
        let lineGB = Grid_Line_Store(coreUI_: coreUI, lineNum_: 0)
        let lineYen = Grid_Line_Store(coreUI_: coreUI, lineNum_: 1)
        lines.append(lineGB)
        lines.append(lineYen)
        updateSelected()
        for line in lines {
            line.updateWestX(west_X_: currentWestX, pair_Data_: pairData, lineNumber_: line.lineNum)
        }
    }
    
    func updateWestX(west_X_: Int) {
        if currentWestX != west_X_{
            currentWestX = west_X_
            for line in lines {
                line.updateWestX(west_X_: west_X_, pair_Data_: pairData, lineNumber_: line.lineNum)
            }
            updateSelected()
        }
    }

    func updateSelected(){
        if let lclCurrentSlected = currentlySelectedCellStore{
            if lclCurrentSlected != lines[currentSelectedLine].cells[currentSelectedCell]{
                lclCurrentSlected.isSelected = false
                lines[currentSelectedLine].cells[currentSelectedCell].isSelected = true
                currentlySelectedCellStore = lines[currentSelectedLine].cells[currentSelectedCell]
            }
        }
        else if currentlySelectedCellStore == nil{
            lines[currentSelectedLine].cells[currentSelectedCell].isSelected = true
            currentlySelectedCellStore = lines[currentSelectedLine].cells[currentSelectedCell]
        }
        if let lclSelected = currentlySelectedCellStore {
            if let lclPairInfo = lclSelected.pair_Info {
                if let lclDisplayUpdate = displayUpdate{
                    lclDisplayUpdate.displayUpdate(incomingData: lclPairInfo)
                }
            }
        }
    }
    
}

class Grid_Line_Store : P__WestX_Lines, Identifiable {
    var id = UUID()
    let coreUI : Core_UI
    let lineNum : Int
    @Published var cells = [Grid_Cell_Store]()
    
    init(coreUI_:Core_UI,lineNum_:Int){
        coreUI = coreUI_
        lineNum = lineNum_
        for x in 0..<coreUI.unitsPerLine {
            let newCell = Grid_Cell_Store(xIndex: x)
            cells.append(newCell)
        }
    }
    
    func updateWestX(west_X_: Int,pair_Data_ : Pair_Data,lineNumber_:Int){
        for cell in cells {
            cell.updateWestX(west_X_: west_X_, pair_Data_: pair_Data_, lineNumber_: lineNum)
        }
    }
    
}

class Grid_Cell_Store : ObservableObject , P__WestX_Lines, Identifiable,Equatable{
    var id = UUID()
    static func == (lhs: Grid_Cell_Store, rhs: Grid_Cell_Store) -> Bool {
        return lhs.id == rhs.id
    }
    @Published var isSelected : Bool = false
    var xIndex : Int
    @Published var pair_Info : Pair_Info?
    
    init(xIndex: Int) {
        self.xIndex = xIndex
    }
    
    func selectionUpdate(selectionUpdate:Bool){
        if selectionUpdate == true{
            isSelected = true
        }
        else if selectionUpdate == false{
            isSelected = false
        }
    }
    
    func updateWestX(west_X_: Int,pair_Data_ : Pair_Data,lineNumber_:Int){
        //cell_west_X = west_X_
        
        let newIndex = xIndex+west_X_
        
        if newIndex < pair_Data_.pair_Array[0].count{

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
    
}



struct Grid_Cell_View : View {
    @ObservedObject var grid_Cell_Store : Grid_Cell_Store
    let coreUI : Core_UI
    var body: some View {
        return ZStack(alignment: .topLeading) {
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
            if grid_Cell_Store.isSelected{
                Rectangle().fill(coreUI.limeGreen).frame(width: coreUI.cellWidth/2, height: coreUI.cellHeight/2)
            }
        }
    }
}

protocol P__WestX_Lines {
    func updateWestX(west_X_: Int,pair_Data_ : Pair_Data,lineNumber_:Int)
}

protocol P__Grid_West{
    func updateWestX(west_X_: Int)
}
