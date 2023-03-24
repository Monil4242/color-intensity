import UIKit
class ViewController3: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    var colourhelper : [String : UIColor] = ["red" : UIColor.red,"blue" : UIColor.blue,"green" : UIColor.green,"gray" : UIColor.gray,"brown" : UIColor.brown,"black" : UIColor.black,"yellow" : UIColor.yellow,"cyan" : UIColor.cyan,"white" : UIColor.white]
    var timecount :Double = UserDefaults.standard.double(forKey: "second")
    var highscore = UserDefaults.standard.integer(forKey: "highscore")
    
    var point : Int = 0
    var score = 0
    var fgcolor = ["red","blue","green","gray","brown","black","yellow","cyan","white"]
    var bgcolor = ["red","blue","green","gray","brown","black","yellow","cyan","white"]
    var a = ""
    var b = ""
    var life = 1
    // var count = 0
    
    @IBOutlet weak var cw: UICollectionView!
    @IBOutlet weak var scoreOutlet: UILabel!
    @IBOutlet weak var pg: UIProgressView!
    @IBOutlet weak var lifeLine1: UIImageView!
    @IBOutlet weak var lifeLine2: UIImageView!
    @IBOutlet weak var lifeLine3: UIImageView!
    var time = Timer()
    var freq = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreOutlet.layer.cornerRadius = 10
        scoreOutlet.layer.masksToBounds = true
        pg.progress = 1.0
        progress()
        logic()
        scoreupdate()
        
    }
    func logic() {
        a = fgcolor.randomElement()!
        b = bgcolor.randomElement()!
        while a == b {
            a = fgcolor.randomElement()!
            b = bgcolor.randomElement()!
        }
        var number = Int.random(in: 0...8)
        while number >= 4 {
            number = Int.random(in: 0...8)
        }
        var array1 : [String] = []
        if number <= 4 {
            for i in 0...3 {
                array1.append(a)
            }
        }
        for i in 0...4 {
            array1.append(b)
        }
        bgcolor = array1
        bgcolor.shuffle()
        cw.reloadData()
    }
    
    func scoreupdate(){
        if point > highscore{
            highscore = point
        }
    }
    func progress(){
        var a : Float = 1.0
        self.pg.progress = a
        time.invalidate()
        time = Timer.scheduledTimer(withTimeInterval: freq, repeats: true, block: { _ in
            a -= 0.01
            self.pg.progress = a
            if self.pg.progress == 0.0{
                self.pg.progress = 1.0
                self.time.invalidate()
                self.scoreupdate()
                self.showalert()
                
                
            }
        })
    }
    
    func showalert(){
        scoreupdate()
        let alert = UIAlertController(title: "Game Over\n", message: "score :\(point)\n high score :\(highscore)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Home", style: .default,handler: { _ in
            self.navigateHome()
            self.logic()
        }))
        alert.addAction(UIAlertAction(title: "Restart", style: .destructive,handler: { _ in
            self.life = 1
            self.progress()
            self.scoreupdate()
            self.point = 0
            self.scoreOutlet.text = "0"
            self.logic()
            self.lifeLine1.image = UIImage(systemName: "heart.fill")
            self.lifeLine2.image = UIImage(systemName: "heart.fill")
            self.lifeLine3.image = UIImage(systemName: "heart.fill")
            
        }))
        present(alert, animated: true)
    }
    
    func navigateHome(){
        let n = storyboard?.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        navigationController?.popViewController(animated: false)
    }
    
    func navigateRestart(){
        let n = storyboard?.instantiateViewController(withIdentifier: "ViewController3") as! ViewController3
        navigationController?.pushViewController(n, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fgcolor.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cw.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell2
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.backgroundColor = colourhelper[bgcolor[indexPath.row]]?.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if bgcolor[indexPath.row] == b{
            
            point += 1
            scoreOutlet.text = "\(point)"
            timecount = UserDefaults.standard.double(forKey: "second")
            logic()
            progress()
        }
        else if life == 1{
            lifeLine1.image = UIImage(systemName: "heart")
            life += 1
            cw.reloadData()
            progress()
        }
        else if life == 2{
            lifeLine2.image = UIImage(systemName: "heart")
            life += 1
            cw.reloadData()
            logic()
            progress()
        }
        else if life == 3{
            lifeLine3.image = UIImage(systemName: "heart")
           showalert()
        }
    
    }
}
