# Squirrel
Squirrel language (http://squirrel-lang.org)

This repository uses **Squirrel 3.0.7 stable** as a base, but may evolve and depart from its original implementation.

## Differences from Squirrel 3.0.7 stable

### General
- Fixed a bunch of clang compiler and static analyzer warnings.

### API
- Added a default delegate for `null` values (currently empty, but can be customized from code)
- Added the following API to `SQVM` class:
 - `SQObjectPtr GetDefaultDelegateObject(const SQObjectType type) const;`, which returns the default delegate `SQObjectPtr` for a given `SQObjectType`
 - `SQTable *GetDefaultDelegate(const SQObjectPtr &self)`, which allows getting the default delegate `SQTable` for a given object without actually invoking anything on it (it seemed that existing APIs did not provide such functionality). Internally calls `GetDefaultDelegateObject`, so behavior is consistent between these methods
 - `sq_getdefaultdelegate` function now also relies on `GetDefaultDelegateObject` in its implementation.
 
### Metamethods
- Changed logic of object to string conversion: now the `_tostring()` metamethod of the default delegate is invoked if present, so customizing the default string representations of all object types is possible. If a table already has a delegate with a `_tostring()` metamethod present, it is invoked instead of the default delegate's implementation.
- Calling an object will try to use `_call` metamethod on its default delegate if usuall call mechanics are not available (this allows making `nulls` callable for example to mimic the Objective-C `nil` behavior which allows sending any messages to it and receiving `nil` back)
 
