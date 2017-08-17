//  MSVViewController
//  MSVRoundedDraggableUIImageView
//
//  Created by sergemoskalenko on 08/16/2017.
//  Copyright (c) 2017 sergemoskalenko. All rights reserved.
//  skype:camopu-ympo, http://camopu.rhorse.ru/ios
//

import UIKit
import MSVRoundedDraggableUIImageView_Swift

class MSVViewController: UIViewController {
    @IBOutlet weak var switchView: UISwitch!
    var imageView: MSVDraggableImageView?
    @IBOutlet var imageViewOnTop: MSVRoundedDraggableImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView = MSVDraggableImageView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        imageView?.image = UIImage(named: "earth")
        imageView?.center = view.center
        imageView?.isUserInteractionEnabled = true
        imageView?.pinStartPoint()
        view.addSubview(imageView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        UIApplication.shared.openURL(URL(string: "http://camopu.rhorse.ru/MSVRoundedDraggableUIImageView")!)
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        imageView?.isMovedToStartPoint = sender.isOn
        if (imageView?.isMovedToStartPoint)! {
            imageView?.moveToStartPoint()
        }
        imageViewOnTop.isMovedToStartPoint = sender.isOn
        if imageViewOnTop.isMovedToStartPoint {
            imageViewOnTop.moveToStartPoint()
        }
    }
}
