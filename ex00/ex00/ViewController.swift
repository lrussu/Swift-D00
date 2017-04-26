//
//  ViewController.swift
//  ex00
//
//  Created by Liudmila Russu on 4/25/17.
//  Copyright © 2017 Liudmila Russu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var items = ["https://www.nesdis.noaa.gov/sites/default/files/assets/images/abi_full_disk_jan_15_2017_high_res.jpg", "htps://www.nesdis.noaa.gov/sites/default/files/assets/images/abi_full_disk_jan_15_2017_high_res1.jpg"]
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        cell.contentMode = .scaleAspectFit
        cell.myActivityIndicator.startAnimating()
        cell.myImageView.downloadedFrom(vc: self, link: self.items[indexPath.row], ai: cell.myActivityIndicator)
      //  cell.myActivityIndicator.stopAnimating()
        cell.myImageView.contentMode = .scaleAspectFit
        cell.myImageView.clipsToBounds = true
        //cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
       // cell.layer.borderColor = UIColor.black.cgColor
      //  cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        
        return cell
    }
    
    
    //    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        updateCollectionViewLayout(with: size)
//    }
    
    private func updateCollectionViewLayout(with size: CGSize) {
        super.viewWillLayoutSubviews()

        
//        let padding: CGFloat =  10.0
//        let collectionViewSizeWidth = self.myCollectionView.frame.size.width - padding
//        let collectionViewSizeHeight = self.myCollectionView.frame.size.height - padding
//        let itemCountInRawForPortraitMode: CGFloat = 2
//        let itemCountInRawForLandscapeMode: CGFloat = 4
//        let collectionViewCellSizeWidthForPortraitMode = collectionViewSizeWidth / itemCountInRawForPortraitMode
//        let collectionViewCellSizeWidthForLandscapeMode = collectionViewSizeWidth / itemCountInRawForLandscapeMode
//        
//        if let layout = self.myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.itemSize = ((size.width < size.height) ? CGSize(width: collectionViewCellSizeWidthForPortraitMode, height: collectionViewSizeHeight/4) : CGSize(width: collectionViewCellSizeWidthForLandscapeMode, height: collectionViewSizeHeight/4))
//            layout.invalidateLayout()
//        }
    }
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        if cell.myActivityIndicator.isAnimating
        {
            return
        } else {
            self.performSegue(withIdentifier: "imageToScrollSegue", sender: cell)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let padding: CGFloat =  10.0
        let collectionViewSizeWidth = (collectionView.frame.size.width - padding) / 2
        let collectionViewSizeHeight = (collectionView.frame.size.height - padding) / 4
        return CGSize(width: collectionViewSizeWidth, height: collectionViewSizeHeight)
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        
//        guard let flowLayout = self.myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
//            return
//        }
//        
//        if UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) {
//            
//            flowLayout.itemSize = CGSize(width: 50, height: 50)
//        } else {
//            //logic if not landscape
//            flowLayout.itemSize = CGSize(width: 100, height: 100)
//        }
//        
//        flowLayout.invalidateLayout()
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageToScrollSegue" {
            if let controller = segue.destination as? ScrollViewController
            {
                if let s = sender as? MyCollectionViewCell
                {
                    if s.myImageView.image != nil
                    {
                        controller.image = s.myImageView.image!
                    }
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

extension UIViewController {
    func alert(title: String, message: String)
    {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okBTN = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(okBTN)
        self.present(alert, animated: true)
    }
}

extension UIImageView {
    
    func downloadedFrom(vc: UIViewController , url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit, ai: UIActivityIndicatorView) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if nil != error
            {
                vc.alert(title: "\((response as? HTTPURLResponse)?.statusCode)", message: "Error")
            }
            else {
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    
                else {

                    return
                }
                print("httpURLResponse.statusCode = \(httpURLResponse.statusCode)")
                DispatchQueue.main.async() {
                    () -> Void in
                        self.image = image
                        ai.stopAnimating()
                }
            }
        }.resume()
    }
   
    func downloadedFrom(vc: UIViewController, link: String, contentMode mode: UIViewContentMode = .scaleAspectFit, ai: UIActivityIndicatorView) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(vc: vc, url: url, contentMode: mode, ai: ai)
    }
}

//extension UIImageView {
//    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFill, ai: UIActivityIndicatorView) {
//        let queue = DispatchQueue.global(qos: .utility)
//        queue.async{
//            if let data = try? Data(contentsOf: url){
//                DispatchQueue.main.async {
//                    self.image = UIImage(data: data)
//                    ai.stopAnimating()
//                    
//                }
//            }
//            else
//            {
//                let alert = UIAlertController(title: "Do something", message: "With this", preferredStyle: .actionSheet)
//                alert.addAction(UIAlertAction(title: "A thing", style: .default) {
//                    action in
//                    // perhaps use action.title here
//                })
//            }
//        }
//
////        contentMode = mode
////        URLSession.shared.dataTask(with: url) { (data, response, error) in
////            guard
////                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
////                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
////                let data = data, error == nil,
////                let image = UIImage(data: data)
////                else { return }
////            DispatchQueue.main.async() { () -> Void in
////                self.image = image
////            }
////        }.resume()
//    }
//    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFill, ai: UIActivityIndicatorView) {
//        guard let url = URL(string: link) else { return }
//        downloadedFrom(url: url, contentMode: mode, ai: ai)
//    }
//}
