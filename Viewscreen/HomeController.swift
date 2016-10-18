//
//  HomeController.swift
//  Viewscreen
//
//  Created by Ugowe on 10/13/16.
//  Copyright © 2016 Ugowe. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
//    var videos: [Video] = {
//        
//        var sadeChannel = Channel()
//        sadeChannel.name = "SadeChannel"
//        sadeChannel.profileImageName = "sadepic"
//        
//        var smoothOperatorVideo = Video()
//        smoothOperatorVideo.title = "Sade - Smooth Operator"
//        smoothOperatorVideo.thumbnailImageName = "smooth_operators"
//        smoothOperatorVideo.channel = sadeChannel
//        smoothOperatorVideo.numberOfViews = 23423423242
//        
//        var kissOfLifeVideo = Video()
//        kissOfLifeVideo.title = "Sade - Kiss Of Life"
//        kissOfLifeVideo.thumbnailImageName = "kiss_of_life"
//        kissOfLifeVideo.channel = sadeChannel
//        kissOfLifeVideo.numberOfViews = 32323432423
//        
//        return [smoothOperatorVideo, kissOfLifeVideo]
//    }()
    
    
    var videos: [Video]?
    
    func fetchVideos() {
        let urlString = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        let session = URLSession.shared
        let url = URL(string: urlString)
        let task = session.dataTask(with: url!) { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                self.videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    self.videos?.append(video)
                }
                
                self.collectionView?.reloadData()
                
            } catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        fetchVideos()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)

        setupMenuBar()
        setupNavBarButtons()
//        setupBottomBar()
    }
    
    func setupNavBarButtons() {
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let searchBarButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let menuImage = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
        let menuButton = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [menuButton, searchBarButton]
    }
    
    func handleSearch() {
        
    }
    
    func handleMore() {
        
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addLayoutConstraints(format: "H:|[v0]|", views: menuBar)
        view.addLayoutConstraints(format: "V:|[v0(50)]", views: menuBar)
    }
//    
//    let bottomBar: UIView = {
//        let bb = UIView()
//        bb.backgroundColor = UIColor.green
//        return bb
//    }()
//    
//    private func setupBottomBar(){
//        view.addSubview(bottomBar)
//        view.addLayoutConstraints(format: "H:|[v0]|", views: bottomBar)
//        view.addLayoutConstraints(format: "V:[v0(50)]|", views: bottomBar)
//    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        
        cell.video = videos?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 88)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}





