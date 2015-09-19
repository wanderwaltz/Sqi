//
//  core/array/weakref.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 20.09.15.
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
    describe(@"weakref", @{
        it("returns a weakref", @{
            expect(typeof([].weakref())).to().equal(typeof([1,2,3,4,5].weakref()));
            expect(typeof([].weakref())).notTo().equal(typeof([]));
        });

        it("returns an object not identical to the original array", @{
            local array = [1.0, "abc", false];
            expect(array.weakref() == array).to().equal(false);
        });

        it("returns an object corresponding to the same array", @{
            local array = [1.0, "abc", false];
            expect(array.weakref().ref()).to().beIdenticalTo(array);
        });
    });
});