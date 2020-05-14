//
//  PlayerStatsViewController.swift
//  Golf
//
//  Created by Jared on 5/9/20.
//  Copyright © 2020 Jared. All rights reserved.
//

import UIKit
import CoreData

class PlayerStatsViewController: UIViewController {

    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let play = plays[0]
        player.text = play.name
        games.text = String(play.games)
        wins.text = String(play.wins)
        Losses.text = String(play.losses)
        avgFin.text = String(round(100 * Double(play.fin)/Double(play.games)) / 100)
        aces.text = String(get_aces())
        holes.text = String(play.holes)
        if play.score > 0{
            score.text = "+" + String(play.score)
        }
        else {score.text = String(play.score)}
        sPh.text = String(round(100 * (((2 * Double(play.holes)) + Double(play.score))/Double(play.holes))) / 100)
        r_9.text = String(play.lows[1])
        r_18.text = String(play.lows[2])
        r_27.text = String(play.lows[3])
        r_36.text = String(play.lows[4])
        r_45.text = String(play.lows[5])
        r_54.text = String(play.lows[6])
        r_63.text = String(play.lows[7])
        let a = [r_9,r_18,r_27,r_36,r_45,r_54,r_63]
        let b = [r9,r18,r27,r36,r45,r54,r63]
        
        for i in 0...6{
            if a[i]!.text == "99"{
                b[i]?.isHidden = true
            }
            else{
                b[i]?.isHidden = false
            }
        }
        // Do any additional setup after loading the view.
    }
    func get_aces() -> Int{
        var i = 0
        let fetchRequest: NSFetchRequest<Hole> = Hole.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            for h in result{
                let a = h.stats![plays[0].name]
                i += a!["ace"]!
            }
            }
        catch{}
        return i
    }
    
    
    var plays = [Player]()
    @IBOutlet weak var player: UILabel!
    @IBOutlet weak var games: UILabel!
    @IBOutlet weak var wins: UILabel!
    @IBOutlet weak var Losses: UILabel!
    @IBOutlet weak var avgFin: UILabel!
    @IBOutlet weak var aces: UILabel!
    @IBOutlet weak var holes: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var sPh: UILabel!
    @IBOutlet weak var r_9: UILabel!
    @IBOutlet weak var r_18: UILabel!
    @IBOutlet weak var r_27: UILabel!
    @IBOutlet weak var r_36: UILabel!
    @IBOutlet weak var r_45: UILabel!
    @IBOutlet weak var r_54: UILabel!
    @IBOutlet weak var r_63: UILabel!
    @IBOutlet weak var r9: UIStackView!
    @IBOutlet weak var r18: UIStackView!
    @IBOutlet weak var r27: UIStackView!
    @IBOutlet weak var r36: UIStackView!
    @IBOutlet weak var r45: UIStackView!
    @IBOutlet weak var r54: UIStackView!
    @IBOutlet weak var r63: UIStackView!
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
