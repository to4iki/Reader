/// `Reader` is a wrapper for function that take some input and produce output.
/// - Input: for denpendency.
/// - Element: return a value type.
public struct Reader<Input, Element> {
    public typealias WorkFactory = (Input) -> Element

    private let workFactory: WorkFactory

    /// An instance of the `Reader<Input, Element>` with given function.
    ///
    /// - Parameter workFactory: Any function.
    public init(_ workFactory: @escaping WorkFactory) {
        self.workFactory = workFactory
    }

    /// Execute the reader
    ///
    /// - Parameter input: A Dependency value.
    /// - Returns: Extracts the final value.
    public func execute(_ input: Input) -> Element {
        return workFactory(input)
    }

    /// Returns a reader of mapping the given closure over the this `Element`.
    ///
    /// - Parameter transform: A mapping closure.
    /// - Returns: A new reader transformed `Element` of this reader.
    public func map<T>(_ transform: @escaping (Element) -> T) -> Reader<Input, T> {
        return Reader<Input, T> { input in
            transform(self.execute(input))
        }
    }

    /// Returns a reader composed of this reader and result of gived closure
    ///
    /// - Parameter transform: A transforming closure.
    /// - Returns: A new reader by `transform`
    public func flatMap<T>(_ transform: @escaping (Element) -> Reader<Input, T>) -> Reader<Input, T> {
        return Reader<Input, T> { input in
            transform(self.execute(input)).execute(input)
        }
    }

    /// Returns a reader which combines two leaders
    ///
    /// - Parameters
    ///   - reader1: The first reader
    ///   - reader2: The second reader
    /// - Returns: A new combined reader
    public static func zip<Input, Element1, Element2>(_ reader1: Reader<Input, Element1>, _ reader2: Reader<Input, Element2>) -> Reader<Input, (Element1, Element2)> {
        return reader1.flatMap { element1 in
            reader2.map { element2 in (element1, element2) }
        }
    }
}
