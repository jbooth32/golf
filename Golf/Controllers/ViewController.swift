//
//  ViewController.swift
//  Golf
//
//  Created by Jared on 5/2/20.
//  Copyright © 2020 Jared. All rights reserved.
//


/*
 mulligan indicator/ trac mulligan
 core data
    player
    game
    hole

 */
import UIKit
import CoreData


class ViewController: UIViewController {
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var vcP = [Player]()
    var sort = ""
    var avg = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stats" {
            let vc = segue.destination as! PlayerStatsViewController
            vc.plays = vcP}
        else if segue.identifier == "holeStats"{
            let vc = segue.destination as! HoleCollectionViewController
            vc.sort = sort
            vc.avg = avg
            
        }
    }

    @IBAction func stats(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Player", message: "", preferredStyle: .alert)
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        do{
            let result = try context.fetch(fetchRequest)
            for player in result{
                alert.addAction(UIAlertAction(title: NSLocalizedString(player.name, comment:""), style: .default, handler: { _ in
                    self.vcP = [player]
                    self.performSegue(withIdentifier: "stats", sender: self)
                }))
            }
        }
        catch{}
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func holes(_ sender: Any) {
        let alert = UIAlertController(title: "Sort By", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Order", comment:""), style: .default, handler: { _ in
                    self.sort = "name"
                    self.performSegue(withIdentifier: "holeStats", sender: self)
                }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Avg Score", comment:""), style: .default, handler: { _ in
            self.avg = true
            self.sort = "name"
            self.performSegue(withIdentifier: "holeStats", sender: self)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Times Played", comment:""), style: .default, handler: { _ in
            self.sort = "times"
            self.performSegue(withIdentifier: "holeStats", sender: self)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Hole-in-One", comment:""), style: .default, handler: { _ in
            self.sort = "ace"
            self.performSegue(withIdentifier: "holeStats", sender: self)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Bogey", comment:""), style: .default, handler: { _ in
            self.sort = "bogey"
            self.performSegue(withIdentifier: "holeStats", sender: self)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Double Bogey", comment:""), style: .default, handler: { _ in
            self.sort = "double"
            self.performSegue(withIdentifier: "holeStats", sender: self)
        }))
    
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in }))
        self.present(alert, animated: true, completion: nil)
    }
}

