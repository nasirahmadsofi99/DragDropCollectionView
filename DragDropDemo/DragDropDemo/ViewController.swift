//
//  ViewController.swift
//  DragDropDemo
//
//  Created by Deftsoft on 30/03/20.
//  Copyright © 2020 Deftsoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var longPressGesture:UILongPressGestureRecognizer!
    var arrayToDisplay = ["Green","Red","Blue","Purple","Maroon","Black","White","DarkGray","Gray"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(gesture:)))
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
   @objc func handleLongGesture(gesture:UILongPressGestureRecognizer) {
        switch (gesture.state) {
        case .began:
            guard let selectedIndexPath  = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition((gesture.location(in: gesture.view)))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
}

extension ViewController :UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayToDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
     return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = arrayToDisplay.remove(at: sourceIndexPath.item)
        arrayToDisplay.insert(item, at: destinationIndexPath.item)
        print(arrayToDisplay)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrapDropCVCell", for: indexPath) as! DrapDropCVCell
        cell.label.text = arrayToDisplay[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width/3 - 6.1
        return CGSize(width: width, height:width)
    }
    
    
}

