//
//  spec.nut
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


registered_specs <- {}


function new_spec(what) {
    local spec = new_context(what, this);
    local same_key_specs = null;

    if ((what in registered_specs) == false) {
        same_key_specs = [];
        registered_specs[what] <- same_key_specs;
    }
    else {
        same_key_specs = registered_specs[what];
    }

    same_key_specs.append(spec);

    return spec;
}


function enumerate_registered_examples(func) {
    enumerate_registered_contexts(function(id, context, requirements_check) {
        enumerate_examples(id, context, requirements_check, function(id, example, check){
            func(id, example, check);
        });
    });
}


function enumerate_registered_contexts(func) {
    enumerate_registered_specs(function(spec_id, spec) {
        enumerate_child_contexts(spec_id, spec, null,
            function(child_id, context, requirements_check) {
                func(child_id, context, requirements_check);
            });
    });
}


function enumerate_registered_specs(func) {
    foreach (spec_id, same_key_specs in registered_specs) {
        foreach(index, spec in same_key_specs) {
            func(spec_id, spec);
        }
    }
}
