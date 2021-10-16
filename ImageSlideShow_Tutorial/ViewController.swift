//
//  ViewController.swift
//  ImageSlideShow_Tutorial
//
//  Created by SeongMinK on 2021/10/16.
//

import UIKit
import ImageSlideshow

class ViewController: UIViewController {
    
    @IBOutlet weak var myImageSlide: ImageSlideshow!
     
    let imageResources = [
        KingfisherSource(urlString: "https://images.unsplash.com/photo-1601408594761-e94d31023591?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", placeholder: UIImage(systemName: "photo")?.withTintColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), renderingMode: .alwaysOriginal), options: .none)!,
        KingfisherSource(urlString: "https://images.unsplash.com/photo-1593642702909-dec73df255d7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", placeholder: UIImage(systemName: "photo")?.withTintColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), renderingMode: .alwaysOriginal), options: .none)!,
        KingfisherSource(urlString: "https://images.unsplash.com/photo-1593642532973-d31b6557fa68?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", placeholder: UIImage(systemName: "photo")?.withTintColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), renderingMode: .alwaysOriginal), options: .none)!,
        KingfisherSource(urlString: "https://images.unsplash.com/photo-1601293058843-f34e8dd9ccfd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", placeholder: UIImage(systemName: "photo")?.withTintColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), renderingMode: .alwaysOriginal), options: .none)!,
        KingfisherSource(urlString: "https://images.unsplash.com/photo-1601351581610-7bc02ab3b914?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", placeholder: UIImage(systemName: "photo")?.withTintColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), renderingMode: .alwaysOriginal), options: .none)!
    ]

    let mySecondSlideShow: ImageSlideshow = {
        let slideShow = ImageSlideshow()
        slideShow.isUserInteractionEnabled = true
        slideShow.slideshowInterval = 1.5
        slideShow.contentScaleMode = .scaleAspectFill
        slideShow.translatesAutoresizingMaskIntoConstraints = false
        return slideShow
    }()
    
    let labelBgView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let myLabelIndicator: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "qwerty"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func loadView() {
        super.loadView()
        print(#fileID, #function, "called")
        
        let labelPageIndicator = LabelPageIndicator()
        labelPageIndicator.textColor = .white
        mySecondSlideShow.pageIndicator = labelPageIndicator
        mySecondSlideShow.setImageInputs(imageResources)
        
        self.view.addSubview(mySecondSlideShow)
        NSLayoutConstraint.activate([
            mySecondSlideShow.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mySecondSlideShow.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mySecondSlideShow.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            mySecondSlideShow.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        mySecondSlideShow.addSubview(labelBgView)
        NSLayoutConstraint.activate([
            labelBgView.centerXAnchor.constraint(equalTo: labelPageIndicator.view.centerXAnchor),
            labelBgView.centerYAnchor.constraint(equalTo: labelPageIndicator.view.centerYAnchor),
            labelBgView.widthAnchor.constraint(equalTo: labelPageIndicator.widthAnchor, multiplier: 1.2),
            labelBgView.heightAnchor.constraint(equalTo: labelPageIndicator.heightAnchor, multiplier: 1.2)
        ])
        // 라벨 인디케이터를 맨 앞으로 가져옴
        mySecondSlideShow.bringSubviewToFront(labelPageIndicator)
        
        print("UIDevice.current.hasNotch: \(UIDevice.current.hasNotch)")
        
        // 디바이스에 노치가 있는지 신경써서 페이지 인디케이터 위치 조절
        mySecondSlideShow.pageIndicatorPosition = .init(horizontal: .right(padding: 15), vertical: .customBottom(padding: UIDevice.current.hasNotch == true ? -15 : 10))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        mySecondSlideShow.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(#fileID, #function, "called")
        
        myImageSlide.setImageInputs(imageResources)
        myImageSlide.contentScaleMode = .scaleAspectFill
        myImageSlide.slideshowInterval = 2
        myImageSlide.pageIndicatorPosition = .init(horizontal: .right(padding: 10),vertical: .bottom)
    }
    
    @objc func didTap(_ sender: UITapGestureRecognizer? = nil) {
        print(#fileID, #function, "called")
        let fullScreenController = mySecondSlideShow.presentFullScreenController(from: self, completion: nil)
        fullScreenController.slideshow.pageIndicator = LabelPageIndicator()
        fullScreenController.view.addSubview(myLabelIndicator)
        myLabelIndicator.topAnchor.constraint(equalTo: fullScreenController.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        myLabelIndicator.centerXAnchor.constraint(equalTo: fullScreenController.view.centerXAnchor).isActive = true
        
        let currentPageString = String(fullScreenController.slideshow.currentPage + 1)
        myLabelIndicator.text = currentPageString + " / \(fullScreenController.slideshow.images.count)"
        
        fullScreenController.slideshow.delegate = self
    }
}

extension ViewController: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print(#fileID, #function, "called / Page: \(page + 1)")
        myLabelIndicator.text = String(page + 1) + " / " + String(imageSlideshow.images.count)
    }
}

// 디바이스에 노치가 있는지 확인
extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 12.0, *) {
            if UIApplication.shared.windows.count == 0 { return false }
            let top = UIApplication.shared.windows[0].safeAreaInsets.top
            return top > 20
        } else {
            return false
        }
    }
}
