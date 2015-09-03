//
//  SqTest.nut
//  SqTest
//
//  Created by Egor Chiglintsev on 13.08.15.
//  Copyright (c) 2015  Egor Chiglintsev
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

::import("Spec/expectation", this);
::import("Spec/context", this);
::import("Spec/spec", this);
::import("Verifiers/verifiers", this);
::import("Verifiers/should_verifier", this);
::import("Verifiers/should_not_verifier", this);
::import("Matchers/matchers", this);
::import("Matchers/equal_matcher", this);
::import("Matchers/be_negative_matcher", this);
::import("Matchers/have_slot_matcher", this);


function run() {
    local result = {
        failed_expectations = 0
        total_expectations = 0
    };

    enumerate_registered_examples(function(id, example) {
        print(id + " ");
        foreach (expectation in example.expectations) {
            result.total_expectations += 1;
            local valid = expectation.verifier.verify();
            if (valid == false) {
                result.failed_expectations += 1;
                print("FAILED: " + expectation.verifier.result());
            }
        }
        print("\n");
    });

    print("\n");
    print("Total expectations: " + result.total_expectations + "\n");
    print("Failed expectations: " + result.failed_expectations + "\n");
}


function spec(what, how) {
    assert(what in registered_specs == false);

    local spec = new_spec(what);
    how.bindenv(spec)();
}


function describe(what, how) {
    local context = new_context(what, this);

    contexts.push(context);
    how.bindenv(context)();
}

context <- describe;


function it(what, how) {
    local example = new_example(what, this);

    examples.push(example);
    how.bindenv(example)();
}
