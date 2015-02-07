//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Kyle Cabigon on 2/5/15.
//  Copyright (c) 2015 Kyle Cabigon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Containters
    var topContainer: UIView!
    var purchaseContainer: UIView!
    var mixContainer: UIView!
    var sellContainer: UIView!
    
    // Labels
    var dollarsLabel = UILabel()
    var lemonsLabel = UILabel()
    var icecubesLabel = UILabel()
    var steponeLabel = UILabel()
    var steptwoLabel = UILabel()
    var stepthreeLabel = UILabel()
    var lemonsForTwoLabel = UILabel()
    var icecubesForOneLabel = UILabel()
    var lemonsToPurchaseLabel = UILabel()
    var icecubesToPurchaseLabel = UILabel()
    var lemonMixLabel = UILabel()
    var iceMixLabel = UILabel()
    var lemonsToMixLabel = UILabel()
    var iceToMixLabel = UILabel()
    var sellContainerCaption = UILabel()
    
    // Buttons
    var lemonMinusButton: UIButton!
    var iceMinusButton: UIButton!
    var lemonPlusButton: UIButton!
    var icePlusButton: UIButton!
    
    var lemonMixMinusButton: UIButton!
    var iceMixMinusButton: UIButton!
    var lemonMixPlusButton: UIButton!
    var iceMixPlusButton: UIButton!
    
    var startDayButton: UIButton!
    
    // Variables
    var dollars = 10
    var lemons = 1
    var icecubes = 1
    var lemonsToPurchase = 0
    var icecubesToPurchase = 0
    var lemonsToMix = 0
    var icecubesToMix = 0
    
    // Start Day variables
    var lemonadeRatio:Float!
    var lemonadeMix:String!
    var numberOfCustomers:Int!
    var arrayOfCustomers:[String] = []
    var arrayOfMatches:[String] = []
    var dollarsEarned = 0
    
    // Contants
    var kSixteenth:CGFloat = 1.0/16.0
    var kEighth:CGFloat = 1.0/8.0
    var kFourth:CGFloat = 1.0/4.0
    var kHalf:CGFloat = 1.0/2.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initiateContainers()
        
    }
    
    func lemonMinusButtonPressed (button: UIButton) {
        if lemonsToPurchase > 0 && lemons > 0 {
            dollars += 2
            lemons -= 1
            lemonsToPurchase -= 1
            updateMoney()
            updateLemonsToPurchase()
            updateLemon()
        }
    }
    
    func lemonPlusButtonPressed (button: UIButton) {
        if dollars < 2 {
            showAlert("Not Enough Money", message: "You need at least $2 to buy a lemon")
        }
        else {
            dollars -= 2
            lemons += 1
            lemonsToPurchase += 1
            updateMoney()
            updateLemonsToPurchase()
            updateLemon()
        }
    }
    
    func iceMinusButtonPressed (button: UIButton) {
        if icecubesToPurchase > 0 && icecubes > 0 {
            dollars += 1
            icecubes -= 1
            icecubesToPurchase -= 1
            updateMoney()
            updateIcecubesToPurchase()
            updateIceCubes()
        }
    }
    
    func icePlusButtonPressed (button:UIButton) {
        if dollars < 1 {
            showAlert("Not Enough Money", message: "You need at least $1 to buy an ice cube")
        }
        else {
            dollars -= 1
            icecubes += 1
            icecubesToPurchase += 1
            updateMoney()
            updateIcecubesToPurchase()
            updateIceCubes()
        }
    }
    
    func lemonMixMinusButtonPressed (button: UIButton) {
        if lemonsToMix > 0 {
            lemons += 1
            lemonsToMix -= 1
            updateLemonsToMix()
            updateLemon()
        }
    }
    
    func lemonMixPlusButtonPressed (button: UIButton) {
        if lemons > 0 {
            lemons -= 1
            lemonsToMix += 1
            updateLemonsToMix()
            updateLemon()
        }
        else {
            showAlert("Not Enough Lemons", message: "You need at least 1 lemon to mix")
        }
        
    }
    
    func iceMixMinusButtonPressed (button: UIButton) {
        if icecubesToMix > 0 {
            icecubes += 1
            icecubesToMix -= 1
            updateIcecubesToMix()
            updateIceCubes()
        }
    }
    
    func iceMixPlusButtonPressed (button:UIButton) {
        if icecubes > 0 {
            icecubes -= 1
            icecubesToMix += 1
            updateIcecubesToMix()
            updateIceCubes()
        }
        else {
            showAlert("Not Enough Ice Cubes", message: "You need at least 1 Ice Cube to mix")
        }
    }
    
    func startDayButtonPressed (button:UIButton) {
        lemonadeRatio = Float(lemonsToMix)/Float(icecubesToMix)
        if lemonadeRatio < Float(1) {
            lemonadeMix = "diluted"
        }
        else if lemonadeRatio == Float(1) {
            lemonadeMix = "equal parts"
        }
        else {
            lemonadeMix = "acidic"
        }
        
        numberOfCustomers = Int(arc4random_uniform(UInt32(10)))
        for var i = 0; i <= numberOfCustomers; i++ {
            var tastePreference = Float(Float(arc4random())/Float(UINT32_MAX))
            if tastePreference <= Float(0.4) {
                arrayOfCustomers.append("acidic")
            }
            else if tastePreference <= Float(0.6) {
                arrayOfCustomers.append("equal parts")
            }
            else {
                arrayOfCustomers.append("diluted")
            }
        }
        
        for var i = 0; i < arrayOfCustomers.count; i++ {
            if arrayOfCustomers[i] == lemonadeMix {
                arrayOfMatches.append("Paid!")
                dollarsEarned += 1
            }
            else {
                arrayOfMatches.append("No Match, No Revenue")
            }
        }
        
        dollars += dollarsEarned
        updateMoney()
        
        println(lemonadeRatio)
        println(lemonadeMix)
        println(numberOfCustomers)
        println(arrayOfCustomers)
        println(arrayOfMatches)
        
        showAlert("Your Day", message: "\(numberOfCustomers + 1) customers visited your stand, \(dollarsEarned) of them bought your lemonade, and you've earned \(dollarsEarned) dollars")
        
        resetPurchaseAndMix()
        dollarsEarned = 0
        arrayOfCustomers = []
        arrayOfMatches = []
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initiateContainers () {
        
        // First container
        topContainer = UIView(frame: CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y, width: view.bounds.width, height: view.bounds.height * kFourth))
        topContainer.backgroundColor = UIColor(red: 0x2c/255, green: 0x3e/255, blue: 0x50/255, alpha: 1.0)
        view.addSubview(topContainer)
        
        // First container labels
        dollarsLabel.text = "You have $\(dollars)"
        textFormatLabels(dollarsLabel)
        centerLabel(dollarsLabel, container: topContainer, yvalue: 1.0)
        
        if lemons == 1 {
            lemonsLabel.text = "\(lemons) Lemon"
        }
        else {
            lemonsLabel.text = "\(lemons) Lemons"
        }
        textFormatLabels(lemonsLabel)
        centerLabel(lemonsLabel, container: topContainer, yvalue: 2.0)
        
        if icecubes == 1 {
            icecubesLabel.text = "\(icecubes) Ice Cube"
        }
        else {
            icecubesLabel.text = "\(icecubes) Ice Cubes"
        }
        textFormatLabels(icecubesLabel)
        centerLabel(icecubesLabel, container: topContainer, yvalue: 3.0)
        
        // Second container
        purchaseContainer = UIView(frame: CGRect(x: view.bounds.origin.x, y: topContainer.frame.height, width: view.bounds.width, height: view.bounds.height * kFourth))
        purchaseContainer.backgroundColor = UIColor(red: 0x34/255, green: 0x49/255, blue: 0x5e/255, alpha: 1.0)
        view.addSubview(purchaseContainer)
        
        // Second container labels
        steponeLabel.text = "Step 1: Purchase supplies"
        textFormatSteps(steponeLabel)
        stepsLabel(steponeLabel, container: purchaseContainer)
        
        lemonsForTwoLabel.text = "Lemons for $2:"
        textFormatLabels(lemonsForTwoLabel)
        dynamicLabel(lemonsForTwoLabel, container: purchaseContainer, xvalue: 2.0, yvalue: 2.0)
        
        icecubesForOneLabel.text = "Ice Cubes for $1:"
        textFormatLabels(icecubesForOneLabel)
        dynamicLabel(icecubesForOneLabel, container: purchaseContainer, xvalue: 2.0, yvalue: 3.0)
        
        lemonsToPurchaseLabel.text = "\(lemonsToPurchase)"
        textFormatLabels(lemonsToPurchaseLabel)
        dynamicLabel(lemonsToPurchaseLabel, container: purchaseContainer, xvalue: 6.0, yvalue: 2.0)
        
        icecubesToPurchaseLabel.text = "\(icecubesToPurchase)"
        textFormatLabels(icecubesToPurchaseLabel)
        dynamicLabel(icecubesToPurchaseLabel, container: purchaseContainer, xvalue: 6.0, yvalue: 3.0)
        
        // Second container buttons
        lemonMinusButton = UIButton()
        textFormatButtons(lemonMinusButton, name: "-")
        dynamicButton(lemonMinusButton, container: purchaseContainer, xvalue: 5.0, yvalue: 2.0)
        lemonMinusButton.addTarget(self, action: "lemonMinusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        purchaseContainer.addSubview(lemonMinusButton)
        
        lemonPlusButton = UIButton()
        textFormatButtons(lemonPlusButton, name: "+")
        dynamicButton(lemonPlusButton, container: purchaseContainer, xvalue: 7.0, yvalue: 2.0)
        lemonPlusButton.addTarget(self, action: "lemonPlusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        purchaseContainer.addSubview(lemonPlusButton)
        
        iceMinusButton = UIButton()
        textFormatButtons(iceMinusButton, name: "-")
        dynamicButton(iceMinusButton, container: purchaseContainer, xvalue: 5.0, yvalue: 3.0)
        iceMinusButton.addTarget(self, action: "iceMinusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        purchaseContainer.addSubview(iceMinusButton)
        
        icePlusButton = UIButton()
        textFormatButtons(icePlusButton, name: "+")
        dynamicButton(icePlusButton, container: purchaseContainer, xvalue: 7.0, yvalue: 3.0)
        icePlusButton.addTarget(self, action: "icePlusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        purchaseContainer.addSubview(icePlusButton)
        
        // Third container
        mixContainer = UIView(frame: CGRect(x: view.bounds.origin.x, y: purchaseContainer.frame.height + topContainer.frame.height, width: view.bounds.width, height: view.bounds.height * kFourth))
        mixContainer.backgroundColor = UIColor(red: 0x9b/255, green: 0x59/255, blue: 0xb6/255, alpha: 1.0)
        view.addSubview(mixContainer)
        
        // Third container labels
        steptwoLabel.text = "Step 2: Mix your lemonade"
        textFormatSteps(steptwoLabel)
        stepsLabel(steptwoLabel, container: mixContainer)
        
        lemonMixLabel.text = "Lemons in mix:"
        textFormatLabels(lemonMixLabel)
        dynamicLabel(lemonMixLabel, container: mixContainer, xvalue: 2.0, yvalue: 2.0)
        
        iceMixLabel.text = "Ice Cubes in mix:"
        textFormatLabels(iceMixLabel)
        dynamicLabel(iceMixLabel, container: mixContainer, xvalue: 2.0, yvalue: 3.0)
        
        lemonsToMixLabel.text = "\(lemonsToMix)"
        textFormatLabels(lemonsToMixLabel)
        dynamicLabel(lemonsToMixLabel, container: mixContainer, xvalue: 6.0, yvalue: 2.0)
        
        iceToMixLabel.text = "\(icecubesToMix)"
        textFormatLabels(iceToMixLabel)
        dynamicLabel(iceToMixLabel, container: mixContainer, xvalue: 6.0, yvalue: 3.0)
        
        //Third container buttons
        lemonMixMinusButton = UIButton()
        textFormatButtons(lemonMixMinusButton, name: "-")
        dynamicButton(lemonMixMinusButton, container: mixContainer, xvalue: 5.0, yvalue: 2.0)
        lemonMixMinusButton.addTarget(self, action: "lemonMixMinusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        mixContainer.addSubview(lemonMixMinusButton)
        
        lemonMixPlusButton = UIButton()
        textFormatButtons(lemonMixPlusButton, name: "+")
        dynamicButton(lemonMixPlusButton, container: mixContainer, xvalue: 7.0, yvalue: 2.0)
        lemonMixPlusButton.addTarget(self, action: "lemonMixPlusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        mixContainer.addSubview(lemonMixPlusButton)
        
        iceMixMinusButton = UIButton()
        textFormatButtons(iceMixMinusButton, name: "-")
        dynamicButton(iceMixMinusButton, container: mixContainer, xvalue: 5.0, yvalue: 3.0)
        iceMixMinusButton.addTarget(self, action: "iceMixMinusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        mixContainer.addSubview(iceMixMinusButton)
        
        iceMixPlusButton = UIButton()
        textFormatButtons(iceMixPlusButton, name: "+")
        dynamicButton(iceMixPlusButton, container: mixContainer, xvalue: 7.0, yvalue: 3.0)
        iceMixPlusButton.addTarget(self, action: "iceMixPlusButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        mixContainer.addSubview(iceMixPlusButton)
        
        // Fourth container
        sellContainer = UIView(frame: CGRect(x: view.bounds.origin.x, y: mixContainer.frame.height + purchaseContainer.frame.height + topContainer.frame.height, width: view.bounds.width, height: view.bounds.height * kFourth))
        sellContainer.backgroundColor = UIColor(red: 0x8e/255, green: 0x44/255, blue: 0xad/255, alpha: 1.0)
        view.addSubview(sellContainer)
        
        // Fourth container labels
        stepthreeLabel.text = "Step 3: Start selling your brew"
        textFormatSteps(stepthreeLabel)
        stepsLabel(stepthreeLabel, container: sellContainer)
        
        sellContainerCaption.text = "At the end of the day you will either make or lose money. If you don't have enough money to buy new inventory then you lose the game"
        sellContainerCaption.textColor = UIColor.whiteColor()
        sellContainerCaption.font = UIFont(name: "GeezaPro", size: 12)
        sellContainerCaption.numberOfLines = 0
        sellContainerCaption.frame = CGRect(x: sellContainer.bounds.origin.x + (kEighth * sellContainer.frame.width), y: sellContainer.bounds.origin.y + (kFourth * sellContainer.frame.height), width: sellContainer.frame.width - (2 * kEighth * sellContainer.frame.width), height: sellContainer.frame.height * 3 * kEighth)
        sellContainer.addSubview(sellContainerCaption)
        
        startDayButton = UIButton()
        textFormatButtons(startDayButton, name: "Start Day")
        startDayButton.backgroundColor = UIColor(red: 0x2e/255, green: 0xcc/255, blue: 0x71/255, alpha: 1.0)
        startDayButton.frame = CGRect(x: sellContainer.bounds.origin.x + (5 * kSixteenth * sellContainer.frame.width), y: sellContainer.bounds.origin.y + (5 * kEighth * sellContainer.frame.height), width: sellContainer.frame.width * 3 * kEighth, height: sellContainer.frame.height * kFourth)
        startDayButton.addTarget(self, action: "startDayButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        sellContainer.addSubview(startDayButton)
    }
    
    func centerLabel (label: UILabel, container: UIView, yvalue: CGFloat) {
        label.center = CGPoint(x: container.bounds.origin.x + (kHalf * container.frame.width), y: container.bounds.origin.y + (yvalue * kFourth * container.frame.height))
        container.addSubview(label)
    }
    
    func stepsLabel (label: UILabel, container: UIView) {
        label.frame = CGRect(x: container.bounds.origin.x + 10.0, y: container.bounds.origin.y + 10.0, width: container.frame.width, height: container.frame.height * kEighth)
        container.addSubview(label)
    }
    
    func dynamicLabel (label: UILabel, container: UIView, xvalue: CGFloat, yvalue: CGFloat) {
        label.center = CGPoint(x: container.bounds.origin.x + (xvalue * kEighth * container.frame.width), y: container.bounds.origin.y + (yvalue * kFourth * container.frame.height))
        label.textAlignment = NSTextAlignment.Center
        container.addSubview(label)
    }
    
    func textFormatSteps (label: UILabel) {
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "GeezaPro-Bold", size: 20.0)
        label.sizeToFit()
    }
    
    func textFormatLabels (label: UILabel) {
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "GeezaPro", size: 20.0)
        label.sizeToFit()
    }
    
    func textFormatButtons (button: UIButton, name: String) {
        button.setTitle(name, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont(name: "GeezaPro", size: 20.0)
        button.sizeToFit()
    }
    
    func dynamicButton (button: UIButton, container: UIView, xvalue: CGFloat, yvalue: CGFloat) {
        button.center = CGPoint(x: container.bounds.origin.x + (xvalue * kEighth * container.frame.width), y: container.bounds.origin.y + (yvalue * kFourth * container.frame.height))
    }
    
    func showAlert (header: String, message: String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func updateMoney() {
        dollarsLabel.text = "You have $\(dollars)"
        textFormatLabels(dollarsLabel)
        centerLabel(dollarsLabel, container: topContainer, yvalue: 1.0)
    }
    
    func updateLemon() {
        lemonsLabel.text = "\(lemons) Lemons"
        textFormatLabels(lemonsLabel)
        centerLabel(lemonsLabel, container: topContainer, yvalue: 2.0)
    }
    
    func updateIceCubes() {
        icecubesLabel.text = "\(icecubes) Ice Cubes"
        textFormatLabels(icecubesLabel)
        centerLabel(icecubesLabel, container: topContainer, yvalue: 3.0)
    }

    func updateLemonsToPurchase() {
        lemonsToPurchaseLabel.text = "\(lemonsToPurchase)"
    }
    
    func updateIcecubesToPurchase() {
        icecubesToPurchaseLabel.text = "\(icecubesToPurchase)"
    }
    
    func updateLemonsToMix() {
        lemonsToMixLabel.text = "\(lemonsToMix)"
    }
    
    func updateIcecubesToMix() {
        iceToMixLabel.text = "\(icecubesToMix)"
    }
    
    func resetPurchaseAndMix() {
        lemonsToPurchase = 0
        icecubesToPurchase = 0
        lemonsToMix = 0
        icecubesToMix = 0
        updateLemonsToPurchase()
        updateLemonsToMix()
        updateIcecubesToMix()
        updateIcecubesToPurchase()
    }
    
}

