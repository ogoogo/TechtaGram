//
//  ViewController.swift
//  TechtaGram
//
//  Created by 生越冴恵 on 2021/08/13.
//

import UIKit

class ViewController: UIViewController ,UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
    
    @IBOutlet var cameraImageView:UIImageView!
    var originalImage:UIImage!
    var filter:CIFilter!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func takePhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate=self
            picker.allowsEditing=true
            present(picker, animated: true, completion: nil)
        }else{
            print("error")
        }
    }
    @IBAction func savePhoto(){
        UIImageWriteToSavedPhotosAlbum(cameraImageView.image!, nil, nil, nil)
    }
    @IBAction func colorFilter(){
        
        let filterImage:CIImage=CIImage(image: originalImage)!
        
        filter=CIFilter(name: "CIColorControls")
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        
        filter.setValue(1.0, forKey: "inputSaturation")
        
        filter.setValue(0.5, forKey: "inputBrightness")
        
        filter.setValue(2.5, forKey: "inputContrast")
        
        let ctx=CIContext(options: nil)
        let cgImage=ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image=UIImage(cgImage: cgImage!)
        
        
        
    }
    @IBAction func openAlbum(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker=UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.allowsEditing=true
            picker.delegate=self
            
            present(picker, animated: true, completion: nil)
            }
    }
    @IBAction func snsPhoto(){
        let shareText="加工しました"
        let shareImage=cameraImageView.image!
        let activityItems:[Any]=[shareText,shareImage]
        let activityViewController=UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        let excludeActivityTypes=[UIActivity.ActivityType.postToWeibo,.saveToCameraRoll,.print]
        
        activityViewController.excludedActivityTypes = excludeActivityTypes
        
        present(activityViewController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        cameraImageView.image=info[.editedImage] as? UIImage
        originalImage=cameraImageView.image
        dismiss(animated: true, completion: nil)
    }


}

