
import UIKit

class ViewController3: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    
    var colour = [UIColor.brown,UIColor.brown,UIColor.brown,UIColor.brown,UIColor.brown,UIColor.green,UIColor.green,UIColor.green,UIColor.green]
    var rendomColour = UIColor()
    var string1 = ["red,blue,green,gray,brown,black,yellow,cyan,white"]
    
    var arr : [String : UIColor] = ["red" : UIColor.red,"blue" : UIColor.blue,"green" : UIColor.green,"gray" : UIColor.gray,"brown" : UIColor.brown,"black" : UIColor.black,"yellow" : UIColor.yellow,"cyan" : UIColor.cyan,"white" : UIColor.white]
    var arr2 : [UIColor] = [UIColor.red,UIColor.red, UIColor.red,UIColor.red,UIColor.red, UIColor.black,UIColor.black, UIColor.black,UIColor.black]
    
    
    
    @IBOutlet weak var cw: UICollectionView!
    
    @IBOutlet weak var scoreOutlet: UILabel!
    
    @IBOutlet weak var pg: UIProgressView!
    var time = Timer()
    var freq = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreOutlet.layer.cornerRadius = 10
        scoreOutlet.layer.masksToBounds = true
        pg.progress = 1.0
        progress()
        //updatecolor()
        
        
    }
    func progress(){
        var a : Float = 1.0
        self.pg.progress = a
        time = Timer.scheduledTimer(withTimeInterval: freq, repeats: true, block: { _ in
            a -= 0.01
            self.pg.progress = a
            if self.pg.progress == 0.0{
                self.pg.progress = 1.0
                self.time.invalidate()
                self.showalert()
            }
        })
    }
    func showalert(){
        let alert = UIAlertController(title: "Game Over", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Home", style: .default,handler: { _ in
            self.navigateHome()
        }))
        alert.addAction(UIAlertAction(title: "Restart", style: .destructive,handler: { _ in
            self.progress()
            
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
        return arr2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell2
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        //cell.backgroundColor = .green
        cell.backgroundColor = arr2[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        arr2.randomElement()
    }
    
    
    
    
}
