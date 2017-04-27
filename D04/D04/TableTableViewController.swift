////
////  TableTableViewController.swift
////  D04
////
////  Created by Liudmila Russu on 4/27/17.
////  Copyright © 2017 Liudmila Russu. All rights reserved.
////
//
//import UIKit
//
//protocol APITwitterDelegate
//{
//    func receivedTweet(tweetArray: [Tweet])
//    func errorTweet(error: NSError)
//}
//
//struct Tweet: CustomStringConvertible
//{
//    let name: String
//    let text: String
//    let date: String
//    
//    var description: String {
//        return "(\(name), \(text))"
//    }
//    
//    init(name: String, text: String, date: String)
//    {
//        self.name = name
//        self.text = text
//        self.date = date
//    }
//}
//
//
//class TableTableViewController: UITableViewController {
//    var t:[Tweet] = tweetData
//   
//    @IBOutlet weak var searchTextField: UITextField!
//    
//    var tweet: Tweet = Tweet(name: "I", text: "Saome text", date: "2017-04-27")
//    
//    var delegate : APITwitterDelegate? = nil
//    
//    var token : String?
//    
//    
//    // this is a convenient way to create this view controller without a imageURL
//    convenience init() {
//        self.init(delegate: nil, token: "", tweet: Tweet(name: "I", text: "Saome text", date: "2017-04-27"))
//    }
//    
//    init(delegate: APITwitterDelegate?, token: String, tweet: Tweet)
//    {
//        self.delegate = delegate
//        self.token = token
//        self.tweet = Tweet(name: "I", text: "Saome text", date: "2017-04-27")
//        super.init(nibName: nil, bundle: nil)
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    
//    
//    internal func errorTweet(error: NSError) {
//        print(Error.self)
//    }
//    
//    internal func receivedTweet(tweetArray: [Tweet]) {
//        getToken()
//    }
//    
//    //   curl --get 'https://api.twitter.com/1.1/search/tweets.json' --data 'count=10&q=ecole' --header 'Authorization: Bearer AAAAAAAAAAAAAAAAAAAAAPFp0QAAAAAAP5EAC2I%2B43KvzuvrxjDmzjBPW%2Fw%3DPuvTNX2Mz8psCsQdxFsOjlYxUnDToskJYE01KDnuBLQwBsCiO1' --verbose
//    
//    func strInTweet_100(str: String)
//    {
//        let ACCESS_TOKEN = AppDelegate.appToken
//        //let BEARER = ((ACCESS_TOKEN).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
//        let url = URL(string: "https://api.twitter.com/1.1/search/tweets.json?q=\(str.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&lang=fr&result_type=recent&count=100")
//        var request = URLRequest(url: url!)
//        request.httpMethod = "GET"
//        request.setValue("Bearer " + ACCESS_TOKEN, forHTTPHeaderField: "Authorization")
//        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
//        // request.httpBody = "?q=\(str.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&lang=fr&result_type=recent&count=100".data(using: String.Encoding.utf8)
//        
//        let task = URLSession.shared.dataTask(with: request) {
//            
//            (data, response, error) in
//            
//            if nil != error {
//                print("ERROR \(error!)")
//            }
//            else if nil != data {
//                do {
//                    print("TWEETS")
//                    print(data!)
//                    if let dic  = try JSONSerialization.jsonObject(with: data!, options: [])  as? Any
//                    {
//                        print(dic)
//                        // AppDelegate.appToken = dic["access_token"] as! String
//                        // self.initAll()
//                        // self.printtopics()
//                    }
//                }
//                catch (let err) {
//                    print(err)
//                }
//            }
//        }
//        task.resume()
//    }
//    
//    
//    
//    
//    
//    func getToken()  {
//        let CUSTOMER_KEY = AppDelegate.uid
//        let CUSTOMER_SECRET = AppDelegate.secret
//        let BEARER = ((CUSTOMER_KEY + ":" + CUSTOMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
//        
//        let url = URL(string: "https://api.twitter.com/oauth2/token")
//        var request = URLRequest(url: url!)
//        request.httpMethod = "POST"
//        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
//        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
//        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if nil != error {
//                print(error!)
//            }
//            else if nil != data {
//                do {
//                    if let dic : Dictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
//                    {
//                        print(dic)
//                        AppDelegate.appToken = dic["access_token"] as! String
//                    }
//                }
//                catch (let err) {
//                    print(err)
//                }
//            }
//        }
//        task.resume()
//    }
//    
//    func textFieldDidChange(_ textField: UITextField) {
//        if textField.text != ""
//        {
//            self.strInTweet_100(str: textField.text!)
//        }
//    }    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.getToken()
//        self.searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    // MARK: - Table view data source
//
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return t.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet", for: indexPath)  as! TweetCell
//        
//        let tw = t[indexPath.row] as Tweet
//        cell.tweet = tw
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//    }
//    
//
//    
//    /*
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
//    }
//    */
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    /*
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
//    */
//
//    /*
//    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//    }
//    */
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
