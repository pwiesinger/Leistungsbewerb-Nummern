//
//  ViewController.swift
//  Bewerbsnummern
//
//  Created by Paul Wiesinger on 29.01.20.
//  Copyright © 2020 Paul Wiesinger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    let insets = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
    
    
    //var numbers = ["ME", "MA", "GRKDT", "1", "2", "3", "4", "5", "6"]
    
    let active = [
        "ME" : UIColor.white,
        "MA" : UIColor.white,
        "GRKDT" : UIColor.white,
        "1" : UIColor.systemRed,
        "2" : UIColor.systemRed,
        "3" : UIColor.systemBlue,
        "4" : UIColor.systemBlue,
        "5" : UIColor.systemYellow,
        "6" : UIColor.systemYellow
    ]
    
    let youth = [
        "1" : UIColor.white,
        "2" : UIColor.systemRed,
        "3" : UIColor.systemRed,
        "4" : UIColor.systemRed,
        "5" : UIColor.systemRed,
        "6" : UIColor.systemYellow,
        "7" : UIColor.systemYellow,
        "8" : UIColor.systemYellow,
        "9" : UIColor.systemYellow
    ]
    
    var numbers = [(key: String, value: UIColor)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.collectionViewLayout = flowLayout
        collectionView.dataSource = self
        collectionView.delegate = self
       
        numbers = active.shuffled()
    }

    @IBAction func reloadNumbers(_ sender: Any) {
        numbers.shuffle()
        collectionView.reloadData()
    }
    
    @IBAction func options(_ sender: Any) {
        let alert = UIAlertController.init(title: "Aus welchen Nummern möchtest du ziehen?", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction.init(title: "Jugend", style: .default, handler: { (action) in
            self.numbers = self.youth.shuffled()
            self.collectionView.reloadData()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Aktiv", style: .default, handler: { (action) in
            self.numbers = self.active.shuffled()
            self.collectionView.reloadData()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Abbrechen", style: .cancel, handler: nil))
        
        if let popoverController = alert.popoverPresentationController {
          popoverController.barButtonItem = sender as? UIBarButtonItem
        }
        
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.label?.text = numbers[indexPath.row].key
        cell.labelView.backgroundColor = numbers[indexPath.row].value
        return cell
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
