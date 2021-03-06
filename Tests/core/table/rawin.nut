//
//  core/table/rawin.nut
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
    describe("rawin", @{
        it("returns true if the table has the given key", @{
            local table = { key = "value" };
            expect(table.rawin("key")).to().equal(true);
        });


        it("returns false if the table does not have the given key", @{
            expect({}.rawin("key")).to().equal(false);
            expect({}.rawin(1)).to().equal(false);
        });

        context("when having a delegate", @{
            context("when having a delegate", @{
            it("does not invoke _get metamethod", @{
                local delegate = {};
                local invoked = {
                    value = false
                };
                delegate._get <- function(index) { invoked.value = true; return "invoked"; };

                local table = {};
                table.setdelegate(delegate);

                expect(table.rawin("asdfg")).to().equal(false);
                expect(invoked.value).to().equal(false);
            });
        });
        });
    });
});