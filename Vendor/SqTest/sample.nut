SqTest <- {};
::import("SqTest", SqTest);

SqTest.spec("numbers", function(){
    describe("zero", function(){
        it("should not change the sum when added to any number", @() expect(0+5).to().equal(5));
        it("should set any multiplication result to zero", @() expect(0*5).to().equal(0));
    });

    describe("addition", function(){
        context("when adding two positive numbers", function() {
            // no expectations here, so the whole example will be skipped
        });
    });

    describe("multiplication", function(){
        context("when multiplying a positive and a negative number", function(){
            it("should result in a negative number", function(){
                expect(-2 * 5).to().beNegative();
            });

            it("absolute value should equal to multiplication of absolute values", function(){
                expect(abs(-2 * 5)).to().equal(abs(-2)*abs(5));
            });
        });
    });
});


SqTest.run();
