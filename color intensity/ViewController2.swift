
import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var easy: UIButton!
    
    @IBOutlet weak var medium: UIButton!
    
    @IBOutlet weak var hard: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSegment()

       
    }
    func buttonSegment(){
       
        easy.layer.cornerRadius = 10
        easy.layer.masksToBounds = true
        
        medium.layer.cornerRadius = 10
        medium.layer.masksToBounds = true
        
        hard.layer.cornerRadius = 10
        hard.layer.masksToBounds = true
    }
    
    @IBAction func easyButtonAction(_ sender: UIButton) {
        navigate()
    }
    @IBAction func mediumButtonAction(_ sender: UIButton) {
        navigate2()
    }
    @IBAction func hardButtonAction(_ sender: UIButton) {
        navigate3()
    }
    func navigate(){
        let n = storyboard?.instantiateViewController(withIdentifier: "ViewController3") as! ViewController3
        n.freq = 0.1
        UserDefaults.standard.set(10, forKey: "second")
        navigationController?.pushViewController(n, animated: true)
    }
    func navigate2(){
        let n = storyboard?.instantiateViewController(withIdentifier: "ViewController3") as! ViewController3
        n.freq = 0.050
        UserDefaults.standard.set(7, forKey: "second")
        navigationController?.pushViewController(n, animated: true)
    }
    func navigate3(){
        let n = storyboard?.instantiateViewController(withIdentifier: "ViewController3") as! ViewController3
        n.freq = 0.020
        UserDefaults.standard.set(5, forKey: "second")
        navigationController?.pushViewController(n, animated: true)
    }


}
