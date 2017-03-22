//
//  main.swift
//  update
//
//  Created by Apollo Zhu on 3/12/17.
//  Copyright © 2017 WWITDC. All rights reserved.
//

import Foundation
import AppKit

// itunes.apple.com/us/course/developing-ios-10-apps-with-swift/id<#iTunesUCourseID#>
let iTunesUCourseID = 1198467120

enum ResourceType: String, CustomStringConvertible {
    // Raw Type: video/x-m4v, video/mp4
    case video = "Video"
    // Raw Type: application/pdf
    case slides = "Slides"
    case demoCode = "Demo Code"
    case readingAssignment = "Reading Assignment"
    case programmingProject = "Programming Project"

    static let all: [ResourceType] = [.video, .slides, .demoCode, .readingAssignment, .programmingProject]

    var description: String {
        return self.rawValue
    }
}

struct Resource: CustomStringConvertible {
    let index: Int
    let title: String
    let type: ResourceType
    let url: String

    init(title: String, rawType: String, url: String) {
        self.url = url

        if rawType.contains("video") {
            type = .video
        } else if title.contains("Reading Assignment") {
            type = .readingAssignment
        } else if title.contains("Programming Project") {
            type = .programmingProject
        } else if title.contains("Demo Code") {
            type = .demoCode
        } else if title.contains("Slides") {
            type = .slides
        } else {
            fatalError("Unknown Raw Type")
        }

        var parts: [String]
        if type == .video {
            // 4. Views -> index: 4, title: Views
            parts = title.components(separatedBy: ". ")
        } else if [.readingAssignment, .programmingProject].contains(type) {
            // Reading Assignment 2: More Swift -> index: 2, title: More Swift
            // Programming Project 2: Calculator Brain -> index: 2, title: Calculator Brain
            parts = title.components(separatedBy: ": ")
            parts[0] = parts[0].components(separatedBy: " ")[2]
        } else {
            // Lecture 6 Slides -> index: 6, title: Lecture 6 Slides
            // Lecture 9 Demo Code: Smashtag -> index: 9, title: Lecture 9 Demo Code: Smashtag
            parts = [title.components(separatedBy: " ")[1], title]
        }
        self.index = Int(parts[0])!
        self.title = parts[1]
    }

    var description: String {
        return "\(index). [\(title)](\(url))"
    }
}

/* Example XML
 <entry>
 <author>
 <name>Paul Hegarty</name>
 </author>
 <title type="html">
 <![CDATA[ <#Title#> ]]>
 </title>
 <id>1/COETAIHAJLZIQXJI/MAEC2FBSEERRMTUH</id>
 <updated>2017-03-10T18:19:21PST</updated>
 <published>2017-03-10T17:36:29PST</published>
 <summary type="html">
 <![CDATA[ Lecture 9 Demo Code: Smashtag ]]>
 </summary>
 <link rel="enclosure" type="<#Raw Type#>" href="<#URL#>" length="63449"/>
 </entry>
 */
class ParsingDelegate: NSObject, XMLParserDelegate {
    var resources = [Resource]()

    var title: String?
    var isParsingTitle = false
    var type: String?
    var url: String?

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "link" {
            type = attributeDict["type"]
            url = attributeDict["href"]
        } else if elementName == "title" {
            isParsingTitle = true
        }
    }

    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        if isParsingTitle {
            title = String(data: CDATABlock, encoding: .utf8)!
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "title" {
            isParsingTitle = false
        } else if elementName == "entry" {
            resources.append(Resource(title: title!, rawType: type!, url: url!))
            title = nil
            isParsingTitle = false
            type = nil
            url = nil
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        let sorted = ResourceType.all.map { type in
            resources.filter { $0.type == type } .sorted { $0.index < $1.index }
        }

        var out = ""
        for (index, type) in ResourceType.all.enumerated() {
            if sorted[index].count > 0 {
                out += "# \(type)\n\n"
                    + "\(sorted[index].reduce("") { "\($0)\($1)\n" })\n"
            }
        }

        let cwd = CommandLine.arguments.first { $0.contains("main.swift") } ?? FileManager.default.currentDirectoryPath
        let url = URL(fileURLWithPath: cwd).deletingLastPathComponent().appendingPathComponent("download.md")
        do {
            try out.write(to: url, atomically: true, encoding: .utf8)
            NSWorkspace.shared().activateFileViewerSelecting([url])
        } catch {
            print(out)
        }
    }
}

let url = URL(string: "https://itunesu.itunes.apple.com/WebObjects/LZDirectory.woa/ra/directory/courses/\(iTunesUCourseID)/feed")!
let parser = XMLParser(contentsOf: url)!
let delegate = ParsingDelegate()
parser.delegate = delegate
parser.parse()
