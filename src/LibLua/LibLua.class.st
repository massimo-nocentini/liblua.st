"
I bind functions in the Lua C API as described in https://www.lua.org/manual/5.4/.
"
Class {
	#name : 'LibLua',
	#superclass : 'FFILibrary',
	#instVars : [
		'implementation'
	],
	#classVars : [
		'ImplementationFFI',
		'ImplementationPrimitive'
	],
	#category : 'LibLua',
	#package : 'LibLua'
}

{ #category : 'class initialization' }
LibLua class >> initialize [

	ImplementationFFI := LibLuaFFIImplementation new.
	ImplementationPrimitive := LibLuaPrimitiveImplementation new
]

{ #category : 'creating' }
LibLua >> implementationFFI [

	^ ImplementationFFI
]

{ #category : 'creating' }
LibLua >> implementationPrimitive [

	^ ImplementationPrimitive
]

{ #category : 'accessing - platform' }
LibLua >> macLibraryName [
	"According to https://blog.spreendigital.de/2020/05/24/how-to-compile-lua-5-4-0-as-a-mac-os-x-dynamic-library/, 
	
	$ make macosx test MYCFLAGS=""-arch x86_64""
	$ echo 'liblua5.4.0.dylib: $(CORE_O) $(LIB_O)' >> src/makefile
	$ echo -e '\t$(CC) -dynamiclib -o $@ $^ $(LIBS) -arch x86_64 -compatibility_version 5.4.0 -current_version 5.4.0 -install_name @rpath/$@' >> src/makefile
	$ make -C src liblua5.4.0.dylib
	
	then adjust the install variable to also copy the dylib, then 
	
	$ sudo make install

	"

	^ FFIMacLibraryFinder findAnyLibrary:
		  #( 'liblua.a' 'liblua5.4.7.dylib' )
]

{ #category : 'accessing - platform' }
LibLua >> unix64LibraryName [
	"According to https://blog.spreendigital.de/2020/05/24/how-to-compile-lua-5-4-0-for-linux-as-a-shared-library/
	 change the Makefile with
	
$(LUA_A): $(BASE_O)
	$(AR) $@ $(BASE_O)
	$(RANLIB) $@
	$(CC) -shared -ldl -Wl,-soname,liblua$R.so -o liblua$R.so $? -lm $(MYLDFLAGS)
	
	 and compile with:
	
	make ""MYCFLAGS=-fPIC"" ""R=5.4.0""
	
	"

	^ FFIUnix64LibraryFinder findAnyLibrary:
		  { 'liblua5.4.7.so'. 'liblua5.4.6.so'. 'liblua5.4.4.so' }
]

{ #category : 'accessing - platform' }
LibLua >> win32LibraryName [

	^ FFIWindowsLibraryFinder findAnyLibrary: #( 'lua54.dll' )
]
