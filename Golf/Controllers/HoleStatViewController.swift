//
//  HoleStatViewController.swift
//  Golf
//
//  Created by Jared on 5/15/20.
//  Copyright © 2020 Jared. All rights reserved.
//

import UIKit
import CoreData

class HoleStatViewController: UIViewController {

    var hole =  Hole()
    let names = ["Times":"times", "Avg":"", "Hole in One":"ace", "Bogey":"bogey", "4":"double", "5+":"worse"]
    var players = ["total"]
    var tot = 0
    let mySpacing: CGFloat = 5.0
    
    @IBOutlet weak var stack: UIStackView!
    
    @IBOutlet weak var img: UIImageView!
    
    
    @IBAction func swipeBack(_ sender: UIScreenEdgePanGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        for (k,v) in hole.stats!{
            if k=="total"{continue}
            players.append(k)
            tot += v["times"]!
        }
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = mySpacing
        setStack()
        stack.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: hole.name!)
        // Do any additional setup after loading the view.
    }
    
    func setStack(){
        for p in players{
            let vertSv = UIStackView()
            vertSv.axis = .vertical
            vertSv.alignment = .fill
            vertSv.distribution = .fillEqually
            vertSv.spacing = 5
            let label = UILabel()
            label.text = p
            label.textAlignment = NSTextAlignment.center
            label.font = label.font.withSize(27)
            vertSv.addArrangedSubview(label)
            for stat in ["Times", "Avg", "Hole in One", "Bogey", "4", "5+"]{
                let horiz = UIStackView()
                
                horiz.axis = .horizontal
                horiz.alignment = .fill
                horiz.distribution = .fillEqually
                horiz.spacing = 5
                
                let l1 = UILabel()
                let l2 = UILabel()
                l1.textAlignment = NSTextAlignment.center
                l2.textAlignment = NSTextAlignment.center
                l1.text = stat
                if stat == "Avg"{
                    if p == "total"{
                        l2.text = String(round(100 * Double(hole.stats!["total"]!["score"]!) / Double(tot)) / 100 )}
                    else{
                        l2.text = String(round(100 * Double(hole.stats![p]!["score"]!) / Double(hole.stats![p]!["times"]!)) / 100 )}
                    }
                else{
                    l2.text = String(hole.stats![p]![names[stat]!]!)}
                horiz.addArrangedSubview(l1)
                horiz.addArrangedSubview(l2)
                vertSv.addArrangedSubview(horiz)
                }
            stack.addArrangedSubview(vertSv)
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

}
