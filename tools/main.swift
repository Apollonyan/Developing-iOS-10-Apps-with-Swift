//
//  main.swift
//  update
//
//  Created by Apollo Zhu on 3/12/17.
//  Copyright © 2017 WWITDC. All rights reserved.
//

import Foundation
import AppKit

/*
 # Video // src: 4. Views
 4. [Views](url)

 # Slides // src: Lecture 6 Slides
 6. [title](url)

 # Demo Code // src: Lecture 9 Demo Code: Smashtag
 9. [title](url)

 # Reading Assignment // src: Reading Assignment 2: More Swift
 2. [More Swift](url)

 # Programming Project // src: Programming Project 2: Calculator Brain
 2. [Calculator Brain](url)
 */
enum ResourceType: CustomStringConvertible, Hashable {
    // video/x-m4v
    case video
    // application/pdf
    case slides
    case demoCode
    case readingAssignment
    case programmingProject
    static let all: [ResourceType] = [.video, .slides, .demoCode, .readingAssignment, .programmingProject]
    var description: String {
        switch self {
        case .video: return "Video"
        case .slides: return "Slides"
        case .demoCode: return "Demo Code"
        case .readingAssignment: return "Reading Assignment"
        case .programmingProject: return "Programming Project"
        }
    }
    var hashValue: Int {
        return description.hashValue
    }
}

/* Example XML
 <entry>
 <author>
 <name>Paul Hegarty</name>
 </author>
 <title type="html">
 <![CDATA[ Lecture 9 Demo Code: Smashtag ]]>
 </title>
 <id>1/COETAIHAJLZIQXJI/MAEC2FBSEERRMTUH</id>
 <updated>2017-03-10T18:19:21PST</updated>
 <published>2017-03-10T17:36:29PST</published>
 <summary type="html">
 <![CDATA[ Lecture 9 Demo Code: Smashtag ]]>
 </summary>
 <link rel="enclosure" type="application/pdf" href="https://itunesu-assets.itunes.apple.com/apple-assets-us-std-000001/CobaltPublic111/v4/bd/b9/a3/bdb9a33e-0801-7cd3-5afc-849b44b0fa6d/316-1975239713004461915-L9_Demo_Code.pdf" length="63449"/>
 </entry>
 */
struct Resource: CustomStringConvertible {
    let index: Int
    let title: String
    let type: ResourceType
    let url: String
    init?(title: String?, rawtype: String?, url: String?) {
        guard let title = title, let rawtype = rawtype, let url = url else { return nil }
        self.url = url
        if rawtype == "video/x-m4v" {
            type = .video
        } else if title.contains("Reading Assignment") {
            type = .readingAssignment
        } else if title.contains("Programming Project") {
            type = .programmingProject
        } else if title.contains("Demo Code") {
            type = .demoCode
        } else {
            type = .slides
        }
        var parts = [String]()
        if type == .video {
            parts = title.components(separatedBy: ". ")
        } else if [.readingAssignment, .programmingProject].contains(type) {
            parts = title.components(separatedBy: ": ")
            parts[0] = parts[0].components(separatedBy: " ")[2]
        } else {
            parts.append(title.components(separatedBy: " ")[1])
            parts.append(title)
        }
        self.index = Int(parts[0])!
        self.title = parts[1]
    }
    var description: String {
        return "\(index). [\(title)](\(url))"
    }
}

class ParsingDelegate: NSObject, XMLParserDelegate {
    var resources = [Resource]()

    var title: String?
    var isParsingTitle = false
    var type: String?
    var url: String?

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        switch elementName {
        case "entry":
            if let resource = Resource(title: title, rawtype: type, url: url) {
                resources.append(resource)
            }
            title = nil
            isParsingTitle = false
            type = nil
            url = nil
        case "link":
            type = attributeDict["type"]
            url = attributeDict["href"]
        case "title":
            isParsingTitle = true
        default:
            break
        }
    }
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        if isParsingTitle {
            title = String(data: CDATABlock, encoding: .utf8) ?? "\(CDATABlock)"
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "title" {
            isParsingTitle = false
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        var out = ""
        let sorted = ResourceType.all.map { type in
            resources.filter({ $0.type == type }).sorted { $0.index < $1.index }
        }
        for (index, type) in ResourceType.all.enumerated() {
            out += "# \(type)\n\n"
            out += sorted[index].reduce("") { $0+"\($1)\n" }
            out += "\n"
        }

        let url = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).deletingLastPathComponent().appendingPathComponent("download.md")
        try! out.write(to: url, atomically: true, encoding: .utf8)
        NSWorkspace.shared().activateFileViewerSelecting([url])
    }
}

if let url = URL(string: "https://p1-u.itunes.apple.com/WebObjects/LZStudent.woa/ra/feed/COETAIHAJLZIQXJI"), let parser = XMLParser(contentsOf: url) {
    let delegate = ParsingDelegate()
    parser.delegate = delegate
    parser.parse()
}
