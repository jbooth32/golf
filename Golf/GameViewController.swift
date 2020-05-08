//
//  GameViewController.swift
//  Golf
//
//  Created by Jared on 5/2/20.
//  Copyright © 2020 Jared. All rights reserved.
//

import UIKit


class Game{
    var box: [[Int]]
    var players: [String]
    var date = Date()
    init(players:[String]){
        box = [[Int]]()
        self.players = players
    }
    func add(hole:[Int]){
        box.append(hole)
    }
    func printBox() -> String{
        if box.count == 0{
            return ""
        }
        var s1 = "      Hole |"
        var pStrings = [String]()
        var ends = [Int]()
        for i in 0...(players.count-1){
            pStrings.append(String(repeating:" ", count: 10 - players[i].count) + players[i] + " |")
            ends.append(0)
        }
        for i in 0...(box.count - 1){
            if i < 9{
                s1 += " "
            }
            s1 += "\(i+1)|"
            for j in 0...(players.count - 1){
                pStrings[j] += " \(box[i][j+1])|"
                ends[j] += box[i][j+1] - 2
            }
            if i % 9 == 8 && box.count != i+1 && i > 4{
                s1 += "    |"
                for i in 0...(players.count - 1){
                    if ends[i] > 9{
                        pStrings[i] += " +\(ends[i])|"
                    }
                    else if ends[i] > 0{
                        pStrings[i] += " +\(ends[i]) |"}
                    else if ends[i] == 0{
                        pStrings[i] += "  \(ends[i]) |"}
                    else{
                        pStrings[i] += " \(ends[i]) |"
                    }
            }
        }
        }
        s1 += " Total \n"
        for i in 0...(players.count - 1){
            if ends[i] > 0{
                pStrings[i] += "  +\(ends[i])"
            }
            else if ends[i] == 0{
                pStrings[i] += "   \(ends[i])"}
            else{
                pStrings[i] += "  \(ends[i])"
            }
            s1 += pStrings[i] + "\n"
        }
        return s1
    }
}
class Player{
    var name = ""
    var score = 0
    var spot = 0
    var chart = [[Int]]()
    func add(shots:Int, hole:Int){
        if spot == 0{
            spot += 1
            chart[0][0] = 1
            chart[1][0] = 0
        }
        spot += 1
        chart[0][spot] = hole
        chart[1][spot] = shots
        score += shots
    }
    
    
}

class GameViewController: UIViewController {

    var hole = 1
    var prev = 1
    var current = 1
    var choose = true
    var game = Game(players: [])
    
    var scores = [0,0,0,0,0]
    var players = [UITextField]()
    @IBOutlet weak var player1: UITextField!
    @IBOutlet weak var player2: UITextField!
    @IBOutlet weak var player3: UITextField!
    @IBOutlet weak var player4: UITextField!
    @IBOutlet weak var player5: UITextField!
    
    var players_r = [UILabel]()
    @IBOutlet weak var player1_r: UILabel!
    @IBOutlet weak var player2_r: UILabel!
    @IBOutlet weak var player3_r: UILabel!
    @IBOutlet weak var player4_r: UILabel!
    @IBOutlet weak var player5_r: UILabel!
    
    var players_rv = [UIStackView]()
    @IBOutlet weak var player1_rv: UIStackView!
    @IBOutlet weak var player2_rv: UIStackView!
    @IBOutlet weak var player3_rv: UIStackView!
    @IBOutlet weak var player4_rv: UIStackView!
    @IBOutlet weak var player5_rv: UIStackView!
    
    var players_rs = [UILabel]()
    @IBOutlet weak var player1_rs: UILabel!
    @IBOutlet weak var player2_rs: UILabel!
    @IBOutlet weak var player3_rs: UILabel!
    @IBOutlet weak var player5_rs: UILabel!
    @IBOutlet weak var player4_rs: UILabel!
    
