import U "Utils";
import Debug "mo:base/Debug";

import MoSpec "../../../src/MoSpec";
type Group = MoSpec.Group;

let assertTrue = MoSpec.assertTrue;
let describe = MoSpec.describe;
let it = MoSpec.it;
let skip = MoSpec.skip;
let pending = MoSpec.pending;
let run = MoSpec.run;

let success = run([
  describe(
    "Example Test Suite",
    [
      describe(
        "Subgroup",
        [
          it(
            "should assess a boolean value",
            do {
              assertTrue(true);
            },
          ),
          it(
            "should sum two positive Nats",
            do {
              assertTrue(U.sum((1, 2)) == 3);
            },
          ),
          it(
            "should fail a check that doesn't match",
            do {
              assertTrue(U.sum((1, 2)) != 4);
            },
          ),
          skip(
            "should skip a test",
            do {
              // Useful for defining a test that is not yet implemented
              true;
            },
          ),
        ],
      ),
    ],
  ),
]);

if (success == false) {
  Debug.trap("Tests failed");
};
