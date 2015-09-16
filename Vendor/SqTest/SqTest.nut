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
::import("Spec/method", this);
::import("Spec/spec", this);
::import("Verifiers/verifiers", this);
::import("Verifiers/should_verifier", this);
::import("Verifiers/should_not_verifier", this);
::import("Matchers/matchers", this);
::import("Matchers/equal_matcher", this);
::import("Matchers/be_no_less_than_matcher", this);
::import("Matchers/be_negative_matcher", this);
::import("Matchers/be_identical_to_matcher", this);
::import("Matchers/have_slot_matcher", this);
::import("Matchers/throw_error_matcher", this);



function run(...) {
    local flags = {
        hide_successful = false
    };

    local invalid_arguments_error = @()("run: unexpected arguments list received: " + vargv +
                                        " (expected empty arguments list or a flags table)");

    if (vargv.len() == 1) {
        local table = vargv[0];
        if (typeof(table) != typeof(flags)) {
            throw invalid_arguments_error();
        }

        foreach (key, value in table) {
            flags[key] <- value;
        }
    }
    else if (vargv.len() != 0) {
        throw invalid_arguments_error();
    }

    local result = {
        failed_expectations  = 0
        unexpected_failures  = 0
        skipped_expectations = 0
        total_expectations   = 0
    };

    local print_successful = function(successful, string) {
        if (flags.hide_successful != successful) {
            print(string);
        }
    }

    enumerate_registered_examples(function(id, example, requirements_check) {
        if (requirements_check != null) {
            print(id + " SKIPPED (" + requirements_check + ")\n");
            result.skipped_expectations += 1;
            return;
        }

        print_successful(true, id + " ");
        result.total_expectations += 1;

        try {
            example.block.bindenv(example)();

            foreach (expectation in example.expectations) {
                local valid = expectation.verifier.verify();
                if (valid == false) {
                    result.failed_expectations += 1;

                    print_successful(false, id + " ");
                    print("FAILED: " + expectation.verifier.result());
                    print_successful(false, "\n");
                    break;
                }
            }
        }
        catch (error) {
            print_successful(false, id + " ");
            print("FAILED (unexpected): " + error);
            print_successful(false, "\n");
            result.failed_expectations += 1;
            result.unexpected_failures += 1;
        }
        print_successful(true, "\n");
    });

    print("\n");
    print("Total expectations: " + result.total_expectations + "\n");
    print("Skipped expectations: " + result.skipped_expectations + "\n");
    print("Failed expectations: " + result.failed_expectations);
    if (result.unexpected_failures > 0) {
        print(" (" + result.unexpected_failures + " unexpected)");
    }
    print("\n");
}


function spec(what, how) {
    local spec = new_spec(what);
    how.bindenv(spec)();
}


function shared_spec(what, method_name, how) {
    local spec = new_shared_spec(what, method_name);
    spec.block <- how;
}


function method(which) {
    return new_method_expectation(which, this);
}


function import_spec(path, constant = null, required_semver = null) {
    if (constant != null) {
        local constants = getconsttable();
        local failed = false;

        if ((constant in constants) == false) {
            failed = true;
        }
        else if (compare_semver(constants[constant], required_semver) < 0) {
            failed = true;
        }

        print("'" + path + "' import SKIPPED (" +
                constant + " >= " + required_semver + " requirement is not met)");
        return;
    }

    ::import(path);
}


function requires(constant, semver) {
    requirements_table()[constant] <- semver;
}


function describe(what, how) {
    local context = new_context(what, this);

    contexts.push(context);
    how.bindenv(context)();
}

context <- describe;


function it(what, how) {
    local example = new_example(what, this);
    example.block <- how;

    examples.push(example);
}


function compare_semver(lhs, rhs) {
    local kIndex = "index";
    local kValue = "value";

    function pair(index, value) {
        local result = {};
        result[kIndex] <- index;
        result[kValue] <- value;

        return result;
    }

    function extractNumber(string, startIndex) {
        if (startIndex == null) {
            return pair(null, "0");
        }

        local dotIndex = string.find(".", startIndex+1);
        local value    = "0";

        if (dotIndex != null) {
            value = string.slice(startIndex+1, dotIndex);
        }
        else {
            value = string.slice(startIndex+1, string.len());
        }

        return pair(dotIndex, value);
    }

    local leftToken = pair(-1, 0);
    local rightToken = pair(-1, 0);

    do {
        leftToken = extractNumber(lhs, leftToken.index);
        rightToken = extractNumber(rhs, rightToken.index);

        // print(">> " + leftToken.index + " '" + leftToken.value + "' | " + rightToken.index + " '" + rightToken.value + "'\n");

        local compare = leftToken.value <=> rightToken.value;

        if (compare != 0) {
            return (compare > 0) ? 1 : -1;
        }

    } while ((leftToken.index != null) || (rightToken.index != null));

    return 0;
}

