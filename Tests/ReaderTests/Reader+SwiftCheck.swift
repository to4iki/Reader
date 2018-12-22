@testable import Reader
import SwiftCheck

extension Reader {
    static func pure(_ element: Element) -> Reader<Input, Element> {
        return Reader({ _ in element })
    }
}

extension Reader: Arbitrary where Element: Arbitrary {
    public static var arbitrary: Gen<Reader<Input, Element>> {
        return workFactoryGen.map(Reader.init)
    }
}

extension Reader where Element: Arbitrary {
    static var workFactoryGen: Gen<WorkFactory> {
        return Element.arbitrary.map { e -> WorkFactory in
            { (_: Input) in e }
        }
    }
}
