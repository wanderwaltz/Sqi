//
//  len.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 07.09.15.
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

SqTest.spec("array", @{
    describe("len", @{
        // Spec for len function is inspired by RubySpec
        // See https://github.com/rubyspec/rubyspec/blob/archive/core/array/shared/length.rb

        it("is a function", @{
            expect(typeof([].len)).to().equal(typeof(@(){}));
        });

        it("returns the number of elements in the array", @{
            expect([].len()).to().equal(0);
            expect([1, "abc", 3.0].len()).to().equal(3);
        });


        it("properly handles recursive arrays", @{
            local empty_recursive_array = [];
            empty_recursive_array.append(empty_recursive_array);

            local recursive_array = [1, "abc", 3.0];
            for (local i = 0; i < 5; ++i) {
                recursive_array.append(recursive_array);
            }

            expect(empty_recursive_array.len()).to().equal(1);
            expect(recursive_array.len()).to().equal(8);
        });
    });
});
