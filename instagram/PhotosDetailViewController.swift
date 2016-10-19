//
//  PhotosDetailViewController.swift
//  
//
//  Created by Alex Liu on 10/19/16.
//
//

import UIKit

class PhotosDetailViewController: UIViewController {

  var photoURL: String?
  var post : NSDictionary!
  @IBOutlet weak var photosImageView: UIImageView!

    override func viewDidLoad() {
      super.viewDidLoad()

      photosImageView.setImageWith(URL(string: photoURL!)!)
      // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
