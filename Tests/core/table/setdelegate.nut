//
//  core/table/setdelegate.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 16.09.15.
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

SqTest.spec("table", @{
    describe(@"setdelegate", @{
        it("sets the table's delegate", @{
            local delegate = {};
            local table = {};
            table.setdelegate(delegate);

            expect(table.getdelegate()).to().beIdenticalTo(delegate);
        });


        it("returns the receiver table", @{
            local delegate = {};
            local table = {};

            expect(table.setdelegate(delegate)).to().beIdenticalTo(table);
        });


        it("throws an error if trying to set a non-table object as a delegate", @{
            local table = {};

            expect(@()table.setdelegate(1)).to().throwError();
            expect(@()table.setdelegate(1.25)).to().throwError();
            expect(@()table.setdelegate(false)).to().throwError();
            expect(@()table.setdelegate(true)).to().throwError();
            expect(@()table.setdelegate("qwerty")).to().throwError();
            expect(@()table.setdelegate(function (){})).to().throwError();
        });


        it("throws an error if trying to set a simple circular delegate chain", @{
            local delegate = {};
            local table = {};
            table.setdelegate(delegate);

            expect(@()delegate.setdelegate(table)).to().throwError();
        });


        it("throws an error if trying to set a longer circular delegate chain", @{
            local table1 = {};
            local table2 = {};
            local table3 = {};
            table1.setdelegate(table2);
            table2.setdelegate(table3);

            expect(@()table3.setdelegate(table1)).to().throwError();
        });
    });
});