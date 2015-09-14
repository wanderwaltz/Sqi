## SqTest
A unit testing framework for Squirrel language (http://squirrel-lang.org) inspired by Kiwi-BDD and Rspec.

## Requirements
SqTest is being developed and tested using a [fork](https://github.com/wanderwaltz/Squirrel) of Squirrel3 language, which provides extended syntax and fetures. I'm trying to keep SqTest from using these features so it would be runnable by a vanilla Squirrel3 implementation, but it is possible that I've missed some new stuff, which is not available there.

It also depends currently on the import library of [Sqrat](http://scrat.sourceforge.net), but would work if any other implementation of the `import` function is provided, which runs a script from a file with a specified path.

## What does it look like
### Basic specs
````Squirrel
SqTest <- {};
::import("SqTest", SqTest);

SqTest.spec("string", function(){
    describe("slice", function(){
        it("returns a section of the string as new string", function(){
            expect("Hello, World!".slice(0,5)).to().equal("Hello");
            expect("Hello, World!".slice(1,4)).to().equal("ell");
        });

        context("if the second argument is omitted", function(){
            it("returns the string itself if the argument is zero", function(){
                expect("test".slice(0)).to().equal("test");
            });

            it("returns an empty string if the argument is equal to string length", function(){
                expect("test".slice(4)).to().equal("");
            });
        });
    });
});

SqTest.run();
````

### Shared specs/reuse
````Squirrel
SqTest.shared_spec("integer", "tointeger", @{
    describe(Method, @{
        it("returns the integer itself", @{
            expect((1)[Method]()).to().equal(1);
            expect((0)[Method]()).to().equal(0);
            expect((-1234)[Method]()).to().equal(-1234);
        });

        it("returns a `integer` value", @{
            expect(typeof((1)[Method]())).to().equal(typeof(0));
            expect(typeof((0)[Method]())).to().equal(typeof(0));
            expect(typeof((-1234)[Method]())).to().equal(typeof(0));
        });
    });
});

SqTest.spec("integer", @{
    method("tointeger").behaves_like("integer", "tointeger");
});

SqTest.spec("integer", @{
    method("weakref").behaves_like("integer", "tointeger");
});
````
### Optional specs
Optional spec is run only if the specified constant exists with a version 
number no less than the required version.
````Squirrel
describe("null", function(){
    requires("SQXTD_NULL_EXTENSION_VERSION", "0.0.1");
    // Will run only if there is a SQXTD_NULL_EXTENSION_VERSION constant
    // with version value no less than 0.0.1

    context("when indexing", function(){
        it("should allow getting a null value for any literal key",
            @() expect(null.someKey).to().equal(null));

        it("should allow getting a null value for any string key",
            @() expect(null["some string key"]).to().equal(null));

        it("should allow getting a null value for any integer key",
            @() expect(null[123]).to().equal(null));
    });

    context("when setting values", function(){
        it("should allow setting a value for any key",
            @() expect((null.key = "value")).to().equal("value"));
    });
});
````
### More
More examples of test specs using SqTest could be found in the [Sqi](https://github.com/wanderwaltz/Sqi) repository.
See https://github.com/wanderwaltz/Sqi/tree/master/Tests for more specs.

## What does the output look like
````
string, tointeger, it converts the string to integer and returns it 
string, tointeger, it returns an integer 
string, tointeger, it ignores leading whitespaces 
string, tointeger, it ignores subsequent invalid characters 
string, tointeger, it throws an error if the string cannot be converted to integer 
string, tointeger, it accepts + at the beginning of the string 
string, tointeger, it does not detect hexadecimal integers 
string, tointeger, it does not detect octal integers 
 
Total expectations: 8
Skipped expectations: 0
Failed expectations: 0
````
