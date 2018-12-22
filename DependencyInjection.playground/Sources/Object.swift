public struct User {
    public typealias Id = String
    public let id: Id
    public let name: String
}

public struct Tweet {
    public let text: String
}

public protocol UserServiceType {
    func find(by id: User.Id) -> User?
}

public protocol TweetServiceType {
    func findAll(by userName: String) -> [Tweet]
}

public struct UserService: UserServiceType {
    public static let shared = UserService()
    private init() {}

    public func find(by id: User.Id) -> User? {
        return User(id: id, name: "name-\(id)")
    }
}

public struct MockUserService: UserServiceType {
    private let user: User?

    public init(user: User?) {
        self.user = user
    }

    public func find(by _: User.Id) -> User? {
        return user
    }
}

public struct TweetService: TweetServiceType {
    public static let shared = TweetService()
    private init() {}

    public func findAll(by userName: String) -> [Tweet] {
        return (1 ... 3).map { Tweet(text: "\(userName)-\($0)") }
    }
}

public struct MockTweetService: TweetServiceType {
    private let tweets: [Tweet]

    public init(tweets: [Tweet]) {
        self.tweets = tweets
    }

    public func findAll(by _: String) -> [Tweet] {
        return tweets
    }
}
