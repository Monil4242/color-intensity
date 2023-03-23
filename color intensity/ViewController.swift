//
//  ViewController.swift
//  color intensity
//
//  Created by monil sojitra on 16/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    var time = Timer()
    @IBOutlet weak var pg: UIProgressView!
    
    @IBOutlet weak var playOt: UIButton!
    
    @IBOutlet weak var playingGame: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        pg.progress = 0.0
        playOt.layer.cornerRadius = 10
        playOt.layer.masksToBounds = true
        pg.isHidden = true
        playingGame.isHidden = true
    }
    func progress(){
        var a : Float = 0.0
        self.pg.progress = a
        time = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { _ in
            a += 0.05
            self.pg.progress = a
            if self.pg.progress == 1.0{
                self.pg.progress = 0.0
                self.navigate()
                self.time.invalidate()
            }
        })
    }
    
    func navigate(){
        let n = storyboard?.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        navigationController?.pushViewController(n, animated: true)
    }
    
    @IBAction func playGameButtonAction(_ sender: UIButton) {
        progress()
        pg.isHidden = false
        playingGame.isHidden = false
    }
}

