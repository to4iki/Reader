import Reader

// MARK: - Dependency module

protocol Module {
    var userService: UserServiceType { get }
}

struct ProductionModule: Module {
    var userService: UserServiceType { return UserService.shared }
}

struct TestModule: Module {
    var userService: UserServiceType { return MockUserService(user: nil) }
}

// MARK: - Execution

func findUser(with id: User.Id) -> Reader<Module, User?> {
    return Reader { module in module.userService.find(by: id) }
}

findUser(with: "123")
    .map { $0?.name }
    .execute(ProductionModule()) // "production"

findUser(with: "123")
    .map { $0?.name }
    .execute(TestModule()) // nil
