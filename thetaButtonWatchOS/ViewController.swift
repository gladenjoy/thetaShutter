
import UIKit
import Alamofire
import SwiftyJSON

let ApplicationUpdateCountNotification = "ApplicationUpdateCountNotification"

class ViewController: UIViewController {
    var sessionID: String? = ""
    var appDelegate:AppDelegate?
    
    
    @IBOutlet weak var textview: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate //AppDelegateのインスタンスを取得
        
        //session Start
        let param = [
            "name": "camera.startSession",
            "parameters": ["":""]
        ]
        Alamofire.request(.POST, "http://192.168.1.1/osc/commands/execute", parameters: param, encoding: .JSON).responseJSON { response in
            debugPrint(response.result)
            let jsonDic = response.result.value as! NSDictionary
            let responseData = jsonDic["results"] as! NSDictionary
            self.sessionID = String(responseData["sessionId"]!)
            self.appDelegate?.sessionID = String(responseData["sessionID"]!)
            
            self.textview.text = self.textview.text! + String(response)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        //セッションの終了
        let param = [
            "name": "camera.closeSession",
            "parameters": ["sessionId": self.sessionID!]
        ]
        Alamofire.request(.POST, "http://192.168.1.1/osc/commands/execute", parameters: param,
            encoding: .JSON) .responseJSON { response in
                print(response)
                self.textview.text = self.textview.text! + String(response)
                
        }
        
        
    }
    
    @IBAction func startSessionButton(sender: AnyObject) {
        let param = [
            "name": "camera.startSession",
            "parameters": ["":""]
        ]
        Alamofire.request(.POST, "http://192.168.1.1/osc/commands/execute", parameters: param, encoding: .JSON).responseJSON { response in
            debugPrint(response.result)
            let jsonDic = response.result.value as! NSDictionary
            let responseData = jsonDic["results"] as! NSDictionary
            self.sessionID = String(responseData["sessionId"]!)
            
            self.textview.text = self.textview.text! + String(response)
        }
        
    }
    @IBAction func takePicButton(sender: AnyObject) {
        let param = [
            "name": "camera.takePicture",
            "parameters": ["sessionId" : self.sessionID!]
        ]
        debugPrint(param)
        Alamofire.request(.POST, "http://192.168.1.1/osc/commands/execute", parameters: param,
            encoding: .JSON)  .responseJSON { response in
                print(response)
                self.textview.text = self.textview.text! + String(response)
        }
        
        
    }
    @IBAction func endSessionButton(sender: AnyObject) {
        let param = [
            "name": "camera.closeSession",
            "parameters": ["sessionId": self.sessionID!]
        ]
        Alamofire.request(.POST, "http://192.168.1.1/osc/commands/execute", parameters: param,
            encoding: .JSON) .responseJSON { response in
                print(response)
                self.textview.text = self.textview.text! + String(response)
                
        }
        
    }
}