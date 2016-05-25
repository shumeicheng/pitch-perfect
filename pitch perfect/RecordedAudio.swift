//
//  RecordedAudio.swift
//  pitch perfect
//
//  Created by Shu-Mei Cheng on 2/1/16.
//  Copyright © 2016 Shu-Mei Cheng. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl:NSURL!
    var title: String!
    func initit (url:NSURL, titleName:String){
        filePathUrl = url
        title = titleName
    }
}
