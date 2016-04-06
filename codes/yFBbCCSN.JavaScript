Object.defineProperty(
        window,
        'CString',
        {
            enumerable: true,
            configurable: false,
            writable: false,
            value: function( newValue ) {
                var stringValue = null;
                
                Object.defineProperty(
                    this,
                    'get',
                    {
                        enumerable: true,
                        configurable: false,
                        writable: false,
                        value: function() {
                            return stringValue;
                        }
                    }
                );
                
                Object.defineProperty(
                    this,
                    'set',
                    {
                        enumerable: true,
                        configurable: false,
                        writable: false,
                        value: function( value ) {
                            if ( typeof value !== 'string' )
                                throw new Error( 'not string' );
                            
                            stringValue = value;
                        }
                    }
                );
                
                if ( newValue ) {
                    this.set( newValue );
                    return stringValue;
                }
            }
        }
    );