import Foundation

struct RatingResponse: Codable {
    let result: String
    let statistics: [String: RatingStatistics]
}

struct RatingStatistics: Codable {
    let comments: RatingComments
    let rating: Rating
    let follows: Int
}

struct RatingComments: Codable {
    let threadId: Int
    let repliesCount: Int
}

struct Rating: Codable {
    let average: Double
    let bayesian: Double
    let distribution: [String : Int]
}
