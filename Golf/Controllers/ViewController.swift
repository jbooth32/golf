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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "stats" else {return}
        let vc = segue.destination as! PlayerStatsViewController
        vc.plays = vcP
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
    
}

