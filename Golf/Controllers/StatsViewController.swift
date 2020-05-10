//
//  StatsViewController.swift
//  Golf
//
//  Created by Jared on 5/2/20.
//  Copyright © 2020 Jared. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.text = game.printBox()
        
        
    }
    @IBOutlet weak var gameView: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var game = GameSub(players: [" "])
    

}
