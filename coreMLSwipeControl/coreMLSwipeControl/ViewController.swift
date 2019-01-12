//
//  ViewController.swift
//  coreMLSwipeControl
//
//  Created by Danny Ou on 2019-01-11.
//  Copyright © 2019 Danny Ou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let starImageView: UIImageView = {
        let imageView = UIImageView (image:UIImage(named: "star_first"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let descTxtview: UITextView = {
        let textView = UITextView ()
        
        
        let subTxt = NSMutableAttributedString(string: "Join us today to excel in your studies.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        
        subTxt.append(NSAttributedString(string: "\n \n Use our machine learning application to help you record notes faster and pay less attention on writing and more on lecture", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13),NSAttributedString.Key.foregroundColor:UIColor.gray]))
        
        textView.attributedText = subTxt
        textView.backgroundColor = UIColor (white: 1,alpha: 0)
        textView.textColor = .white
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    /*
    let captionTxtview: UITextView = {
        let textView = UITextView ()
        textView.text = "Use our machine learning application to help you record notes faster and less attention on writing and more on lecture"
        textView.backgroundColor = UIColor (white: 1,alpha: 0)
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Intro point
        view.backgroundColor = .blue
        //view.addSubview(starImageView)
        view.addSubview(descTxtview)
        //view.addSubview(captionTxtview)
        setupLayout()
    }

    private func setupLayout(){
        
        let topImageContainerView = UIView ()
        topImageContainerView.backgroundColor = .white
        view.addSubview(topImageContainerView)
        //topImageContainerView.frame = CGRect (x:0, y: 0, width: 100, height: 100)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        //topImageContainerView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        //topImageContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier:0.5).isActive = true
        
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        topImageContainerView.addSubview(starImageView)
        
        starImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        starImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        
        starImageView.heightAnchor.constraint(equalTo:topImageContainerView.heightAnchor, multiplier: 0.75).isActive = true
        
        
        
        //starImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        //starImageView.widthAnchor.constraint(equalToConstant:200).isActive = true
        //starImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        
        //descTxtview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descTxtview.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descTxtview.leadingAnchor.constraint(equalTo:view.leadingAnchor,constant: 40).isActive = true
        descTxtview.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -40).isActive = true
        descTxtview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        /*
        captionTxtview.topAnchor.constraint(equalTo: starImageView.bottomAnchor, constant: 180).isActive = true
        //captionTxtview.widthAnchor.constraint(equalToConstant: 200).isActive = true
        captionTxtview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        captionTxtview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        captionTxtview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:0).isActive = true
        */
        
    }
    
}

