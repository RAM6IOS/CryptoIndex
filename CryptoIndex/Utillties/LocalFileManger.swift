//
//  LocalFileManger.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 20/5/2022.
//

import Foundation
import UIKit
import SwiftUI



 class LocalFileManger {
    
    static let instance = LocalFileManger()
    private init() { }
    
     func saveImage(image: UIImage , imageNmae: String , folderName:String){
         createFolderIfNeeded(foldername: folderName)
         
         guard
            let data = image.pngData() ,
            let url = getURLFotImage(imageNamge: imageNmae, foldername: folderName)
         else{ return}
         
         do{
             try data.write(to: url)
             
         } catch let error {
             print("Error saving image \(error)")
         }
        
    }
     
     func getImage(imageName:String ,foldername: String) -> UIImage?{
         guard
            let url = getURLFotImage(imageNamge: imageName, foldername: foldername),
            FileManager.default.fileExists(atPath: url.path) else {
                return nil
            }
         
         return UIImage(contentsOfFile: url.path)
         
     }
     
     private func createFolderIfNeeded(foldername:String){
         guard let url = getURLForFolder(foldername: foldername)  else {
             return
         }
         
         if !FileManager.default.fileExists(atPath: url.path){
             do{
                 try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
             } catch let error {
                 print("Error creating directory FolderName:\(foldername).\(error)")
                 
             }
             
         }
     }
     
  private   func getURLForFolder(foldername: String ) -> URL?{
         guard let url = FileManager.default.urls(for:.cachesDirectory , in: .userDomainMask).first else {
             return nil
         }
         return url.appendingPathComponent(foldername)
         
     }
     
     private func getURLFotImage(imageNamge:String , foldername: String) -> URL? {
         guard let folderURL = getURLForFolder(foldername: foldername) else {
             return nil
         }
         
         return folderURL.appendingPathComponent(imageNamge + ".pang")
         
     }
    
    
}
