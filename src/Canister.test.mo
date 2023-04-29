// @testmode interpreter

import Debug "mo:base/Debug";
import C "mo:matchers/Canister";
import M "mo:matchers/Matchers";
import T "mo:matchers/Testable";

import CanisterActor "Canister";

let deployedCanister = await CanisterActor.Canister();
let it = C.Tester({ batchSize = 8 });

func test() : async Text {
  it.should(
    "greet me",
    func() : async C.TestResult = async {
      let greeting = await deployedCanister.greet({ name = "Christoph" });
      if (greeting != "Hello, Christoph!") Debug.trap("Tests failed");

      M.attempt(greeting, M.equals(T.text("Hello, Christopher!")));
    },
  );

  it.shouldFailTo(
    "greet him-whose-name-shall-not-be-spoken",
    func() : async () = async {
      let greeting = await deployedCanister.greet({ name = "Voldemort" });
      ignore greeting;
    },
  );

  await it.runAll()
  // await it.run()
};
//};

await test();
