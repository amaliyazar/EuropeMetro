//
//  ViewController.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//
import UIKit

@IBDesignable
class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBAction func cancelButtonAction(_ sender: Any) {}
    
    var presenter: ViewControllerPressenterProtocol!
    var configurator: ViewControllerConfiguratorProtocol = ViewControllerConfigurator()
    
    let scrollView2 = UIScrollView()
    var metroView: MetroViewProtocol = MetroView()
    let tempView = UIView()
    let statusBarView = UIView()
    let morebutton = UIButton()
    //let riverImage = UIImageView(image: UIImage(named: "neva"))
    let size = 1800
    
    var pathIsDraw = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        metroView.contentScaleFactor = scrollView.zoomScale
        metroView.updateFromToScale()
       
       /* func setUpNavigationBar() {
            self.navigationController?.
        }*/
        self.navigationController?.isNavigationBarHidden = true

        
        self.view.backgroundColor = .white
        if #available(iOS 13.0, *) {
            switch traitCollection.userInterfaceStyle {
            case .light: //light mode
                tempView.backgroundColor = .white
            case .dark: //dark mode
                tempView.backgroundColor = .black
                self.view.backgroundColor = .black
            case .unspecified: //the user interface style is not specified
                tempView.backgroundColor = .white
            @unknown default:
                fatalError("pizdec")
            }
//
        } else {
            tempView.backgroundColor = .white
        }
        buttonsInit()
        screenInit()
       /* riverImage.frame = CGRect(x: size / 4,
                                  y: size / 4,
                                  width: size / 2,
                                  height: size / 2)
        riverImage.layer.opacity = 0.3 */
        
        //tempView.addSubview(riverImage)
        tempView.addSubview(metroView as! MetroView)
        scrollView.addSubview(tempView)
        self.view.addSubview(statusBarView)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if pathIsDraw {
            self.navigationController?.isNavigationBarHidden = true
            return
        }
        self.navigationController?.isNavigationBarHidden = true
        centerZoomMetroView()
    }
    
    private func screenInit() {
        metroView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        tempView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        
        metroView.delegate = self
        scrollView.delegate = self
        
        scrollView.contentSize = tempView.frame.size
        scrollView.isUserInteractionEnabled = true
        scrollView.clipsToBounds = false
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width / 1.5
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height / 1.5
        let minScale = min(scaleWidth, scaleHeight)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 3.0
        scrollView.zoomScale = minScale + 0.5
    }
    
    private func inScrollViewOffsetX(x: CGFloat) -> Bool {
        return (scrollView.contentOffset.x < x && x < scrollView.contentOffset.x + scrollView.frame.width)
    }
    
    private func inScrollViewOffsetY(y: CGFloat) -> Bool {
        return (scrollView.contentOffset.y < y && y < scrollView.contentOffset.y + scrollView.frame.height)
    }
    
    
    private func buttonsInit() {
        //more button sets
        morebutton.frame = CGRect(x: 20,
                                  y: self.view.bounds.height - 100,
                                  width: self.view.frame.width - 40,
                                  height: 50)
        morebutton.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "RouteView", comment: ""), for: .normal)
        morebutton.setTitleColor(UIColor.white, for: .normal)
        morebutton.backgroundColor = UIColor(displayP3Red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        morebutton.layer.cornerRadius = morebutton.frame.height / 2
        morebutton.addTarget(self, action: #selector(pressMoreButton), for: .touchUpInside)
        morebutton.layer.opacity = 0
        
        //navigaotBar and button sets
        statusBarView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: UIApplication.shared.statusBarFrame.height)
        statusBarView.backgroundColor = (traitCollection.userInterfaceStyle == .dark) ? .black : .white
        
        cancelButton.action = #selector(pressBack)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
        
    }
    

}


extension ViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return tempView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        metroView.contentScaleFactor = scrollView.zoomScale
        metroView.updateFromToScale()
    }
    
    
}

extension ViewController {
    
    @objc func pressBack() {
        pathIsDraw = false
        centerZoomMetroView()
        showNavigationBar(show: false)
        metroView.restoreMapToDefault()
        showMoreButton(show: false)
    }
    
    @objc func pressMoreButton() {
        self.navigationController?.isNavigationBarHidden = false
        performSegue(withIdentifier: "MoreTableView", sender: (Any).self)
        
    }
}

extension ViewController: MetroVieweDelagate {
    func willShowFromToButton(sender: FromToButtons) {
        
        let x = sender.frame.origin.x  * scrollView.zoomScale
        let x2 = sender.frame.maxX * scrollView.zoomScale
        let y = sender.frame.origin.y * scrollView.zoomScale
        let y2 = sender.frame.maxY * scrollView.zoomScale
        if !inScrollViewOffsetX(x: x) {
            UIView.animate(withDuration: 0.3, animations: {
                self.scrollView.contentOffset.x = x - 10
            })
            
        }else if !inScrollViewOffsetX(x: x2) {
            UIView.animate(withDuration: 0.3, animations: {
                self.scrollView.contentOffset.x = x2 - self.scrollView.frame.width + 10
            })
            
        }
        if !inScrollViewOffsetY(y: y) {
            UIView.animate(withDuration: 0.3, animations: {
                self.scrollView.contentOffset.y = y - 10
            })
        }
        else if !inScrollViewOffsetY(y: y2) {
            UIView.animate(withDuration: 0.3, animations: {
                self.scrollView.contentOffset.y = y2 - self.scrollView.frame.height + 10
            })
        }
    }
    
    
    func drawStationPath(sender: MetroView,data: [Int]) {
        pathIsDraw = true
        centerZoomMetroView()
        showNavigationBar(show: true)
        showMoreButton(show: true)
        presenter.data = data
    }
    
    
}

extension ViewController {
    
    func centerZoomMetroView() {
        UIView.animate(withDuration: 0.6, animations: {
            self.scrollView.zoomScale = self.view.frame.width / (self.tempView.bounds.width  / 2)
            if self.view.bounds.height < self.tempView.frame.height {
                self.scrollView.contentOffset = CGPoint(x: self.tempView.bounds.width  / 4 * self.scrollView.zoomScale,
                                                        y: self.tempView.bounds.height / 4 * self.scrollView.zoomScale - 100)
            }else{
                self.scrollView.contentOffset = CGPoint(x: self.tempView.bounds.width / 4 * self.scrollView.zoomScale,
                                                        y: 0)
            }
            
        })
        metroView.contentScaleFactor = scrollView.zoomScale
        metroView.updateFromToScale()
    }
    
    func showNavigationBar(show: Bool) {
        switch show {
        case true:
            UIView.animate(withDuration: 0.6, animations: {
                self.navigationController?.isNavigationBarHidden = false
            })
        case false:
            UIView.animate(withDuration: 0.6, animations: {
                self.navigationController?.isNavigationBarHidden = false
            })
        }
    }
    
    
    func showMoreButton(show: Bool) {
        switch show {
        case true:
            UIView.animate(withDuration: 0.6, animations: {
                self.morebutton.layer.opacity = 1
                self.morebutton.layoutIfNeeded()
            })
        case false:
            UIView.animate(withDuration: 0.6, animations: {
                self.morebutton.layer.opacity = 0
                self.morebutton.layoutIfNeeded()
            })
        }
    }
    
}
