public struct User {
    public typealias Id = String
    public let id: Id
    public let name: String
}

public protocol UserServiceType {
    func find(by id: User.Id) -> User?
}

public struct UserService: UserServiceType {
    public static let shared = UserService()
    private init() {}

    public func find(by id: User.Id) -> User? {
        return User(id: id, name: "production")
    }
}

public struct MockUserService: UserServiceType {
    private let user: User?

    public init(user: User?) {
        self.user = user
    }

    public func find(by id: User.Id) -> User? {
        return user
    }
}
