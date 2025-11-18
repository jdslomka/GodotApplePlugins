import SwiftGodotRuntime

@Godot
class Hello: RefCounted {
    @Callable
    func sayHello(name: String) -> String {
        "Hello \(name)"
    }
}

#initSwiftExtension(cdecl: "godot_apple_hello", types: [Hello.self])
