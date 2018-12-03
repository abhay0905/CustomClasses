//
//  ImageDownloader.swift
//  
//
//  Created by Abhay Shankar on 20/09/18.
//  Copyright © 2018 Self. All rights reserved.
//

import UIKit
import Foundation
import AVKit
import Photos
import MobileCoreServices
import AVFoundation

/// Thumbnail downloader for Videos with caching.
class VideoThumbnailDownloader: NSObject {
     /// Singleton for accessing downloader
     static let shared = VideoThumbnailDownloader()
    
    
    /// Cache for images
    var downloadingCache : Dictionary<String,[((UIImage?,String)-> Void)]> = [:]
    
     /// Generates an image for AVAsset
     ///
     /// - Parameters:
     ///   - url: URL of video
     ///   - postID: ID of video
     ///   - completed: Block called when completed
     func generateThumbnail(url: URL, postID : String,completed:@escaping ((UIImage?,String)-> Void) ) {
        if var downloadingObjList = downloadingCache[postID]{
            downloadingObjList.append(completed)
            downloadingCache.updateValue(downloadingObjList, forKey: postID)
        }else{
            downloadingCache.updateValue([completed], forKey: postID)
                let asset = AVURLAsset(url: url)
                let imageGenerator = AVAssetImageGenerator(asset: asset)
                imageGenerator.appliesPreferredTrackTransform = true
            imageGenerator.generateCGImagesAsynchronously(forTimes: [CMTime.zero as NSValue]) { (_, cgImage, _, result, error) in
                    if let cgImage = cgImage{
                        let image = UIImage(cgImage: cgImage)
                        self.downloadCompleted(image: image, postID: postID)
                    }else{
                        self.downloadCompleted(image: nil, postID: postID)
                    }
                }
        }
    }
    
    private func downloadCompleted(image:UIImage?,postID:String){
        if let downloadingObjList = downloadingCache[postID]{
            for completed in downloadingObjList{
                completed(image,postID)
            }
            downloadingCache.removeValue(forKey: postID)
        }
    }
    
}
