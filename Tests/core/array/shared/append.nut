//
//  append.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 08.09.15.
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

SqTest.shared_spec("array", "append", @{
    describe(Method, @{
        // Spec for append function is inspired by RubySpec
        // See https://github.com/rubyspec/rubyspec/blob/archive/core/array/append_spec.rb

        it("is a function", @{
            expect(typeof([][Method])).to().equal(typeof(@(){}));
        });

        it("pushes the object onto the end of the array", @{
            local array = [1, 2];
            array[Method](3);
            expect(array).to().equal([1, 2, 3]);
        });

        it("returns null (mutates the receiver in-place)", @{
            expect([][Method](1234)).to().equal(null);
        });

        it("correctly resizes the array", @{
            local array = [];
            expect(array.len()).to().equal(0);

            array[Method]("qwerty");
            expect(array.len()).to().equal(1);

            array[Method]("asdfg");
            expect(array.len()).to().equal(2);

            array[Method]("zxcvb");
            expect(array.len()).to().equal(3);
        });
    });
});
