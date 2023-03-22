# MoSpec
Motoko specs that are easy to read and learn, allowing you to ship Motoko code with confidence.

## Credits
- Underneath the hood, it's using [Motoko Matchers](https://kritzcreek.github.io/motoko-matchers) of [Christoph Hegemann](https://github.com/kritzcreek)
- Empowered by [ActorSpec](https://github.com/dfinity/motoko-base/tree/e4efcb9bbd8c8eeff41b3d461b679e43d1d66f44/examples/actorspec) of [Joachim Breitner](https://github.com/nomeata)
- Based on the example [Motoko Unit Tests](https://github.com/krpeacock/motoko-unit-tests) of [Kyle Peacock](https://github.com/krpeacock)
- Based on the use of Mo-Dev on the packages testing of [Motoko Base](https://github.com/dfinity/motoko-base/)
- Heavily inspired by other Spec frameworks, mostly RSpec, but also Jest.

## Demo
In this repo, you will find an example of it's usage on the "example" folder.

## Architecture
There are some important concepts and architectural choices that is important to understand for any project to apply this library succesfuly.

**MoSpec** is composed of:
- Spec Core
- Spec Extensions
- Specs

---

**Spec Core** would typically be composed of:
- Spec Config
- Spec Collector
- Spec Runner

**Config** is where you can set the configs that affect ALL specs. Good examples would be: environment vars, some bootstrap config, strategies for cleaning up data, enable/disable extensions and it's configs, etc.

**Collector** this is where you set the paths to all the files you want to import and to run the "spec" against. Its only function is to collect files/modules and deliver it as an array to Spec Runner.

**Runner** is the executable that is being called and that actually runs all the specs. It starts by "bootstraping" with the config file, then asks the spec collector for an array of specs and runs each of them. It also collects data of how many were success, failed or skipped and presents a summary at the end. This file will be buried in the Lib and is not meant to be modified by the user.

---

**Spec Extensions** would be any outside library or supporting file to be used by the specs.

The use of **factories** are very common to mock input to the functions being tested. Allowing for these objects to be reused by several specs.

**Matchers** are needed because we want to be expressive whenever a message fails. So if a string is different, it can say "expected Foo, but got Bar". Things can easily complicate when needing to handle a Result record or checking if a Key / Value is present inside a HashMap. You will want to have a Matcher to help you out on these.

Another common use is the **recordings** of intercanister calls. If a pipeline is dependent on a live response, it will wait ~2 seconds for an update request, and this easily "slows down" a pipeline. 
Plus, any dependency on an external canister is unecessarily risky, as the canister could be temporarily down and you can't deploy your code. 
As a project scales you will want to control "when to look deeper and fix" an integration test. To make it easy, you will want to use recordings, that are automaticly recorded and replayed. If anything comes up, it's easy to recreate a recording, or if you want to deeply check your integration tests, just run specs without replay.

---

Last but not least, **specs** are the files/modules where you will write the specs in a clear 3 step layer:
- Setup
- Execute
- Assert

You should have one "spec file" per "src file" being tested, with similar structure as your src folder (eg.: src/Utils/Foo.mo -> spec/Utils/FooSpec.mo).

You should use descriptive strings, with the "describe", "context" and "it" blocks. Also variables should be descriptive. So that any future developer can easily skim through the english part, and only stop at the edge case that is relevant.

 ---
