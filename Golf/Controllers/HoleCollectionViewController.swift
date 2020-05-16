//
//  CollectionViewController.swift
//  Golf
//
//  Created by Jared on 5/14/20.
//  Copyright © 2020 Jared. All rights reserved.
//

import UIKit
import CoreData



class HoleCollectionViewController: UICollectionViewController {

    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    var holes = [Hole]()
    var sort = ""
    var avg = false
    var chosen = Hole()
    
    @IBAction func swipeBack(_ sender: UIScreenEdgePanGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.contentInsetAdjustmentBehavior = .always
        let fetcher: NSFetchRequest<Hole> = Hole.fetchRequest()
        let holeSort = NSSortDescriptor(key:"name", ascending:true)
        fetcher.sortDescriptors = [holeSort]
        do{
            holes = try context.fetch(fetcher)
        }
        catch{}
        
        if avg{
            holes.sort {(avgSort(hole: $0)) > (avgSort(hole: $1)) }
        }
        if sort != "name"{
            holes.sort {(otSort(hole: $0, sort:sort)) > (otSort(hole: $1, sort:sort)) }
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return holes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HoleCell", for: indexPath) as! HoleCollectionViewCell
        let hole = holes[indexPath.item]
        let name = hole.name! + "s"
        let pic = UIImage(named:name)
        cell.holeImg.image = pic
        if avg{
            var tot = 0
            for (k,v) in hole.stats!{
                if k != "total"{
                    tot += v["times"]!
                }
            }
            if tot == 0{
                cell.lowLabel.text = "N/A"
            }
            else {
                cell.lowLabel.text = String(round(100 * Double(hole.stats!["total"]!["score"]!) / Double(tot)) / 100 )}
        }
        else if sort == "name"{
                cell.lowLabel.text = hole.name
        }
        else {
            cell.lowLabel.text = String(hole.stats!["total"]![sort]!)
        }
    return cell
    }

    func otSort(hole:Hole, sort:String) -> Int{
        return hole.stats!["total"]![sort]!
    }
    func avgSort(hole:Hole) -> Double{
        var tot = 0
        for (k,v) in hole.stats!{
            if k != "total"{
                tot += v["times"]!
            }
        }
        if tot == 0{
            return 999
        }
        return Double(tot) / Double(hole.stats!["total"]!["score"]!)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chosen = holes[indexPath.row]
        performSegue(withIdentifier: "holeSelect", sender: self )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        guard segue.identifier == "holeSelect" else {return}
        let vc = segue.destination as! HoleStatViewController
        vc.hole = chosen
    }
    
    func getTitle () -> String{
        if avg{return "Average Score"}
        let lookup = ["times":"Times Played", "ace": "Hole in Ones", "bogey":"Bogeys", "double": "Double Bogeys", "name": "Hole"]
        return lookup[sort]!
    }
    
   override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
      // 1
      switch kind {
      // 2
      case UICollectionView.elementKindSectionHeader:
        // 3
        guard
          let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "SectionHeader",
            for: indexPath) as? CollectionHeaderView
          else {
            fatalError("Invalid view type")
        }

        headerView.label.text = getTitle()
        return headerView
      default:
        // 4
        assert(false, "Invalid element type")
      }
    }
}
