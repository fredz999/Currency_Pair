//
//  Pair_Info.swift
//  Currency_Pair
//
//  Created by Jonathan Brown on 01/06/2025.
//

struct Pair_Info{
    var title: String
    var value: Double
    var date: String
    var isIncrement: Bool
    var index : Int
    
    init(title_: String, value_: Double, date_: String, isIncrement_: Bool,index_: Int) {
        self.title = title_
        self.value = value_
        self.date = date_
        self.isIncrement = isIncrement_
        self.index = index_
    }
    
    func copyWithNewVals(newTitle: String, newValue: Double, newDate: String, newIsIncrement: Bool,newIndex_: Int) -> Self {
        return Pair_Info(title_: newTitle
                         , value_: newValue
                         , date_: newDate
                         , isIncrement_: newIsIncrement
                         , index_: newIndex_)
    }
}


//func copyWith_Off_Cursor()->Self{
//    return Beat_Grid_Cell_Struct(cursorOn_: false
//                                 , selectStatus_: self.cell_Select_Status
//                                 , noteOn_: self.noteStatus
//                                 , pre_Note_On_: self.pre_Note_Status
//                                 , prohib_Note_On_: self.prohib_Note_Status
//                                 , xIndex: self.xIndex
//                                 , yIndex: self.yIndex
//                                 , id_: self.id)
//}
