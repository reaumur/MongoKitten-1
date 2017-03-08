//
// This source file is part of the MongoKitten open source project
//
// Copyright (c) 2016 - 2017 OpenKitten and the MongoKitten project authors
// Licensed under MIT
//
// See https://github.com/OpenKitten/MongoKitten/blob/mongokitten31/LICENSE.md for license information
// See https://github.com/OpenKitten/MongoKitten/blob/mongokitten31/CONTRIBUTORS.md for the list of MongoKitten project authors
//
import Foundation


extension Collection {

    /// Returns documents in order of proximity to a specified point, from the nearest to farthest. geoNear requires a geospatial index.
    ///
    /// - parameters:
    ///   - options: Geo Near options
    ///   - readConcern: Specifies the read concern.
    /// - returns: a Document with the results
    /// - throws: When we can't send the request/receive the response, you don't have sufficient permissions or an error occurred
    /// - SeeAlso : https://docs.mongodb.com/manual/reference/command/geoNear/
    func geoNear(options: GeoNearOptions, readConcern: ReadConcern? = nil) throws -> Document {
        var command: Document = ["geoNear": self.name,
         "near":options.near,
         "spherical": options.spherical,
         "distanceField": options.distanceField,
         "limit": options.limit,
         "minDistance": options.minDistance,
         "maxDistance": options.maxDistance,
         "query": options.query,
         "distanceMultiplier": options.distanceMultiplier,
         "uniqueDocs": options.uniqueDocs,
         "includeLocs": options.includeLocs]

        command["readConcern"] = readConcern ?? self.readConcern

        let reply = try database.execute(command: command, writing: false)

        guard let responseDoc = reply.documents.first, Int(responseDoc["ok"]) == 1 else {
            throw MongoError.invalidResponse(documents: reply.documents)
        }

        return try firstDocument(in: reply)
    }
}
