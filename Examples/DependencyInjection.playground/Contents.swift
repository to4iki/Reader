import Reader

// MARK: - Dependency module

protocol Module {
    var userService: UserServiceType { get }
    var tweetService: TweetServiceType { get }
}

struct ProductionModule: Module {
    var userService: UserServiceType { return UserService.shared }
    var tweetService: TweetServiceType { return TweetService.shared }
}

struct TestModule: Module {
    var userService: UserServiceType { return MockUserService(user: nil) }
    var tweetService: TweetServiceType { return MockTweetService(tweets: []) }
}

// MARK: - Execution

func userAction(with id: User.Id) -> Reader<Module, User?> {
    return Reader { module in module.userService.find(by: id) }
}

func tweetsAction(with userName: String) -> Reader<Module, [Tweet]> {
    return Reader { module in module.tweetService.findAll(by: userName) }
}

userAction(with: "prod")
    .map { $0?.name ?? "" }
    .flatMap(tweetsAction)
    .execute(ProductionModule())
// [{text "name-prod-1"}, {text "name-prod-2"}, {text "name-prod-3"}]

userAction(with: "test")
    .map { $0?.name ?? "" }
    .flatMap(tweetsAction)
    .execute(TestModule())
// []
