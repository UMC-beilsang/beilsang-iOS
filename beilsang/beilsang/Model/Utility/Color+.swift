//
//  Color+.swift
//  beilsang
//
//  Created by Seyoung on 1/24/24.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(hex: String, alpha: Double = 1.0) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    //MARK: - Main Color
    
    static let bePrPurple500 = UIColor(hex: "#A9B5FF")
    static let beScPurple300 = UIColor(hex: "#CBD4FF")
    static let beScPurple400 = UIColor(hex: "#BEC8FF") 
    static let beScPurple500 = UIColor(hex: "#3070F8")
    static let beScPurple600 = UIColor(hex: "#7B87DB")
    static let beScPurple700 = UIColor(hex: "#5560B7")
    
    //MARK: - Semantic Color
    
    static let beWnRed500 = UIColor(hex: "#FF5664")
    static let beWnRed100 = UIColor(hex: "#FFE6DD")
    static let bePsBlue500 = UIColor(hex: "#4D84F9")
    static let bePsBlue100 = UIColor(hex: "#DBEBFE")
    
    //MARK: - CTA Color
    
    static let beCta = UIColor(hex: "#FB7A8E")
    
    //MARK: - Sub Color
    
    static let beMint500 = UIColor(hex: "#A9DEE2")
    static let beMint600 = UIColor(hex: "#7BB7C2")
    static let beNavy500 = UIColor(hex: "#5C6898")
    static let beRed100 = UIColor(hex: "#FFE6DD")
    static let beRed500 = UIColor(hex: "#FF5664")
    
    //MARK: - Text Color
    
    static let beTextWhite = UIColor(hex: "#FFFFFF")
    static let beTextEx = UIColor(hex: "#B1B1B1")
    static let beTextInfo = UIColor(hex: "#6C6C6C")
    static let beTextSub = UIColor(hex: "#464646")
    static let beTextDef = UIColor(hex: "#222222")
    
    //MARK: - Border Color
    
    static let beBorderDis = UIColor(hex: "#E6E6E6")
    static let beBorderDef = UIColor(hex: "#B1B1B1")
    static let beBorderAct = UIColor(hex: "#909090")
    
    //MARK: - Background Color
    
    static let beBgDef = UIColor(hex: "#FFFFFF")
    static let beBgCard = UIColor(hex: "#FDFDFD")
    static let beBgSub = UIColor(hex: "#F8F8F8")
    static let beBgDiv = UIColor(hex: "#E6E6E6")
    
    //MARK: - Icon Color
    
    static let beIconDis = UIColor(hex: "#D5D5D5")
    static let beIconDef = UIColor(hex: "#464646")
    
    // MARK: - Button Color
    
    static let beButtonNavi = UIColor(hex: "#5C6898")
    
}