    var players_s = [UILabel]()
    @IBOutlet weak var player1_s: UILabel!
    @IBOutlet weak var player2_s: UILabel!
    @IBOutlet weak var player3_s: UILabel!
    @IBOutlet weak var player4_s: UILabel!
    @IBOutlet weak var player5_s: UILabel!
    
    var players_sv = [UIStackView]()
    @IBOutlet weak var player1_sv: UIStackView!
    @IBOutlet weak var player2_sv: UIStackView!
    @IBOutlet weak var player3_sv: UIStackView!
    @IBOutlet weak var player4_sv: UIStackView!
    @IBOutlet weak var player5_sv: UIStackView!
    
    var players_ss = [UILabel]()
    @IBOutlet weak var player1_ss: UILabel!
    @IBOutlet weak var player2_ss: UILabel!
    @IBOutlet weak var player3_ss: UILabel!
    @IBOutlet weak var player4_ss: UILabel!
    @IBOutlet weak var player5_ss: UILabel!
    
    
    
    @IBOutlet weak var exitViewb: UIView!
    @IBOutlet weak var exitView: UIStackView!
    
    @IBAction func exitBtrue(_ sender: Any) {
        performSegue(withIdentifier: "game", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! StatsViewController
        vc.game = game
    }
    @IBAction func exitBfalse(_ sender: Any) {
        exitView.isHidden = true
        exitViewb.isHidden = true
        holePrompt.isHidden = false
    }
    
    @IBOutlet weak var holeCount: UILabel!
    
    @IBOutlet weak var startView: UIStackView!
    
    @IBOutlet weak var holePrompt: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var options: UIStackView!
    
    @IBOutlet weak var scoreboardView: UIStackView!
    
    @IBOutlet weak var resultsView: UIStackView!
    
    
    @IBAction func p1_sub(_ sender: Any) {
        player1_rs.text = String(Int(player1_rs.text!)! - 1)
    }
    @IBAction func p1_plus(_ sender: Any) {
        player1_rs.text = String(Int(player1_rs.text!)! + 1)
    }
    @IBAction func p2_sub(_ sender: Any) {
        player2_rs.text = String(Int(player2_rs.text!)! - 1)
    }
    @IBAction func p2_plus(_ sender: Any) {
        player2_rs.text = String(Int(player2_rs.text!)! + 1)
    }
    @IBAction func p3_sub(_ sender: Any) {
        player3_rs.text = String(Int(player3_rs.text!)! - 1)
    }
    @IBAction func p3_plus(_ sender: Any) {
        player3_rs.text = String(Int(player3_rs.text!)! + 1)
    }
    @IBAction func p4_sub(_ sender: Any) {
        player4_rs.text = String(Int(player4_rs.text!)! - 1)
    }
    @IBAction func p4_plus(_ sender: Any) {
        player4_rs.text = String(Int(player4_rs.text!)! + 1)
    }
    @IBAction func p5_sub(_ sender: Any) {
        player5_rs.text = String(Int(player5_rs.text!)! - 1)
    }
    @IBAction func p5_plus(_ sender: Any) {
        player5_rs.text = String(Int(player5_rs.text!)! + 1)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player1.delegate = self
        player2.delegate = self
        player3.delegate = self
        player4.delegate = self
        player5.delegate = self
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var background: UIImageView!
    @IBAction func hole1(_ sender: Any) {
        if choose && current != 1{
            choose = false
            prev = current
            current = 1
            playHole()
        }
    }
    @IBAction func hole2(_ sender: Any) {
        if choose && current != 2{
            choose = false
            prev = current
            current = 2
            playHole()
        }
    }
    @IBAction func hole3(_ sender: Any) {
        if choose && current != 3{
            choose = false
            prev = current
            current = 3
            playHole()
        }
    }
    @IBAction func hole4(_ sender: Any) {
        if choose && current != 4{
            choose = false
            prev = current
            current = 4
            playHole()
        }
    }
    @IBAction func hole5(_ sender: Any) {
        if choose && current != 5{
            choose = false
            prev = current
            current = 5
            playHole()
        }
    }
    @IBAction func hole6(_ sender: Any) {
        if choose && current != 6{
            choose = false
            prev = current
            current = 6
            playHole()
        }
    }
    @IBAction func hole7(_ sender: Any) {
        if choose && current != 7{
            choose = false
            prev = current
            current = 7
            playHole()
        }
    }
    @IBAction func tiebreak(_ sender: Any) {
    }
    @IBAction func end(_ sender: Any) {
        holePrompt.isHidden = true
        exitView.isHidden = false
        exitViewb.isHidden = false
    }
    @IBAction func quit(_ sender: Any) {
    }
    @IBAction func start(_ sender: Any) {
        setPlayers()
        startView.isHidden = true
        holePrompt.text = "Choose Next Hole"
        togglePrompt(b: false)
        resultsView.isHidden = false
        scoreboardView.isHidden = false
        var lst = [String]()
        for p in players{
            if !p.isEmpty{
                lst.append(p.text!)
            }
        }
        game = Game(players: lst)
    }

    func playHole(){
        background.image = UIImage(named: "\(String(prev) + "-" + String(current))")
        togglePrompt(b:false)
        holePrompt.text = "Enter Scores"
        addButton.isEnabled = true
    }
    
    @IBAction func addScore(_ sender: Any) {
        hole += 1
        holeCount.text = String(hole)
        var lst = [current]
        for i in 0...(players.count - 1){
            scores[i] = scores[i] + Int(players_rs[i].text!)! - 2
            players_ss[i].text = String(scores[i])
            lst.append(Int(players_rs[i].text!)!)
        }
        game.add(hole: lst)
        for i in 0...(players.count - 1){
            players_rs[i].text = "2"
        }
        holePrompt.text = "Choose Next Hole"
        togglePrompt(b: false)
        addButton.isEnabled = false
        choose = true
        
    }
    
    func togglePrompt(b: Bool){
        holePrompt.isHidden = b
    }
    
    func setPlayers(){
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(tapFunction(sender:)))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(tapFunction(sender:)))
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(tapFunction(sender:)))
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(tapFunction(sender:)))
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(tapFunction(sender:)))
        let taps = [tap1,tap2,tap3,tap4,tap5]
        for tap in taps{
            tap.numberOfTapsRequired = 2
        }
        let p = [player1,player2,player3,player4,player5]
        let p_r = [player1_r,player2_r,player3_r,player4_r,player5_r]
        let p_rv = [player1_rv,player2_rv,player3_rv,player4_rv,player5_rv]
        let p_s = [player1_s,player2_s,player3_s,player4_s,player5_s]
        let p_sv = [player1_sv,player2_sv,player3_sv,player4_sv,player5_sv]
        let p_rs = [player1_rs,player2_rs,player3_rs,player4_rs,player5_rs]
        let p_ss = [player1_ss,player2_ss,player3_ss,player4_ss,player5_ss]
        for i in 0...4{
            if !(p[i]!.isEmpty){
                players.append(p[i]!)
                players_r.append(p_r[i]!)
                players_r[i].text = players[i].text
                players_s.append(p_s[i]!)
                players_s[i].text = players[i].text
                players_rs.append(p_rs[i]!)
                players_ss.append(p_ss[i]!)
                players_rv.append(p_rv[i]!)
                p_rv[i]?.isHidden = false
                p_r[i]?.addGestureRecognizer(taps[i])
                players_sv.append(p_sv[i]!)
                p_sv[i]?.isHidden = false
            }
        }
        
    }
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        let lab = sender.view as? UILabel
        lab?.isHighlighted = !(lab?.isHighlighted ?? false)
    }
    
}
 

extension GameViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

extension UITextField {

    var isEmpty: Bool {
        if let text = self.text, !text.isEmpty {
             return false
        }
        return true
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

