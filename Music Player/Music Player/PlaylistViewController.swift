//
//  PlaylistViewController.swift
//  Music Player
//
//  Created by JeremyXue on 2018/6/11.
//  Copyright © 2018年 JeremyXue. All rights reserved.
//

import UIKit


protocol ChangeSong {
    func changeSong(songFile:String,songAlbum:String,songNumber:Int)
}

class PlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var playlistTableView: UITableView!
    
    var changeSongDelegate:ChangeSong?
    
    var playlist: [SongModel] = [
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.beginReceivingRemoteControlEvents()
        setGradientLayer()
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
        listMp3s()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    fileprivate func listMp3s() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let directoryContents = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            playlist = directoryContents
                .filter{ $0.pathExtension == "mp3" }
                .map { url -> SongModel in
                    return SongModel(songImage: url.deletingPathExtension().lastPathComponent, songFile: url.deletingPathExtension().lastPathComponent)
                    
                }
            // process files
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
    }
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let songCell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        
        songCell.imageView?.image = UIImage(named: playlist[indexPath.row].songImage)
        songCell.imageView?.layer.cornerRadius = (songCell.imageView?.frame.height)! / 2
        songCell.imageView?.clipsToBounds = true
        songCell.textLabel?.text = playlist[indexPath.row].songFile
        songCell.textLabel?.textColor = UIColor.white
        songCell.backgroundColor = UIColor.clear
        
        return songCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let playerVC = self.navigationController?.viewControllers[0] as? PlayerViewController{
            self.changeSongDelegate = playerVC
            changeSongDelegate?.changeSong(songFile: playlist[indexPath.row].songFile, songAlbum: playlist[indexPath.row].songImage, songNumber: indexPath.row)
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    func setGradientLayer() {
        let color1 = #colorLiteral(red: 0.631372549, green: 0.5490196078, blue: 0.8196078431, alpha: 1).cgColor
        let color2 = #colorLiteral(red: 0.9843137255, green: 0.7607843137, blue: 0.9215686275, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [color1,color2]
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    

}
