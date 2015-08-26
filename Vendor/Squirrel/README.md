# Squirrel
Squirrel language (http://squirrel-lang.org)

This repository uses **Squirrel 3.0.7 stable** as a base, but may evolve and depart from its original implementation.

## Differences from Squirrel 3.0.7 stable

- Fixed a bunch of clang compiler and static analyzer warnings.
- Changed logic of object to string conversion: now the `_tostring()` metamethod of the default delegate is invoked if present, so customizing the default string representations of all object types is possible. If a table already has a delegate with a `_tostring()` metamethod present, it is invoked instead of the default delegate's implementation.
- Added the following API to `SQVM` class: `SQTable *GetDefaultDelegate(const SQObjectPtr &self)`, which allows getting the default delegate table for a given object without actually invoking anything on it (it seemed that existing APIs did not provide such functionality). 
