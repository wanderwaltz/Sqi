//
//  context.nut
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


function new_context(id, delegate) {
  local context = {};

  context.name <- id;
  context.contexts <- [];
  context.examples <- [];

  context.setdelegate(delegate);
  return context;
}


function enumerate_examples(parent_id, context, func) {
  foreach (example in context.examples) {
    local child_id = composite_example_id(parent_id, example.name);
    func(child_id, example);
  }
}


function enumerate_child_contexts(parent_id, context, func) {
  foreach (child_context in context.contexts) {
    local child_id = composite_context_id(parent_id, child_context.name);
    func(child_id, child_context);
    enumerate_child_contexts(child_id, child_context, func);
  }
}


function composite_example_id(parent_id, child_id) {
  return parent_id + ", it " + child_id;
}


function composite_context_id(parent_id, child_id) {
  return parent_id + ", " + child_id;
}
