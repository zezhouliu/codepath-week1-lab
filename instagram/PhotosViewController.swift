//
//  PhotosViewController.swift
//  instagram
//
//  Created by Alex Liu on 10/19/16.
//  Copyright © 2016 alex_liu. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.rowHeight = 320

    // Do any additional setup after loading the view, typically from a nib.
    let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
    let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=\(apiKey)")
    let request = URLRequest(url: url!)
    let session = URLSession(
      configuration: URLSessionConfiguration.default,
      delegate:nil,
      delegateQueue:OperationQueue.main
    )

    let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
      if let data = dataOrNil {
        if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
          print("response: \(responseDictionary)")

          let postsOrNil = responseDictionary.value(forKeyPath: "response.posts") as? [NSDictionary]
          if let posts = postsOrNil {
            print("DSADSA")
            self.posts = posts

            self.tableView.reloadData()
          }
        }
      }
    });

    task.resume()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // Private
  internal var posts: [NSDictionary]?
  internal var photoURLString : String?

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let posts = self.posts {
      return posts.count
    }

    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath)

    if let photoCell = cell as? PhotoCell, let posts = self.posts {
      let post = posts[indexPath.row]
      if let photos = post.value(forKeyPath: "photos") as? [NSDictionary] {
        let actualPhotos = photos.first
        if let photoURL = actualPhotos?.value(forKeyPath: "original_size.url") as? String {
          photoCell.photoImageView.setImageWith(URL(string: photoURL)!)
          return photoCell
        }
      }
    }

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    tableView.deselectRow(at: indexPath, animated: true)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let cell = sender as! UITableViewCell
    let indexPath = tableView.indexPath(for:cell)
    let post = posts![indexPath!.row]
    let photoDetailViewController = segue.destination as! PhotosDetailViewController
    if let photos = post.value(forKeyPath: "photos") as? [NSDictionary] {
      let actualPhotos = photos.first
      if let photoURL = actualPhotos?.value(forKeyPath: "original_size.url") as? String {
        photoDetailViewController.photoURL = photoURL
      }
    }
    photoDetailViewController.post = post
  }
}
