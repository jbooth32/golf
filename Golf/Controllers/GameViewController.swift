//
//  GameViewController.swift
//  Golf
//
//  Created by Jared on 5/2/20.
//  Copyright © 2020 Jared. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class GameSub{
    var box: [[Int]]
    var players: [String]
    var date = Date()
    var holes = 0
    var tiebreak = 0
    var stats = [String:Int]()
    var results = [String:Int]()
    init(players:[String]){
        box = [[Int]]()
        self.players = players
        for p in players{
            stats[p] = 0
            results[p] = 1
        }
    }
    func setResults(){
        for p in players{
            for q in players{
                if p == q{}
                else if stats[p]! > stats[q]!{
                    results[p]! += 1
                }
            }
        }
    }
    
    func add(hole:[Int]){
        box.append(hole)
    }
    
    func back() -> [Int]{
        return box.removeLast()
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
class GameViewController: UIViewController {
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let synthesizer = AVSpeechSynthesizer()
    
    var save = -1
    var hole = 1
    var prev = 1
    var current = 1
    var choose = true
    var game = GameSub(players: [])
    
    @IBAction func holeStats(_ sender: Any) {
        if current == prev{return}
        performSegue(withIdentifier: "hole", sender: self)
    }
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
        let fet: NSFetchRequest<Hole> = Hole.fetchRequest()
        do{
            let result = try context.fetch(fet)
            if result.isEmpty{
                seedHoles()
            }
        }
        catch{}
        game.setResults()
        performSegue(withIdentifier: "game", sender: self)
        let g = Game(context: context)
        g.bonus = Int16(hole - 1 - game.tiebreak)
        g.box = game.box
        g.date = game.date
        g.holes = Int16(hole-1)
        g.id = UUID()
        g.players = game.players
        var playerst = game.players
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            for p in result{
                print(p.name)
                if playerst.contains(p.name){
                    p.addToGame(g)
                    p.games += 1
                    let a = p.lows[(hole - 1 - ((hole - 1) % 9)) / 9]
                    if a > game.stats[p.name]!{
                        p.lows[(hole - 1 - ((hole - 1) % 9)) / 9] = Int16(game.stats[p.name]!)
                    }
                    p.holes += Int16(hole - 1)
                    if game.results[p.name] == 1{
                        p.wins += 1
                    }
                    else if game.results[p.name] == game.players.count{
                        p.losses += 1
                    }
                    p.score += Int16(game.stats[p.name]!)
                    p.fin += Int16(game.results[p.name]!)
                    playerst.removeAll {$0 == p.name}
                    print("a")
                    
                }}
            for p in playerst{
                let play = Player(context: context)
                play.name = p
                play.lows = [99,99,99,99,99,99,99,99,99,99,99,99]
                play.lows[(hole - 1 - ((hole - 1) % 9)) / 9] = Int16(game.stats[play.name]!)
                play.games = 1
                play.holes = Int16(hole - 1)
                play.losses = 0
                if game.results[play.name] == game.players.count{
                    play.losses = 1
                }
                play.wins = 0
                if game.results[play.name] == 1{
                    play.wins = 1
                }
                play.score = Int16(game.stats[play.name]!)
                play.fin = Int16(game.results[play.name]!)
                let fetcher: NSFetchRequest<Hole> = Hole.fetchRequest()
                print("b")
                do{
                    let holes = try context.fetch(fetcher)
                    for h in holes{
                        h.stats?[p] = ["times":0,"score":0,"ace":0,"par":0,"bogey":0,"double":0,"mull":0,"worse":0]
                    }
                }
                catch{}
            }
            }
        catch{}
        appDelegate.saveContext()
        updateHoles()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "game" {
        let vc = segue.destination as! StatsViewController
            vc.game = game}
        if segue.identifier == "hole"{
            let name = "\(prev)-\(current)"
            let vc = segue.destination as! HoleStatViewController
            let fetchRequest: NSFetchRequest<Hole> = Hole.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
            var chosen = Hole()
            do {
                let holes = try context.fetch(fetchRequest)
                chosen = holes[0]
            }
            catch{}
            vc.hole = chosen}
    }
    
    @IBAction func exitBfalse(_ sender: Any) {
        exitView.isHidden = true
        exitViewb.isHidden = true
        if holePrompt.text == "Choose Next Hole"{
            randView.isHidden = false
        }
        holePrompt.isHidden = false
        
    }
    
    @IBOutlet weak var holeCount: UILabel!
    @IBOutlet weak var holeName: UILabel!
    
    @IBOutlet weak var startView: UIStackView!
    
    @IBOutlet weak var holePrompt: UILabel!
    @IBOutlet weak var randView: UIButton!
    
    
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

    @IBAction func backButton(_ sender: Any) {
        if save == -1 {return}
        let alert = UIAlertController(title: "Go Back", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
            
            self.hole -= 1
            self.holeCount.text = String(self.hole)
            let lst = self.game.back()
            for i in 0...(self.players.count - 1){
                self.scores[i] -= lst[i+1] - 2
                if self.scores[i] > 0{
                    self.players_ss[i].text = "+\(String(self.scores[i]))"
                }
                else{
                    self.players_ss[i].text = String(self.scores[i])}
                self.game.stats[self.players[i].text!] = self.scores[i]
            }
            for i in 0...(self.players.count - 1){
                self.players_rs[i].text = "2"
            }
            if !self.choose{
                self.choose = false
                self.current = self.prev
                self.prev = self.save
                self.save = -1
            }
            self.playHole()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "No action"), style: .default, handler: { _ in
            
        }))
        self.present(alert, animated: true, completion: nil)
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
            save = prev
            prev = current
            current = 1
            playHole()
        }
    }
    @IBAction func hole2(_ sender: Any) {
        if choose && current != 2{
            choose = false
            save = prev
            prev = current
            current = 2
            playHole()
        }
    }
    @IBAction func hole3(_ sender: Any) {
        if choose && current != 3{
            choose = false
            save = prev
            prev = current
            current = 3
            playHole()
        }
    }
    @IBAction func hole4(_ sender: Any) {
        if choose && current != 4{
            choose = false
            save = prev
            prev = current
            current = 4
            playHole()
        }
    }
    @IBAction func hole5(_ sender: Any) {
        if choose && current != 5{
            choose = false
            save = prev
            prev = current
            current = 5
            playHole()
        }
    }
    @IBAction func hole6(_ sender: Any) {
        if choose && current != 6{
            choose = false
            save = prev
            prev = current
            current = 6
            playHole()
        }
    }
    @IBAction func hole7(_ sender: Any) {
        if choose && current != 7{
            choose = false
            save = prev
            prev = current
            current = 7
            playHole()
        }
    }
    @IBAction func randomButton(_ sender: Any) {
        choose = false
        save = prev
        prev = current
        var lst = [1,2,3,4,5,6,7]
        lst.removeAll {$0 == current}
        current = lst.randomElement()!
        playHole()
    }
    @IBAction func tiebreak(_ sender: Any) {
        let alert = UIAlertController(title: "Enter Tiebreaker", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
            self.game.tiebreak = self.hole
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "No action"), style: .default, handler: { _ in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func end(_ sender: Any) {
        holePrompt.isHidden = true
        exitView.isHidden = false
        print(exit)
        exitViewb.isHidden = false
        randView.isHidden = true
    }
    @IBAction func quit(_ sender: Any) {
        let alert = UIAlertController(title: "Quit Game?", message: "The current game will not be saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
            self.performSegue(withIdentifier: "quitGame", sender: self)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "No action"), style: .default, handler: { _ in
            
        }))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    @IBAction func start(_ sender: Any) {
        setPlayers()
        startView.isHidden = true
        holePrompt.text = "Choose Next Hole"
        togglePrompt(b: false)
        randView.isHidden = false
        resultsView.isHidden = false
        scoreboardView.isHidden = false
        var lst = [String]()
        for p in players{
            if !p.isEmpty{
                lst.append(p.text!)
            }
        }
        game = GameSub(players: lst)
    }

    func playHole(){
        background.image = UIImage(named: "\(String(prev) + "-" + String(current))")
        togglePrompt(b:false)
        randView.isHidden = true
        speakHole()
        holePrompt.text = "Enter Scores"
        addButton.isEnabled = true
    }
    
    func speakHole(){
        var name = ""
        let h = "\(prev)-\(current)"
        if h == "2-1" || h == "3-1" || h == "4-1" || h == "5-1" || h == "6-1" || h == "7-1"{
            name = "bottom"
        }
        else if h == "1-2" || h == "3-2" || h == "4-2" || h == "5-2" || h == "6-2" || h == "7-2"{
            name = "start"
        }
        else if h == "1-3" || h == "2-3" || h == "4-3" || h == "5-3" || h == "6-3" || h == "7-3"{
            name = "rocky top"
        }
        else if h == "1-4" || h == "2-4" || h == "3-4" || h == "5-4" || h == "6-4" || h == "7-4"{
            name = "top"
        }
        else if h == "1-5" || h == "2-5" || h == "4-5" || h == "6-5" || h == "7-5" || h == "3-5"{
            name = "middle"
        }
        else if h == "1-6" || h == "2-6" || h == "4-6" || h == "5-6" || h == "3-6" || h == "7-6"{
            name = "low"
        }
        else if h == "1-7" || h == "2-7" || h == "4-7" || h == "5-7" || h == "6-7" || h == "3-7"{
            name = "corner"
        }
        if current == save{
            name = "back"
        }
        name = "Hole   \(hole):      \(name)"
        let utterance = AVSpeechUtterance(string: name)
        utterance.voice = getVoice()
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
    
    @IBAction func addScore(_ sender: Any) {
        hole += 1
        holeCount.text = String(hole)
        var lst = [current]
        for i in 0...(players.count - 1){
            scores[i] = scores[i] + Int(players_rs[i].text!)! - 2
            if scores[i] > 0{
                players_ss[i].text = "+\(String(scores[i]))"
            }
            else{
                players_ss[i].text = String(scores[i])}
            game.stats[players[i].text!] = scores[i]
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
        randView.isHidden = false
        
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
        let holeTap = UITapGestureRecognizer(target: self, action: #selector(holeTaps(sender:)))
        holeTap.numberOfTapsRequired = 2
        holeName.addGestureRecognizer(holeTap)
    }
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        let lab = sender.view as? UILabel
        lab?.isHighlighted = !(lab?.isHighlighted ?? false)
        if lab!.isHighlighted{
            let utterance = AVSpeechUtterance(string: "\(lab!.text ?? "") has used their mulligan")
            utterance.voice = getVoice()
            synthesizer.speak(utterance)}
        
    }
    
    @objc func holeTaps(sender:UITapGestureRecognizer) {
        let utterance = AVSpeechUtterance(string: "Watch your fucking language!")
        utterance.volume = 1
        utterance.voice = getVoice()
        synthesizer.speak(utterance)
    }
    func seedHoles(){
        for i in 1...7{
            for j in 1...7{
                if i != j{
                    let h = Hole(context: context)
                    h.name = "\(i)-\(j)"
                    h.start = Int16(i)
                    h.finish = Int16(j)
                    h.stats = ["total":["times":0,"score":0,"ace":0,"par":0,"bogey":0,"double":0,"mull":0,"worse":0]]
                }
            }
        }
        print("seeded")
        appDelegate.saveContext()
    }
    
    func getVoice() -> AVSpeechSynthesisVoice{
        let voices = ["en-AU","en-GB", "en-IE", "en-US", "en-ZA", "en-IN"]
        return AVSpeechSynthesisVoice(language: voices.randomElement())!
    }
    
    func updateHoles(){
        let box = game.box
        if  box.count == 0{
            return
        }
        var hole = ""
        for i in 0...(box.count - 1){
            if i == 0{
               hole = "1-\(box[i][0])"
            }
            else{
               hole = "\(box[i-1][0])-\(box[i][0])"
            }
            let fetchRequest: NSFetchRequest<Hole> = Hole.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", hole)
            do {
                let result = try context.fetch(fetchRequest)
                let h = result.first
                print(hole)
                var tot = h!.stats!["total"]!
                tot["times"]! += 1
                for j in 0...(players.count-1){
                    let s = box[i][j+1]
                    var ps = h!.stats![game.players[j]]!
                    ps["times"]! += 1
                    ps["score"]! += s
                    tot["score"]! += s
                    if s == 1{
                        ps["ace"]! += 1
                        tot["ace"]! += 1
                    }
                    else if s == 2{
                        ps["par"]! += 1
                        tot["par"]! += 1
                    }
                    else if s==3{
                        ps["bogey"]! += 1
                        tot["bogey"]! += 1
                    }
                    else if s==4{
                        ps["double"]! += 1
                        tot["double"]! += 1
                    }
                    else{
                        ps["worse"]! += 1
                        tot["worse"]! += 1
                    }
                h!.stats![game.players[j]]! = ps
                }
                h!.stats!["total"]! = tot
            }
            catch{}
        }
        appDelegate.saveContext()
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

