//
//  CollectionView.swift
//  Currency_Pair
//
//  Created by Jonathan Brown on 01/06/2025.
//
import Foundation
import SwiftUI
import UIKit

struct CollectionView: UIViewRepresentable {
    
    var coreUI: Core_UI
    
    var intItems: [Int]
    
    var offsetCalc : Offset_Calculator

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // Create the UICollectionView
    func makeUIView(context: Context) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 25, height: 25) // Adjust item size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
    
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = context.coordinator
        collectionView.dataSource = context.coordinator
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "uiCell")
        return collectionView
    }

    func updateUIView(_ uiView: UICollectionView, context: Context) {
        context.coordinator.intItems_C = intItems
        uiView.reloadData()
    }

}

// Coordinator class to handle data and interactions
class Coordinator: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    var parent: CollectionView
    var intItems_C : [Int]
    var offsetCalc : Offset_Calculator
    
    init(_ parent: CollectionView){
    self.parent = parent
    self.intItems_C = parent.intItems
    self.offsetCalc = parent.offsetCalc
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sizeVersion = CGSize(width: scrollView.contentOffset.x, height: scrollView.contentOffset.y)
        offsetCalc.handle_Offset(offset_: sizeVersion)
        //single_X_Position_Calculator.scrollGridOffset = sizeVersion
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return intItems_C.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "uiCell", for: indexPath)
        cell.backgroundColor = .gray
        
        if cell.contentView.subviews.isEmpty {
            let label = UILabel(frame: cell.contentView.bounds)
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 12)
            label.tag = 100
            cell.contentView.addSubview(label)
        }
        
        if let label = cell.contentView.viewWithTag(100) as? UILabel {
            label.text = indexPath.row.description
        }
        
        return cell
    }
    
}

class Offset_Calculator {
    let coreUI : Core_UI
    var internal_West_X : Int = 0
    var responder : P__Grid_West?
    
    init(coreUI: Core_UI) {
        self.coreUI = coreUI
    }
    
    func handle_Offset(offset_:CGSize){
        
        let offset_X_Int : Int = Int(offset_.width/coreUI.cellWidth)
        
        //print("offset_X_Int: \(offset_X_Int.description) ")
        if let lclResponder = responder{
            lclResponder.updateWestX(west_X_: offset_X_Int)
        }
    }
    
}
